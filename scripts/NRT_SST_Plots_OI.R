library(dplyr)
library(ggplot2)
library(mapdata)
library(pals)
theme_set(theme_bw())
reg = map_data("world2Hires")
reg = subset(reg, region %in% c('Canada', 'USA'))
reg$long = (360 - reg$long)*-1


#######
datavar = "OI"
#######
datasource = "Data source: https://doi.org/10.25921/RE9P-PT57"
#######
# buoys = source()

# Region limits:
latlim = c(30,61.5)
lonlim = c(-160,-120)

# Aesthetics:
# "Boiling cauldron of death" palette 
# Re: Charles - Similar to pals::brewer.rdylbu 
death_cauldron = rev(c("#A50026", "#EA5839", "#F67B49", "#FB9F5A", "#FDBE70","#FDDA8A", "#FFFFBF","#EDF8DE", #reds
                       "#DAF0F6", "#BCE1EE", "#9ECFE3", "#80B6D6", "#649AC7", "#4A7BB7", "#3C59A6", "#313695"))
# Plot rolling 7-day composite for datavar 
# 7-day mean, sd, N
curr7days <- readRDS(paste0("data/",datavar,"_SST7day_rollingavgbackup_current.rds"))
# Climatological mean, sd, N
clim7days <- readRDS(paste0("data/",datavar,"_SST7day_rollingavgbackup_climatology.rds"))

curr_clim <- full_join(curr7days, clim7days, by = c("lon","lat"))
curr_clim$diff_7day_deg <- curr_clim$sst_7day-curr_clim$sst_7day_clim
# Calculate data outside 90th percentile / 1.3 times the SD
curr_clim$sd_1.3_pos <- (curr_clim$sst_7day_clim+(curr_clim$sst_7day_climsd*1.29))
curr_clim$sd_above <- curr_clim$sd_1.3_pos-curr_clim$sst_7day
curr_clim$perc90_above <- curr_clim$sst_7day_90-curr_clim$sst_7day
  
start = unique(curr_clim$start_date)
end = unique(curr_clim$end_date)
start = start[!is.na(start)]
end = end[!is.na(end)]

# Most recent rolling 7-day average ####
curr_clim %>% 
  filter(!is.na(sst_7day)) %>% 
  ggplot() +
  geom_tile(aes(x = lon, y = lat, fill = sst_7day)) +
  scale_fill_gradientn(colours = jet(50), limits=c(0,30), breaks = c(0,5,10, 15, 20,25,30)) +
  geom_contour(aes(x = lon, y = lat, z = sst_7day), size = 0.5,
               breaks = c(0,5,10, 15,20,25,30), colour = "black") +
  guides(fill = guide_colorbar(barheight = 12, 
                               ticks.colour = "black", ticks.linewidth = 1.5, 
                               frame.colour = "black", frame.linewidth = 1.5, order = 1),
         colour = guide_legend(override.aes = list(linetype = NA, shape = 15), order = 2)) +
  theme(legend.position = "right") +
  geom_point(aes(x = -145.0, y = 50, colour = "Station P"), size = 1.2, shape = 15) +
  scale_colour_manual(name = NULL, guide = "legend", 
                      values = c("Station P" = "black")) +
  coord_quickmap(xlim = lonlim, ylim = latlim, expand = F) +
  labs(fill = expression("SST " ( degree*C)),
       title = paste(start, "to", end,"Mean Day SST"),
       subtitle = paste(datavar,"NRT Sea Surface Temperature"),
       caption = datasource) + xlab(NULL) + ylab(NULL) +
  scale_y_continuous(breaks = seq(min(latlim), max(latlim), 5)) +
  scale_x_continuous(breaks = seq(min(lonlim), max(lonlim),5)) +
  geom_polygon(data = reg, aes(x = long, y = lat, group = group), fill = "grey70", colour = "grey40", size = 0.5) 
  # geom_point(data = buoys, aes(x = long, y = lat), size = 0.1, colour = "black")

ggsave(filename = paste0("figures/SST_",datavar,"_7-day_rollingavg_",end,".png"), 
       device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in")
ggsave(filename = paste0("SST_",datavar,"_7-day_rollingavg.png"), 
       device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in", dpi=250)

# 7-day climatology anomaly ####
curr_clim$diff_7day_deg[curr_clim$diff_7day_deg > 3] = 3
curr_clim$diff_7day_deg[curr_clim$diff_7day_deg < -3] = -3
curr_clim %>% 
  filter(!is.na(diff_7day_deg)) %>% 
  ggplot() +
  geom_tile(aes(x = lon, y = lat, fill = diff_7day_deg)) +
  scale_fill_gradientn(colours = death_cauldron, 
                       limits = c(-3,3), breaks = seq(-3,3,1)) +
  # geom_contour(aes(x = lon, y = lat, z = perc90_above), size = 0.5,
  #              breaks = c(0), colour = "green") +
  geom_contour(aes(x = lon, y = lat, z = sd_above, colour = "1.29 SD"), 
               size = 0.5, breaks = 0) +
  scale_colour_manual(name = NULL, guide = "legend", 
                      values = c("1.29 SD" = "black",
                                 "Station P" = "black")) +
  guides(fill = guide_colorbar(barheight = 12, 
                               ticks.colour = "black", ticks.linewidth = 1.5, 
                               frame.colour = "black", frame.linewidth = 1.5),
         colour = guide_legend(override.aes = list(linetype = c(1, NA), shape = c(NA,15)))) +
  theme(legend.position = "right",panel.background = element_rect(fill = "grey80")) +
  coord_quickmap(xlim = lonlim, ylim = latlim, expand = F) +
  geom_point(aes(x = -145.0, y = 50, colour = "Station P"), size = 1.2, shape = 15) +
  labs(fill = expression("Anomaly " ( degree*C)),
       title = paste(start, "to", end,"SST Anomaly"),
       subtitle = paste(datavar,"NRT Sea Surface Temperature Anomaly"),
       caption = datasource) +
  xlab(NULL) + ylab(NULL) +
  scale_y_continuous(breaks = seq(min(latlim), max(latlim), 5)) +
  scale_x_continuous(breaks = seq(min(lonlim),max(lonlim),5)) +
  geom_polygon(data = reg, aes(x = long, y = lat, group = group), fill = "grey70", colour = "grey40", size = 0.5)

ggsave(filename = paste0("figures/SST_",datavar,"_7-day_rollingavg_anom_",end,".png"), 
       device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in")
ggsave(filename = paste0("SST_",datavar,"_7-day_rollingavg_anom.png"), 
       device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in", dpi=250)
