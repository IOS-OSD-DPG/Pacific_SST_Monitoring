# Near real-time plots of SST and anomalies using CoastWatch Data
rm(list=ls())
library(rerddap)
library(dplyr)
options(dplyr.summarise.inform = FALSE)
library(ggplot2)
library(lubridate)
theme_set(theme_bw())
library(lubridate)

# Area
latlim = c(30,61.5) #c(10,60)
lonlim = c(-160,-120)

MODISPROCESS = TRUE
OIPROCESS = FALSE
MURPROCESS=FALSE

# Time limit:
# all_args <- commandArgs(trailingOnly=TRUE)
# if (length(all_args) ==1) {
#   end_date <- as.Date(all_args[1])
#   message(str(end_date))
# } else {
#   break
# }

# end_date <- Sys.Date() - 2
# Change so that it ends on nearest saturday
d = Sys.Date()-2 # Give 2 day buffer so that OI data can update!
lastweek = seq.Date(d, d-6, -1)
end_date = lastweek[which(wday(lastweek,label = T, abbr =T) == "Sat")]
if (wday(end_date, label = T) != "Sat") {
  break
}

# # MANUALLY ENTERING END DATE
# end_date = as.Date("2023-08-26")

# end_date <- Sys.Date() - 3
start_date = end_date-6 #-6 for 7 days, -13 for 2 weeks 
timelim = c(start_date, end_date)
message(timelim)
print(paste(yday(end_date)-yday(start_date)+1,"days"))

# Adding MUR data!

if (MURPROCESS == TRUE) {
  
  latlim = c(53.,55)
  lonlim = c(-133,-128)
  sstInfo = info("jplMURSST41anom1day", url = "https://coastwatch.pfeg.noaa.gov/erddap/")
  sstdata <- griddap(sstInfo, latitude = latlim, longitude = lonlim, 
                     time = timelim,
                     fields = c("sstAnom","mask"))$data
  # SST
  sstInfo = info("jplMURSST41", url = "https://coastwatch.pfeg.noaa.gov/erddap/")
  sstdata = griddap(sstInfo, latitude = latlim, longitude = lonlim, 
                    time = c(as.Date("2023-01-01"), as.Date("2023-08-22-31")),
                    fields = c("analysed_sst","mask","sea_ice_fraction","analysis_error"))$data
  # (2002-06-01T09:00:00Z, 2023-08-22T09:00:00Z)
  # 2003-2014 climatology: https://coastwatch.pfeg.noaa.gov/erddap/griddap/jplMURSST41clim.graph
  # Daily temp data https://coastwatch.pfeg.noaa.gov/erddap/griddap/jplMURSST41.graph
  
  sstdata = sstdata %>% filter(mask == 1) # Remove land (value of 2)
  print(paste(length(unique(sstdata$time)),"DAYS FOUND"))
  sstdata$time = as.POSIXct(sstdata$time)
  sstdata %>% 
    group_by(lon, lat) %>% 
    summarise(sst = mean(analysed_sst,na.rm=T)) %>% ungroup() %>% 
    # filter(dayOfYear == 225) %>% 
    ggplot(aes(x = lon, y = lat)) +
    # geom_tile(aes(fill = sstAnom)) +
    geom_tile(aes(fill = sst)) +
    scale_fill_gradientn(colours = pals::jet(20), limits = c(0,30)) +
    coord_quickmap(xlim = c(-132,-129.5),
                   ylim = c(53.25,54.5))
  
  # Make a north hecate plot
  lo=-131.14
  la=53.57
  lonlim=c(lo-0.02,lo+0.02)
  latlim = c(la-0.02,la+0.02)
  
  sstdata = sstdata %>% filter(lat > la-0.02,
                     lat < la+0.02,
                     lon < lo+0.02,
                     lon > lo-0.02)
  
  sstdata = griddap(sstInfo, latitude = latlim, longitude = lonlim, 
                    time = c(as.Date("2023-01-01"), as.Date("2023-08-22-31")),
                    fields = c("analysed_sst","mask","sea_ice_fraction","analysis_error"))$data
  
  str(sstdata)
  sst = sstdata
  sst %>% group_by(time) %>% summarise(mean_sst = mean(analysed_sst,na.rm=T)) %>% 
    ungroup() %>% 
    ggplot(aes(x = time, y = mean_sst)) +
    geom_point(data = t, aes(x = date, y = SSTP_mean_day), colour = "red") +
    geom_point() +
    ylim(0,25)
  
  t = sstmean %>% filter(STN_ID == "C46183", year(date) == 2023)
  t$date = as.POSIXct(t$date)
  
}


if (MODISPROCESS == TRUE) {
  
  # MODISA ####
  # Datasets: 
  # MODIS-Aqua SST masked, 2003-present,approx 4km resolution
  # Note that sci qual has a 120 day delay, NRT has 2 day delay
  # erdMH1sstd1dayR20190 (1-day SST, masked) 
  # erdMH1sstd7dayR20190SQ (8-day SST, science quality) - Says 90 days out of date but current to just over 1 month old
  # erdMH1sstdmdayR20190 (Monthly SST): 2019-01-01 to 2022-08-02
  # For monthly composites:
  # erdMH1sstdmdayR20190SQ (Current year science quality: lag of 120 days): 2003-01-01 to 2022-06-29
  
  # NOW:
  # erdMH1sstd1day_R2022NRTMasked: 2019-11-01 to 2022-09-04
  # erdMH1sstd1day_R2022SQMasked: 2002-07-04 to 2022-07-30
  
  # MODISA rolling 7-day average ####
  # sstInfo <- info("erdMH1sstd1dayR20190", url = "https://coastwatch.pfeg.noaa.gov/erddap/")
  sstInfo <- info("erdMH1sstd1day_R2022NRTMasked", url = "https://coastwatch.pfeg.noaa.gov/erddap/")
  
  
  sstdata <- griddap(sstInfo, latitude = latlim, longitude = lonlim, 
                     time = timelim)$data
  print(paste(length(unique(sstdata$time)),"DAYS FOUND"))
  
  sstdata_7day <- sstdata %>% 
    filter(!is.na(sstMasked),
           time >= start_date,
           time <= end_date) %>%
    group_by(lat, lon) %>% 
    summarise(sst_7day = mean(sstMasked, na.rm=T),
              sst_7daysd = sd(sstMasked, na.rm=T),
              sst_7dayn = sum(!is.na(sstMasked))) %>%
    ungroup() %>% 
    mutate(start_date = start_date,
           end_date = end_date)
  saveRDS(sstdata_7day, "data/MODISA_SST7day_rollingavgbackup_current.rds")
  
  # MODISA 7-day climatology ####
  # sstvar = info("erdMH1sstd1dayR20190SQ", url = "https://coastwatch.pfeg.noaa.gov/erddap/")
  sstvar = info("erdMH1sstd1day_R2022SQMasked", url = "https://coastwatch.pfeg.noaa.gov/erddap/")
  yr7days <- list()
  ct=1
  for (i in 2003:2020) {
    start = as.Date(paste0(i, yday(start_date)), format = "%Y%j")
    end = as.Date(paste0(i, yday(end_date)), format = "%Y%j")
    timesub = c(start, end)
    print(timesub)
    sstyr <- griddap(sstvar, latitude = latlim, longitude = lonlim, 
                     time = timesub)$data
    print(paste(length(unique(sstyr$time)), "DAYS FOUND"))
    
    roll7 = sstyr %>%
      filter(!is.na(sstMasked),
             yday(time) >= yday(start_date), 
             yday(time) <= yday(end_date)) %>% 
      group_by(lat, lon) %>%
      summarise(sst_7day = mean(sstMasked, na.rm=T),
                sst_7dayn = sum(!is.na(sstMasked))) %>%
      ungroup()
    if (nrow(roll7) > 0) {
      yr7days[[ct]] <- roll7
      ct=ct+1
    }
  }
  yr7days <- do.call(rbind, yr7days)
  
  yr7days <- yr7days %>% 
    filter(!is.na(sst_7day)) %>% 
    group_by(lat, lon) %>% 
    summarise(sst_7day_clim = mean(sst_7day, na.rm=T),
              sst_7day_climsd = sd(sst_7day, na.rm=T),
              sst_7day_climn = sum(sst_7dayn, na.rm = T)) %>% 
    ungroup()
  saveRDS(object = yr7days, file = "data/MODISA_SST7day_rollingavgbackup_climatology.rds")
  rm(roll7,sstyr, sstInfo)
}

if (OIPROCESS == TRUE) {
  # OI Data - Current and 30 year climatology (1990-2020) ####
  # Datasets: 
  # ncdcOisst21NrtAgg_LonPM180 (2020-present, 4-day lag)
  # ncdcOisst21Agg_LonPM180 (1981-present, 17-day lag)
  
  # OI Rolling 7-day average ####
  sstInfo = info("ncdcOisst21NrtAgg_LonPM180", url = "https://coastwatch.pfeg.noaa.gov/erddap/")
  sstdata <- griddap(sstInfo, latitude = latlim, longitude = lonlim, 
                     time = timelim,
                     fields = c("err","ice","sst"))$data
  print(paste(length(unique(sstdata$time)),"DAYS FOUND"))
  
  sstdata_7day <- sstdata %>% 
    filter(!is.na(sst),
           is.na(ice)) %>%
    group_by(lat, lon) %>% 
    summarise(sst_7day = mean(sst, na.rm=T),
              sst_7daysd = sd(sst, na.rm=T),
              sst_7dayn = sum(!is.na(sst))) %>% 
              # sumerror = sum(err, na.rm=T),
              # avgerr = mean(err,na.rm=T)) %>%
    ungroup() %>% 
    mutate(start_date = start_date,
           end_date = end_date)
  
  saveRDS(sstdata_7day, "data/OI_SST7day_rollingavgbackup_current.rds")
  
  # OI 7-day climatology ####
  sstvar = info("ncdcOisst21Agg_LonPM180", url = "https://coastwatch.pfeg.noaa.gov/erddap/")
  yr7days <- list()
  ct=1
  for (i in 1991:2020) {
    start = as.Date(paste0(i, yday(start_date)), format = "%Y%j")
    end = as.Date(paste0(i, yday(end_date)), format = "%Y%j")
    timesub = c(start, end)
    print(timesub)
    sstyr <- griddap(sstvar, latitude = latlim, longitude = lonlim, 
                     time = timesub,
                     fields = c("err","ice","sst"))$data
    print(paste(length(unique(sstyr$time)), "days"))
    roll7 = sstyr %>%
      filter(!is.na(sst),
             is.na(ice)) %>%
      group_by(lat, lon) %>%
      summarise(sst_7day = mean(sst, na.rm=T),
                sst_7dayn = sum(!is.na(sst))) %>%
      ungroup()
    
    yr7days[[ct]] <- roll7
    ct=ct+1
  }
  yr7days <- do.call(rbind, yr7days)
  
  yr7days <- yr7days %>% 
    filter(!is.na(sst_7day)) %>% 
    group_by(lat, lon) %>% 
    summarise(sst_7day_clim = mean(sst_7day, na.rm=T),
              sst_7day_climsd = sd(sst_7day, na.rm=T),
              sst_7day_climn = sum(sst_7dayn),
              sst_7day_90 = quantile(sst_7day, probs = 0.9)) %>% 
    ungroup()
  saveRDS(object = yr7days, file = "data/OI_SST7day_rollingavgbackup_climatology.rds")
  rm(roll7,sstyr)
  
}
gc()
# yr7days %>% ggplot(aes(x = lon, y = lat, fill = sst_7day_climsd)) +
# geom_tile() + scale_fill_gradientn(colours = pals::jet(20), limits = c(0,3)) +
  # ylab("test")
beepr::beep()
