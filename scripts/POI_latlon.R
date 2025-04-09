# Coordinates for points of interest to map

# Selected stations from Line P
line_p <- data.frame(stn = c("P4", "P12", "P16", "P20", "P26"),
                     lat = c(48.65, 48.97, 49.283, 49.567, 50.),
                     lon = c(-126.67,-130.67,-134.67,-138.67,-145.))
# ECCC Buoy coordinates
buoys <- data.frame(wmo_id = c("46004","46036","46131","46132",
                               "46134","46145","46146","46147",
                               "46181","46183","46184","46185",
                               "46204","46205","46206","46207","46208",
                               "46303","46304"),
                    buoy_name = c("Middle NOMAD","S. NOMAD","Sentry Shoal","S. Brooks",
                                  "ECOBUOY_1","Central Dixon Entrance","Halibut Bank","S. Moresby",
                                  "Nanakwa Shoal","N. Hecate Strait","N. NOMAD","S. Hecate Strait",
                                  "W. Sea Otter","W. Dixon Entrance","La Perouse Bank","E. Dellwood Knolls","W. Moresby",
                                  "S. Georgia Strait","Entrance English Bay"),
                    buoy_type = c("NOMAD","NOMAD","3 metre discus","3 metre discus",
                                  "3 metre discus","3 metre discus","3 metre discus","3 metre discus",
                                  "3 metre discus","3 metre discus","NOMAD","3 metre discus",
                                  "3 metre discus","3 metre discus","3 metre discus","3 metre discus","3 metre discus",
                                  NA, NA),
                    lat = c(50.983,48.35,49.9067,49.73,
                            48.656,54.383,49.34,51.83,
                            53.83,53.617,53.9,52.407,
                            51.3683,54.167,48.835,50.875,52.5,
                            49.025,49.30167),
                    lon = c(-135.783,-133.93,-124.985,-127.9167,
                            -123.483,-132.427,-123.727,-131.217,
                            -128.8317,-131.105,-138.867,-129.783,
                            -128.75,-134.33,-125.9983,-129.917,-132.7,
                            -123.43,-123.357),
                    water_depth_m = c(3600, 3500,18,2040,
                                      65,257,43,2000,
                                      22,60,3200,228,
                                      222,2675,73,2215,2950,
                                      NA, NA),
                    start_date = c("1989-05-01","1988-04-01","1992-10-13","1993-10-05",
                                   "1999-01-01","1991-04-11","1992-03-16","1992-05-11",
                                   "1990-05-22","1991-04-09","1987-09-20","1990-06-08",
                                   "1989-09-07","1988-11-22","1988-11-22","1989-10-18","1991-07-01",
                                   NA, NA),
                    col_key = c("#0000FF", "#FF0000", "#00FF00", "#000033", 
                                "#000033","#FF00B6", "#005300", "#FFD300",
                                "#009FFF","#9A4D42", "#00FFBE", "#783FC1", 
                                "#1F9698", "#FFACFD", "#FE8F42", "#DD00FF", "#02AD24", 
                                "#C8FF00","#886C00"))
# Remove ecobuoy
buoys = buoys %>% filter(wmo_id != "46134")

# Buoy comments:
# ECOBUOY_1: This buoy has been specially modified to serve as a platform for additional sensors, including solar radiation, salinity, temperature and chlorophyll fluorescence. This buoy is located in Saanich Inlet, near the Institute of Ocean Sciences and serves as a temporary "test bed" for new sensors and telemetry tests. This is NOT a permanent monitoring station. 
# Halibut Bank: This buoy has been specially modified to serve as a platform for additional sensors, including solar radiation, salinity, temperature and chlorophyll fluorescence.
# Nanakwa Shoal: This buoy is located in Douglas Channel, near Kitimat.

# Marine regions of interest:

# see 00_subregions_west.R

# Gwaii Haanas east region
GH_E <- list(lat <- c(52.2162, 52.20965, 52.21085, 52.25362, 52.41095, 52.52033, 52.70583, 52.74924, 52.77666, 52.79119, 52.79177, 52.8008, 52.8101, 52.83451, 52.44675, 52.20787, 52.21357, 52.2162),
             lon <- c(-131.0063, -131.0601, -131.1929, -131.3064, -131.479, -131.6887, -131.8995, -131.9151, -131.8785, -131.7582, -131.7073, -131.6727, -131.6568, -131.3376, -131.0901, -130.8181, -131.0033, -131.0063),
             NAME_E = "East Gwaii Haanas National Marine Conservation Area Reserve",
             STN_ID = "GH_E")
names(GH_E) <- c("lat", "lon","NAME_E","STN_ID")

# Gwaii Haanas west region
GH_W <- list(lat <- c(52.70583, 52.52033, 52.41095, 52.25362, 52.12421, 51.9998, 52.67643, 52.73469, 52.7352, 52.74139, 52.69898, 52.70583),
             lon <- c(-131.8995, -131.6887, -131.479, -131.3064, -131.2634, -131.3015, -132.2226, -132.1081, -132.1077, -132.089, -131.9676, -131.8995),
             NAME_E = "West Gwaii Haanas National Marine Conservation Area Reserve",
             STN_ID = "GH_W")
names(GH_W) <- c("lat", "lon","NAME_E","STN_ID")

# Gwaii Haanas south region
# NEW:
GH_S <- list(lat <- c(51.9998, 52.12421, 52.25362, 52.21085, 52.20965, 52.2162, 52.21357, 52.20787, 51.79925, 51.9998),
             lon <- c(-131.3015, -131.2634, -131.3064, -131.1929, -131.0601, -131.0063, -131.0033, -130.8181, -130.8934, -131.3015),
             NAME_E = "South Gwaii Haanas National Marine Conservation Area Reserve",
             STN_ID = "GH_S")
names(GH_S) <- c("lat", "lon","NAME_E","STN_ID")

# Gwaii Haanas Offshore box
GH_O <- list(lat <- c(52.18750, 51.60417, 51.60417, 52.18750, 52.18750),
             lon <- c(-132.1042, -131.3958, -132.2708, -132.9792, -132.1042),
             NAME_E = "Offshore Gwaii Haanas National Marine Conservation Area Reserve",
             STN_ID = "GH_O")
names(GH_O) <- c("lat", "lon","NAME_E","STN_ID")

GH_E = as.data.frame(GH_E)
GH_W = as.data.frame(GH_W)
GH_S = as.data.frame(GH_S)
GH_O = as.data.frame(GH_O)

