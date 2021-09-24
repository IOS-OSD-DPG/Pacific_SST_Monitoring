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
                    buoy_name = c("Middle NOMAD","South NOMAD","Sentry Shoal","South Brooks",
                                  "ECOBUOY_1","Central Dixon Entrance","Halibut Bank","South Moresby",
                                  "Nanakwa Shoal","North Hecate Strait","North NOMAD","South Hecate Strait",
                                  "West Sea Otter","West Dixon Entrance","La Perouse Bank","East Dellwood Knolls","West Moresby",
                                  "S. Georgia Straight","Entrance English Bay"),
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
                                   NA, NA))

# Buoy comments:
# ECOBUOY_1: This buoy has been specially modified to serve as a platform for additional sensors, including solar radiation, salinity, temperature and chlorophyll fluorescence. This buoy is located in Saanich Inlet, near the Institute of Ocean Sciences and serves as a temporary "test bed" for new sensors and telemetry tests. This is NOT a permanent monitoring station. 
# Halibut Bank: This buoy has been specially modified to serve as a platform for additional sensors, including solar radiation, salinity, temperature and chlorophyll fluorescence.
# Nanakwa Shoal: This buoy is located in Douglas Channel, near Kitimat.

# Marine regions of interest:
# Bowie Seamount MPA
SK_B <- data.frame(lat <- c(53.05211, 53.27247, 53.66367, 53.65500, 53.87131, 53.82211, 53.66736, 53.23311, 53.05211),
             lon <- c(-135.8405, -134.9987, -135.2847, -135.8963, -136.5064, -136.7925, -136.9510, -136.1667, -135.8405))
names(SK_B) <- c("lat", "lon")

# Gwaii Haanas
GH <- data.frame(lat <- c(52.20806, 52.44694, 52.83472, 52.80972, 52.77694, 52.67667, 52.00000, 51.80167, 52.20806),
           lon <- c(-130.8167, -131.0886, -131.3361, -131.6556, -131.8192, -132.2208, -131.3000, -130.8919, -130.8167))
names(GH) <- c("lat", "lon")

# Gwaii Haanas east region
GH_E <- data.frame(lat <- c(52.14583, 52.20806, 52.44694, 52.83472, 52.80972, 52.77694, 52.14583),
             lon <- c(-131.2292, -130.8167, -131.0886, -131.3361, -131.6556, -131.8192, -131.2292))
names(GH_E) <- c("lat", "lon")

# Gwaii Haanas west region
GH_W <- data.frame(lat <- c(52.77694, 52.67667, 52.00000, 52.14583, 52.77694),
             lon <- c(-131.8192, -132.2208, -131.3000, -131.2292, -131.8192))
names(GH_W) <- c("lat", "lon")

# Gwaii Haanas south region
GH_S <- data.frame(lat <- c(52.20806, 51.80167, 52.00000, 52.14583, 52.20806),
             lon <- c(-130.8167, -130.8919, -131.3000, -131.2292, -130.8167))
names(GH_S) <- c("lat", "lon")

# Gwaii Haanas Offshore box
GH_O <- data.frame(lat <- c(52.18750, 51.60417, 51.60417, 52.18750, 52.18750),
             lon <- c(-132.1042, -131.3958, -132.2708, -132.9792, -132.1042))
names(GH_O) <- c("lat", "lon")

# Hecate Strait/Queen Charlotte Sound Glass Sponge Reefs MPA - 3 regions
SR_N <- data.frame(lat <- c(53.19803, 53.15611, 53.04847, 53.05192, 53.12161, 53.12903, 53.22464, 53.32222, 53.40150, 53.39464, 53.31181, 53.25572, 53.19803, NA),
             lon <- c(-130.3298, -130.3147, -130.4212, -130.5099, -130.7009, -130.7740, -130.7913, -130.9067, -130.8105, -130.7145, -130.6359, -130.5504, -130.3298, NA))
names(SR_N) <- c("lat", "lon")
SR_C <- data.frame(lat <- c(52.00678, 51.93069, 51.85903, 51.88353, 52.08725, 52.14611, 52.26183, 52.49317, 52.53483, 52.56822, 52.42853, 52.33411, 52.16453, 52.00678, NA),
             lon <- c(-129.2368, -129.3038, -129.6104, -129.7343, -129.6039, -129.5593, -129.7368, -129.8758, -129.8851, -129.7976, -129.5867, -129.4977, -129.4249, -129.2368, NA))
names(SR_C) <- c("lat", "lon")
SR_S <- data.frame(lat <- c(51.41228, 51.30903, 51.24933, 51.24275, 51.29508, 51.32347, 51.41228, NA),
             lon <- c(-128.7995, -128.6766, -128.7837, -128.9293, -129.0081, -129.0149, -128.7995, NA))
names(SR_S) <- c("lat", "lon")

# Scotts Island MPA
SI <- data.frame(lat <- c(50.69236, 50.34589, 50.16361, 50.40536, 51.10119, 51.24275, 51.24933, 51.25139, 50.84367, 50.73981, 50.72765, 50.69236),
           lon <- c(-128.3775, -128.7590, -129.3522, -130.0104, -130.1406, -128.9293, -128.7837, -128.6126, -128.1775, -128.4026, -128.3896, -128.3775))
names(SI) <- c("lat", "lon")

# Offshore Pacific Area of Interest 
AOI <- data.frame(lat <- c(49.682, 51.064, 50.770, 50.405, 50.231, 49.529, 49.265, 49.000, 49.069, 47.793, 46.527, 49.682), 
            lon <- c(-134.901, -130.506, -130.078, -130.010, -129.534, -128.692, -129.027, -128.245, -128.158, -126.749, -129.129, -134.901))
names(AOI) <- c("lat", "lon")