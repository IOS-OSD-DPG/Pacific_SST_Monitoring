library(dplyr)
library(ggplot2)
library(pals)
library(mapdata)
theme_set(theme_bw())
reg = map_data("world2Hires")
reg = subset(reg, region %in% c('Canada', 'USA'))
reg$long = (360 - reg$long)*-1


#######
datavar = "MODISA" # "MODISA" or "OI"
#######
datasource = "https://oceandata.sci.gsfc.nasa.gov"
#######
line_p <- data.frame(stn = c("P4", "P12", "P16", "P20", "P26"),
                     lat = c(48.65, 48.97, 49.283, 49.567, 50.),
                     lon = c(-126.67,-130.67,-134.67,-138.67,-145.))

# Region limits:
latlim = c(30,61.5)
lonlim = c(-160,-120)
# latlim = c(47,52)
# lonlim = c(-130,-121)

# Aesthetics:
# "Boiling cauldron of death" palette 
# Re: Charles - Similar to pals::brewer.rdylbu 
death_cauldron = rev(c("#A50026", "#EA5839", "#F67B49", "#FB9F5A", "#FDBE70","#FDDA8A", "#FFFFBF","#EDF8DE", #reds
                       #"#ededed",
                       "#DAF0F6", "#BCE1EE", "#9ECFE3", "#80B6D6", "#649AC7", "#4A7BB7", "#3C59A6", "#313695"))
gmt_jet <- c("#000080", "#0000bf", "#0000FF", "#007fff", "#00FFFF", "#7fffff", 
             "#FFFFFF", 
             "#FFFF7F", "#FFFF00", "#ff7f00", "#FF0000", "#bf0000", "#820000")

# 7-day mean, sd, N
curr7days <- readRDS(paste0("data/",datavar,"_SST7day_rollingavgbackup_current.rds"))
# Climatological mean, sd, N
clim7days <- readRDS(paste0("data/",datavar,"_SST7day_rollingavgbackup_climatology.rds"))

curr_clim <- full_join(curr7days, clim7days, by = c("lon","lat"))
rm(curr7days, clim7days)
curr_clim$diff_7day_deg <- curr_clim$sst_7day-curr_clim$sst_7day_clim
# Calculate data outside 90th percentile / 1.3 times the SD
curr_clim$sd_1.3_pos <- (curr_clim$sst_7day_clim+(curr_clim$sst_7day_climsd*1.29))
curr_clim$sd_above <- curr_clim$sd_1.3_pos-curr_clim$sst_7day

start = unique(curr_clim$start_date)
end = unique(curr_clim$end_date)
start = start[!is.na(start)]
end = end[!is.na(end)]

# Most recent rolling 7-day average ####
curr_clim %>% 
  filter(!is.na(sst_7day),
         lat >= latlim[1],
         lat <= latlim[2],
         lon >= lonlim[1],
         lon <= lonlim[2],
         sst_7dayn > 1) %>% 
  ggplot() +
  geom_tile(aes(x = lon, y = lat, fill = sst_7day)) +
  scale_fill_gradientn(colours = jet(50), limits=c(0,30), breaks = c(0,5,10, 15, 20,25,30)) +
  geom_contour(aes(x = lon, y = lat, z = sst_7day), linewidth = 0.5,
               breaks = c(0,5,10, 15, 20,25,30), colour = "grey30") +
  guides(fill = guide_colorbar(barheight = 12, 
                               ticks.colour = "grey30", ticks.linewidth = 1.5,
                               frame.colour = "black", frame.linewidth = 1.5)) +
  theme(legend.position = "right",panel.background = element_rect(fill = "grey90")) +
  geom_point(data = line_p, aes(x = lon, y = lat), size = 1.2, shape = 15) +
  geom_text(data = line_p, aes(x = lon, y = lat, label = stn), nudge_y = -0.5, size = 3) +
  coord_quickmap(xlim = lonlim, ylim = latlim, expand = F) +
  labs(fill = expression("SST " ( degree*C)),
       title = paste(start, "to", end,"Mean Day SST"),
       subtitle = paste(datavar,"NRT Sea Surface Temperature"),
       caption = datasource) + xlab(NULL) + ylab(NULL) +
  scale_y_continuous(breaks = seq(min(latlim), max(latlim), 5)) +
  scale_x_continuous(breaks = seq(min(lonlim), max(lonlim),5)) +
  geom_polygon(data = reg, aes(x = long, y = lat, group = group), fill = "grey70", colour = "grey40", linewidth = 0.5)

ggsave(filename = paste0("figures/SST_",datavar,"_7-day_rollingavg_",end,".png"), 
       device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in")
ggsave(filename = paste0("SST_",datavar,"_7-day_rollingavg.png"), 
       device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in", dpi=250)

# 7-day climatology anomaly ####
curr_clim$diff_7day_deg[curr_clim$diff_7day_deg > 3] = 3
curr_clim$diff_7day_deg[curr_clim$diff_7day_deg < -3] = -3
curr_clim %>% 
  filter(!is.na(diff_7day_deg),
         lat >= latlim[1],
         lat <= latlim[2],
         lon >= lonlim[1],
         lon <= lonlim[2],
         sst_7dayn > 1) %>% 
  ggplot() +
  geom_tile(aes(x = lon, y = lat, fill = diff_7day_deg)) +
  scale_fill_gradientn(colours = gmt_jet, 
                       limits = c(-3,3), breaks = seq(-3,3,1)) +
  geom_contour(aes(x = lon, y = lat, z = sd_above, colour = "1.29 SD"), 
               linewidth = 0.3, breaks = 0) +
  scale_colour_manual(name = NULL, guide = "legend", values = c("1.29 SD" = "grey30")) +
  guides(fill = guide_colorbar(barheight = 12, 
                               ticks.colour = "black", ticks.linewidth = 1.5, 
                               frame.colour = "black", frame.linewidth = 1.5),
         colour = guide_legend(override.aes = list(linetype = 1, shape = NA))) +
  geom_point(data = line_p, aes(x = lon, y = lat), size = 1.2, shape = 15) +
  geom_text(data = line_p, aes(x = lon, y = lat, label = stn), nudge_y = -0.5, size = 3) +
  
  theme(legend.position = "right",
        panel.background = element_rect(fill = "grey90")) +
  coord_quickmap(xlim = lonlim, ylim = latlim, expand = F) +
  labs(fill = expression("Anomaly " ( degree*C)),
       title = paste(start, "to", end,"SST Anomaly"),
       subtitle = paste(datavar,"NRT Sea Surface Temperature Anomaly"),
       caption = datasource) +
  xlab(NULL) + ylab(NULL) +
  scale_y_continuous(breaks = seq(min(latlim), max(latlim), 5)) +
  scale_x_continuous(breaks = seq(min(lonlim),max(lonlim),5)) +
  geom_polygon(data = reg, aes(x = long, y = lat, group = group), fill = "grey70", colour = "grey40", linewidth = 0.5)

ggsave(filename = paste0("figures/SST_",datavar,"_7-day_rollingavg_anom_",end,".png"), 
       device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in")
ggsave(filename = paste0("SST_",datavar,"_7-day_rollingavg_anom.png"), 
       device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in", dpi=250)


# Number of pixels: #### 
# (Only do for MODISA, as OI is same everywhere)
curr_clim$sst_7dayn[is.na(curr_clim$sst_7day)] <- 0
curr_clim %>% 
    filter(!is.na(sst_7dayn),
           lat >= latlim[1],
           lat <= latlim[2],
           lon >= lonlim[1],
           lon <= lonlim[2]) %>% 
    ggplot() +
    geom_tile(aes(x = lon, y = lat, fill = sst_7dayn)) +
    scale_fill_gradientn(colours = c("grey90", "grey80", pals::jet(6)), breaks = seq(0,7,1), limits = c(0,7)) +
    # geom_contour(aes(x = lon, y = lat, z = sst_7dayn), linewidth = 0.5,
    #              breaks = c(5,10, 15, 20), colour = "black") +
    guides(fill = guide_colorbar(barheight = 12, ticks.linewidth = 1.5,
                                 frame.colour = "black", frame.linewidth = 1.5,
                                 nbin = 8, raster=F, ticks.colour = NA)) +
    theme(legend.position = "right",panel.background = element_rect(fill = "grey90")) +
    coord_quickmap(xlim = lonlim, ylim = latlim, expand = F) +
    labs(fill = 'Weekly \nObservations',
         title = paste(start, "to", end,"Day SST, Number of Observations"),
         subtitle = paste(datavar,"NRT Sea Surface Temperature"),
         caption = datasource) +
    xlab(NULL) + ylab(NULL) +
    scale_y_continuous(breaks = seq(min(latlim), max(latlim), 5)) +
    scale_x_continuous(breaks = seq(min(lonlim), max(lonlim),5)) +
    geom_polygon(data = reg, aes(x = long, y = lat, group = group), fill = "grey70", colour = "grey40", linewidth = 0.5)
  
  ggsave(filename = paste0("figures/SST_",datavar,"_7-day_rollingavg_n_",end,".png"), 
         device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in")
  ggsave(filename = paste0("SST_",datavar,"_7-day_rollingavg_n.png"), 
         device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in")
