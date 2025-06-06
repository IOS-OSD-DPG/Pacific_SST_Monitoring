library(dplyr)
library(ggplot2)
library(mapdata)
library(sf)
library(pals)
theme_set(theme_bw())
reg = map_data("world2Hires")
reg = subset(reg, region %in% c('Canada', 'USA'))
reg$long = (360 - reg$long)*-1

WRITE_GEOTIFF = TRUE
#######
datavar = "OI"
#######
datasource = "Data source: https://doi.org/10.25921/RE9P-PT57"
#######
line_p <- data.frame(stn = c("P4", "P12", "P16", "P20", "P26"),
                     lat = c(48.65, 48.97, 49.283, 49.567, 50.),
                     lon = c(-126.67,-130.67,-134.67,-138.67,-145.))

eez = st_as_sf(rgdal::readOGR("../Spatial_Data/BC_EEZ/BC_EEZ_oceanonly.shp"))
eez = st_transform(eez, 4326)

# Region limits:
latlim = c(30,61.5)
lonlim = c(-160,-120)

# Aesthetics:
# "Boiling cauldron of death" palette 
# Re: Charles - Similar to pals::brewer.rdylbu 
death_cauldron = rev(c("#A50026", "#EA5839", "#F67B49", "#FB9F5A", "#FDBE70","#FDDA8A", "#FFFFBF","#EDF8DE", #reds
                       "#DAF0F6", "#BCE1EE", "#9ECFE3", "#80B6D6", "#649AC7", "#4A7BB7", "#3C59A6", "#313695"))
gmt_jet <- c("#000080", "#0000bf", "#0000FF", "#007fff", "#00FFFF", "#7fffff", 
             "#FFFFFF", 
             "#FFFF7F", "#FFFF00", "#ff7f00", "#FF0000", "#bf0000", "#820000")

# Plot rolling 7-day composite for datavar 
# 7-day mean, sd, N
curr7days <- readRDS(paste0("data/",datavar,"_SST7day_rollingavgbackup_current.rds"))
# Climatological mean, sd, N
clim7days <- readRDS(paste0("data/",datavar,"_SST7day_rollingavgbackup_climatology.rds"))

curr_clim <- full_join(curr7days, clim7days, by = c("longitude","latitude"))
curr_clim$diff_7day_deg <- curr_clim$sst_7day-curr_clim$sst_7day_clim
# Calculate data outside 90th percentile / 1.3 times the SD
curr_clim$sd_1.3_pos <- (curr_clim$sst_7day_clim+(curr_clim$sst_7day_climsd*1.29))
curr_clim$sd_2.3_pos <- (curr_clim$sst_7day_clim+(curr_clim$sst_7day_climsd*2.326))
curr_clim$sd_above <- curr_clim$sd_1.3_pos-curr_clim$sst_7day
curr_clim$sd_above2 <- curr_clim$sd_2.3_pos-curr_clim$sst_7day
curr_clim$perc90_above <- curr_clim$sst_7day_90-curr_clim$sst_7day
  
start = unique(curr_clim$start_date)
end = unique(curr_clim$end_date)
start = start[!is.na(start)]
end = end[!is.na(end)]

# Most recent rolling 7-day average ####
s = curr_clim %>% 
  filter(!is.na(sst_7day)) %>% 
  ggplot() +
  geom_tile(aes(x = longitude, y = latitude, fill = sst_7day)) +
  scale_fill_gradientn(colours = jet(30), #cubicl(30),
                       limits=c(0,30), breaks = c(0,5,10, 15, 20,25,30)) +
  geom_contour(aes(x = longitude, y = latitude, z = sst_7day), linewidth = 0.5,
               breaks = c(0,5,10, 15,20,25,30), colour = "grey30") +
  guides(fill = guide_colorbar(barheight = 12, 
                               ticks.colour = "grey30", 
                               ticks.linewidth = 0.5, 
                               frame.colour = "black", 
                               frame.linewidth = 0.3,
                               order = 1),
         colour = guide_legend(override.aes = list(linetype = NA), order = 2)) +
  theme(legend.position = "right") +
  geom_point(data = line_p, aes(x = lon, y = lat), size = 1.2, shape = 15) +
  geom_text(data = line_p, aes(x = lon, y = lat, label = stn), nudge_y = -0.5, size = 3) +
  geom_sf(data = eez, linetype = "dotted") +
  # geom_point(data = buoys, aes(x = lon, y = lat), size = 1.2, shape = 3, colour = "white") +
  coord_sf(xlim = lonlim, ylim = latlim, expand = F) +
  labs(fill = expression("SST " ( degree*C)),
       title = paste(start, "to", end,"Mean Day SST"),
       subtitle = paste(datavar,"NRT Sea Surface Temperature"),
       caption = datasource) + xlab(NULL) + ylab(NULL) +
  scale_y_continuous(breaks = seq(min(latlim), max(latlim), 5)) +
  scale_x_continuous(breaks = seq(min(lonlim), max(lonlim),5)) + 
  geom_polygon(data = reg, aes(x = long, y = lat, group = group), fill = "grey70", colour = "grey40", linewidth = 0.5) 
  # geom_point(data = buoys, aes(x = long, y = lat), size = 0.1, colour = "black")

ggsave(plot = s, filename = paste0("figures/historical/SST_",datavar,"_7-day_rollingavg_",end,".png"), 
       device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in")
ggsave(plot = s, filename = paste0("figures/current/SST_",datavar,"_7-day_rollingavg.png"), 
       device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in", dpi=250)

# ggsave(plot = s, filename = paste0("figures/current/SST_",datavar,"_7-day_rollingavg_techreport.png"), 
       # device = "png", scale = 1.6, height = 3.5, units = "in", dpi=250)

# 7-day climatology anomaly ####
curr_clim$diff_7day_deg[curr_clim$diff_7day_deg > 3] = 3
curr_clim$diff_7day_deg[curr_clim$diff_7day_deg < -3] = -3
curr_clim %>% 
  filter(!is.na(diff_7day_deg)) %>% 
  ggplot() +
  geom_tile(aes(x = longitude, y = latitude, fill = diff_7day_deg)) +
  scale_fill_gradientn(colours = gmt_jet, 
                       limits = c(-3,3), breaks = seq(-3,3,1)) +
  # geom_contour(aes(x = longitude, y = latitude, z = perc90_above, colour = "90th perc"), linewidth = 0.7, breaks = c(0)) +
  geom_contour(aes(x = longitude, y = latitude, z = sd_above, colour = "1.29 SD"), linewidth = 0.5, breaks = 0) +
  geom_contour(aes(x = longitude, y = latitude, z = sd_above2, colour = "2.33 SD"),
               linewidth = 0.5, breaks = 0) +
  scale_colour_manual(name = NULL, guide = "legend", 
                      values = c(#"90th perc" = "purple",
                                 "1.29 SD" = "grey30", #"black",
                                 "2.33 SD" = "black"
                                 )
                      ) +
  guides(fill = guide_colorbar(barheight = 12, 
                               ticks.colour = "grey40", ticks.linewidth = 0.5, 
                               frame.colour = "black", frame.linewidth = 0.3,
                               order = 1),
         colour = guide_legend(override.aes = list(linetype = c(1), shape = c(NA)))) +
  theme(legend.position = "right", panel.background = element_rect(fill = "grey80")) +
  geom_point(data = line_p, aes(x = lon, y = lat), size = 1.2, shape = 15) +
  geom_text(data = line_p, aes(x = lon, y = lat, label = stn), nudge_y = -0.5, size = 3) +
  geom_sf(data = eez, linetype = "dotted") +
  coord_sf(xlim = lonlim, ylim = latlim, expand = F) +
  labs(fill = expression("Anomaly " ( degree*C)),
       title = paste(start, "to", end,"SST Anomaly"),
       subtitle = paste(datavar,"NRT Sea Surface Temperature Anomaly"),
       caption = datasource) +
  xlab(NULL) + ylab(NULL) +
  scale_y_continuous(breaks = seq(min(latlim), max(latlim), 5)) +
  scale_x_continuous(breaks = seq(min(lonlim),max(lonlim),5)) +
  geom_polygon(data = reg, aes(x = long, y = lat, group = group), fill = "grey70", colour = "grey40", linewidth = 0.5)

# ggsave(filename = paste0("techreport/SST_",datavar,"_7-day_rollingavg_anom_",end,".png"), 
       # device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in")


ggsave(filename = paste0("figures/historical/SST_",datavar,"_7-day_rollingavg_anom_",end,".png"), 
       device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in")
ggsave(filename = paste0("figures/current/SST_",datavar,"_7-day_rollingavg_anom.png"), 
       device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in", dpi=250)

# ggsave(filename = paste0("figures/current/SST_",datavar,"_7-day_rollingavg_anom_techreport.png"), 
       # device = "png", scale = 1.6, height = 3.5, units = "in", dpi=250)

# Write out data as geotiff




# Write out to geotiff ####
if (WRITE_GEOTIFF == TRUE) {
  library(raster)
  r = rasterFromXYZ(xyz = bind_cols(curr_clim$longitude, curr_clim$latitude, curr_clim$sst_7day), crs = 4326)
  c = rasterFromXYZ(xyz = bind_cols(curr_clim$longitude, curr_clim$latitude, curr_clim$sst_7day_clim), crs = 4326)
  sdmask_90 = rasterFromXYZ(xyz = bind_cols(curr_clim$longitude, curr_clim$latitude, curr_clim$sd_above), crs = 4326)
  sdmask_90[sdmask_90 >= 0] <- 0 
  sdmask_90[sdmask_90 < 0] <- 1
  
  sdmask_98 = rasterFromXYZ(xyz = bind_cols(curr_clim$longitude, curr_clim$latitude, curr_clim$sd_above2), crs = 4326)
  sdmask_98[sdmask_98 >= 0] <- 0 
  sdmask_98[sdmask_98 < 0] <- 1
  
  writeRaster(x = r, filename = "./data/OI_SST7day_current.tif", format="GTiff", NAflag = NaN, overwrite = T)
  writeRaster(x = c, filename = "./data/OI_SST7day_climatology_current.tif", format="GTiff", NAflag = NaN, overwrite = T)
  writeRaster(x = sdmask_90, filename = "./data/OI_SST7day_mask_SD1.29_current.tif", format="GTiff", NAflag = NaN, overwrite = T)
  writeRaster(x = sdmask_98, filename = "./data/OI_SST7day_mask_SD2.33_current.tif", format="GTiff", NAflag = NaN, overwrite = T)
}

