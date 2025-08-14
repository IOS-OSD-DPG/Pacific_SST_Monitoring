library(dplyr)
library(ggplot2)
library(pals)
theme_set(theme_bw())
bc = readRDS("./data/BC_bound_hres_bcmaps.rds")
usa = readRDS("./data/USA_bound_naturalearth.rds")
#######
datavar = "OI"
#######
# datasource = "Data source: https://doi.org/10.25921/RE9P-PT57"
datasource = ""
source("./scripts/POI_latlon.R")
#######

# Region limits:
latlim = c(49.5,55.5)
lonlim = c(-136,-126)

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
curr7days <- readRDS(paste0("data/",datavar,"_SST7day_rollingavgbackup_current.rds")) %>% 
  filter(latitude < latlim[2], latitude > latlim[1],
         longitude < lonlim[2], longitude > lonlim[1])
# Climatological mean, sd, N
clim7days <- readRDS(paste0("data/",datavar,"_SST7day_rollingavgbackup_climatology.rds")) %>% 
  filter(latitude < latlim[2], latitude > latlim[1],
         longitude < lonlim[2], longitude > lonlim[1])

curr_clim <- full_join(curr7days, clim7days, by = c("longitude","latitude"))
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
  geom_tile(aes(x = longitude, y = latitude, fill = sst_7day)) +
  scale_fill_gradientn(colours = jet(50), limits=c(0,30), breaks = c(0,5,10, 15, 20,25,30)) +
  geom_contour(aes(x = longitude, y = latitude, z = sst_7day), linewidth = 0.5,
               breaks = c(0,5,10, 15,20,25,30), colour = "grey30") +
  guides(fill = guide_colorbar(barheight = 12, 
                               ticks.colour = "grey30", ticks.linewidth = 0.5, 
                               frame.colour = "black", frame.linewidth = 0.3,
                               order = 1),
         colour = guide_legend(override.aes = list(linetype = NA), order = 2)) +
  theme(legend.position = "right") +
  geom_point(data = line_p, aes(x = lon, y = lat), size = 1.2, shape = 15) +
  geom_text(data = line_p, aes(x = lon, y = lat, label = stn), nudge_y = -0.5, size = 3) +
  # geom_point(data = buoys, aes(x = lon, y = lat), size = 1.2, shape = 3, colour = "white") +
  labs(fill = expression("SST " ( degree*C)),
       title = paste(start, "to", end,"Mean Daily SST"),
       subtitle = paste(datavar,"NRT Sea Surface Temperature"),
       caption = datasource) + xlab(NULL) + ylab(NULL) +
  scale_y_continuous(breaks = seq(min(latlim), max(latlim), 5)) +
  scale_x_continuous(breaks = seq(min(lonlim), max(lonlim),5)) + 
  # Add regions
  geom_polygon(data = GH_E, aes(x = lon, y = lat), colour = "black", fill = NA) +
  geom_polygon(data = GH_W, aes(x = lon, y = lat), colour = "black", fill = NA) +
  geom_polygon(data = GH_S, aes(x = lon, y = lat), colour = "black", fill = NA) +
  geom_polygon(data = GH_O, aes(x = lon, y = lat), colour = "black", fill = NA) +
  geom_text(aes(x = -130.6, y = 52.482, label = "GHE"), colour = "black", size = 3.5) +
  geom_text(aes(x = -132.4, y = 52.475, label = "GHW"), colour = "black", size = 3.5) +
  geom_text(aes(x = -131.0, y = 51.7, label = "GHS"), colour = "black", size = 3.5) +
  geom_text(aes(x = -132.2, y = 51.9, label = "GHO"), colour = "black", size = 3.5) +
  # Add buoys
  # geom_point(data = buoys, aes(x = lon, y = lat), shape = 21, size = 3) +
  geom_polygon(data = usa, aes(x = long, y = lat, group = group), fill = "grey60", colour = "grey40", linewidth = 0.5) +
  geom_polygon(data = bc, aes(x = long, y = lat, group = group), fill = "grey70", colour = "grey40", linewidth = 0.5) +
  coord_quickmap(xlim = lonlim, ylim = latlim, expand = F) # geom_point(data = buoys, aes(x = long, y = lat), size = 0.1, colour = "black")

ggsave(filename = paste0("figures/Haida_Gwaii/SST_",datavar,"_7-day_rollingavg_",end,"_HG.png"), 
       device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in")
ggsave(filename = paste0("figures/Haida_Gwaii/SST_",datavar,"_7-day_rollingavg_HG.png"), 
       device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in", dpi=250)

# 7-day climatology anomaly ####
curr_clim$diff_7day_deg[curr_clim$diff_7day_deg > 3] = 3
curr_clim$diff_7day_deg[curr_clim$diff_7day_deg < -3] = -3
curr_clim %>% 
  filter(!is.na(diff_7day_deg)) %>% 
  ggplot() +
  geom_tile(aes(x = longitude, y = latitude, fill = diff_7day_deg)) +
  scale_fill_gradientn(colours = gmt_jet, 
                       limits = c(-3,3), breaks = seq(-3,3,1)) +
  # geom_contour(aes(x = lon, y = lat, z = perc90_above), size = 0.5,
  #              breaks = c(0), colour = "green") +
  geom_contour(aes(x = longitude, y = latitude, z = sd_above, colour = "1.29 SD"), 
               linewidth = 0.5, breaks = 0) +
  scale_colour_manual(name = NULL, guide = "legend", 
                      values = c("1.29 SD" = "grey30",
                                 "2.33 SD" = "black")) +
  guides(fill = guide_colorbar(barheight = 12, 
                               ticks.colour = "grey40", ticks.linewidth = 0.5, 
                               frame.colour = "black", frame.linewidth = 0.3,
                               order = 1),
         colour = guide_legend(order = 2,
                               override.aes = list(linetype = c(1), 
                                                   shape = c(NA)),
                               theme = theme(legend.key = element_rect(fill = NA, color = NULL)))) +
  theme(legend.position = "right", 
        panel.background = element_rect(fill = "grey80")) +
  geom_point(data = line_p, aes(x = lon, y = lat), size = 1.2, shape = 15) +
  geom_text(data = line_p, aes(x = lon, y = lat, label = stn), nudge_y = -0.5, size = 3) +
  labs(fill = expression("Anomaly " ( degree*C)),
       title = paste(start, "to", end,"SST Anomaly"),
       subtitle = paste(datavar,"NRT Sea Surface Temperature Anomaly"),
       caption = datasource) +
  xlab(NULL) + ylab(NULL) +
  scale_y_continuous(breaks = seq(min(latlim), max(latlim), 5)) +
  scale_x_continuous(breaks = seq(min(lonlim),max(lonlim),5)) + 
  # Add regions
  geom_polygon(data = GH_E, aes(x = lon, y = lat), colour = "black", fill = NA) +
  geom_polygon(data = GH_W, aes(x = lon, y = lat), colour = "black", fill = NA) +
  geom_polygon(data = GH_S, aes(x = lon, y = lat), colour = "black", fill = NA) +
  geom_polygon(data = GH_O, aes(x = lon, y = lat), colour = "black", fill = NA) +
  geom_text(aes(x = -130.6, y = 52.482, label = "GHE"), colour = "black", size = 3.5) +
  geom_text(aes(x = -132.4, y = 52.475, label = "GHW"), colour = "black", size = 3.5) +
  geom_text(aes(x = -131.0, y = 51.7, label = "GHS"), colour = "black", size = 3.5) +
  geom_text(aes(x = -132.2, y = 51.9, label = "GHO"), colour = "black", size = 3.5) +
  #
  geom_polygon(data = usa, aes(x = long, y = lat, group = group), fill = "grey60", colour = "grey40", linewidth = 0.5) +
  geom_polygon(data = bc, aes(x = long, y = lat, group = group), fill = "grey70", colour = "grey40", linewidth = 0.5) +
  coord_quickmap(xlim = lonlim, ylim = latlim, expand = F) 

ggsave(filename = paste0("figures/Haida_Gwaii/SST_",datavar,"_7-day_rollingavg_anom_",end,"_HG.png"), 
       device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in")
ggsave(filename = paste0("figures/Haida_Gwaii/SST_",datavar,"_7-day_rollingavg_anom_HG.png"), 
       device = "png", scale = 1.9, height = 3.5, width = 3.5, units = "in", dpi=250)
