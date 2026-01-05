------------------------------------------------------------------------

# Sea Surface Temperature in the Northeast Pacific

### Experimental maps and data of current conditions

##### Andrea Hilborn, Charles Hannah and Lu Guan

This page updates weekly with maps and figures from a number of different data sources for monitoring Sea Surface Temperatures (SSTs) and Marine Heatwaves (MHWs) in the Northeast Pacific and Canadian Exclusive Economic Zone (EEZ) off of British Columbia (BC). A summary of the methods and further details can be found [here](https://waves-vagues.dfo-mpo.gc.ca/library-bibliotheque/41282437.pdf). The OISST and buoy data can also now be found in the [`pacea` R package](https://github.com/pbs-assess/pacea).

**These figures are provisional and correctness is not guaranteed. :)**
These figures update on **Monday** using the most recent week of data. A limited number of prior images [can be found here](https://github.com/BIO-RSG/Pacific_SST_NRT_Monitoring/tree/main/figures). Data shown in the figures can be downloaded [here](https://github.com/BIO-RSG/Pacific_SST_NRT_Monitoring/tree/main/data) (GeoTIFF and .rds format).
The climatologies for satellite and buoy data are calculated from the [Canadian Climate Normals](https://climate.weather.gc.ca/climate_normals/) period of **1991–2020**.

<details open>
<summary> 

## OISST

</summary>

* **Dataset:** [NOAA Optimal Interpolation gap-filled SST (OISST)](https://www.ncei.noaa.gov/products/optimum-interpolation-sst)
* **Data access:** Coastwatch ERDDAP [Near-realtime](https://coastwatch.pfeg.noaa.gov/erddap/griddap/ncdcOisst21NrtAgg_LonPM180.graph) and [Science-quality](https://coastwatch.pfeg.noaa.gov/erddap/griddap/ncdcOisst21Agg_LonPM180.graph) records
* **Spatial resolution:** 0.25&deg; (~25 km)
* **Climatology period:** 1991–2020

*5-degree intervals are marked as lines on the SST plot (left). 
On the anomaly plots (right) the lines indicate 1.29 and 2.33 standard deviations above normal (approximately the upper 90th and 99th percentiles relative to the climatology).
The BC EEZ is indicated with a dashed line.
Points indicate selected stations along [Line-P](https://www.dfo-mpo.gc.ca/science/data-donnees/line-p/index-eng.html).*

:arrow_right: To view map insets near Haida Gwaii click [here](https://github.com/BIO-RSG/Pacific_SST_NRT_Monitoring/tree/main/docs/Haida_Gwaii.md). :arrow_left:

### Latest week of data

<img src="./figures/current/SST_OI_7-day_rollingavg.png" width="400"/> <img src="./figures/current/SST_OI_7-day_rollingavg_anom.png" width="405"/>

### MHW Conditions in the NEP and BC EEZ

*The 2025 MHW spatial coverage of the NEP and BC EEZ (red) is below, with 2024 coverage shown in grey. The current percent area of the BC EEZ in MHW status at the surface is written in the upper left corner. The same information is shown below for the NEP (black), and three sub-regions of the BC EEZ: the Offshore Pacific Bioregion (OP, light blue), Northern Shelf Bioregion (NSB, dark blue) and Southern Shelf Bioregion (SSB, yellow). Download the data from this figure [here](https://github.com/IOS-OSD-DPG/Pacific_SST_Monitoring/blob/main/data/MHW_EEZ_values_2024-2025.csv), and view similar plots for previous years [here](https://github.com/IOS-OSD-DPG/Pacific_SST_Monitoring/blob/main/docs/MHW_Conditions.md).*

<details>
<summary> 

###### Click here to view region map
</summary>

*The Northeast Pacific (NEP) region boundary is shown in the maps above: 30-65 N and 120-160 W.*
<img src="./figures/BC_MHW_OIRegions.png" width="400"/> 

</details>

<img src="./figures/current/MHW_EEZ_perc_coverage_2025_regions.png" width="750"/>

</details>


### How does 2025 SST in the Northeast Pacific compare to other years?

<img src="./figures/current/NEP_progress.png" width="700"/>

### Rankings of 10 warmest years
#### Mean monthly SST:

*The point indicates the mean of the SST by month, with the bars indicating the monthly standard deviation bounds. The years are indicated on the left, with warmest indicated with a rank of "1."*

<img src="./figures/current/Ranked_SST_months.png" width="750"/> 

#### Mean monthly SST Anomaly:

*The point indicates the mean SST **anomaly** by month, with the bars indicating the monthly mean anomaly standard deviation bounds. The years are indicated on the left, with highest mean anomaly indicated with a rank of "1."*

<img src="./figures/current/Ranked_SST_Anom_months.png" width="750"/> 

<details open>

<summary> 

## ECCC Buoy data

</summary>

* **Dataset:** Surface temperature observations from Canadian Pacific buoys maintained by [Environment and Climate Change Canada (ECCC)](https://www.canada.ca/en/environment-climate-change/services/general-marine-weather-information/observations/buoy.html) and [Fisheries and Oceans Canada (DFO)](https://www.pac.dfo-mpo.gc.ca/science/oceans/data-donnees/buoydata-donneebouee/index-eng.html)
* **Data access:** CIOOS Pacific ERDDAP [DFO_MEDS_BUOYS](https://data.cioospacific.ca/erddap/info/DFO_MEDS_BUOYS/index.html) and [ECCC_MSC_BUOYS](https://data.cioospacific.ca/erddap/info/ECCC_MSC_BUOYS/index.html) records. The DFO_MEDS_BUOYS record has a detailed quality control layer outlined in [Kellogg et al., 2021](https://catalogue.cioospacific.ca/dataset/ca-cioos_b9c71eb2-b750-43d5-a50a-aee173916736) which **ends in December, 2023**
* **Climatology period:** 1991–2020

*The white lines outlined in black are daily mean observations from 2025. The buoy climatological mean (grey line) is plotted with 10th and 90th percentiles (grey shading).  The climatology spans 1991–2020, though some buoys began collecting data later: `C46146 Halibut Bank`, `C46131 Sentry Shoal`, `C46147 South Moresby` and `C46132 South Brooks`. There are no climatologies for `C46303 South Georgia Strait` and `C46304 Entrance English Bay` as they were installed in 2019.*

:arrow_right: To view 2021–2024 data click [here](https://github.com/BIO-RSG/Pacific_SST_NRT_Monitoring/tree/main/docs/Buoy_temperature.md). :arrow_left:

<p align="center">
  <img src="./figures/current/Daily_mean_SSTP_C46184.png" width="43%"/>
&nbsp; &nbsp; &nbsp; &nbsp;
  <img src="./figures/current/Daily_mean_SSTP_C46205.png" width="43%"/>
</p>
<p align="center">
  <img src="./figures/current/Daily_mean_SSTP_C46145.png" width="43%"/>
&nbsp; &nbsp; &nbsp; &nbsp;
  <img src="./figures/current/Daily_mean_SSTP_C46181.png" width="43%"/>
</p>

<p align="center">
  <img src="./figures/current/Daily_mean_SSTP_C46183.png" width="43%"/>
&nbsp; &nbsp; &nbsp; &nbsp;
  <img src="./figures/current/Daily_mean_SSTP_C46147.png" width="43%"/>
</p>

<p align="center">
  <img src="./figures/current/Daily_mean_SSTP_C46185.png" width="43%"/>
&nbsp; &nbsp; &nbsp; &nbsp;
  <img src="./figures/current/Daily_mean_SSTP_C46204.png" width="43%"/>
</p>
<p align="center">
  <img src="./figures/current/Daily_mean_SSTP_C46004.png" width="43%"/>
&nbsp; &nbsp; &nbsp; &nbsp;
  <img src="./figures/current/Daily_mean_SSTP_C46207.png" width="43%"/>
</p>
<p align="center">
  <img src="./figures/current/Daily_mean_SSTP_C46132.png" width="43%"/>
&nbsp; &nbsp; &nbsp; &nbsp;
  <img src="./figures/current/Daily_mean_SSTP_C46206.png" width="43%"/>
</p>
<p align="center">
  <img src="./figures/current/Daily_mean_SSTP_C46131.png" width="43%"/>
&nbsp; &nbsp; &nbsp; &nbsp;
  <img src="./figures/current/Daily_mean_SSTP_C46146.png" width="43%"/>
</p>
<p align="center">
  <img src="./figures/current/Daily_mean_SSTP_C46036.png" width="43%"/>
</p>
  

<details>
<summary> 

###### Click here to view buoy map and 1991-2020 surface temperature climatologies
</summary>

<img src="./figures/current/Daily_clim_buoy_overview_2024.png" width="900"/> 

</details>

<details>
<summary> 

###### Buoy details

</summary>

*The start dates listed here may not correspond with other sources (e.g. the [ECCC website](https://www.pac.dfo-mpo.gc.ca/science/oceans/data-donnees/buoydata-donneebouee/index-eng.html)) but represent the data record available at the sources listed above, as of December 2023. An up-to-date buoy status report can be viewed here: https://collaboration.cmc.ec.gc.ca/cmc/wbs/bplatstat.html*

Stn ID | Start Date | Longitude| Latitude | 
-------|------------|-----------|--------|
[C46004 Middle NOMAD](https://www.meds-sdmm.dfo-mpo.gc.ca/isdm-gdsi/waves-vagues/data-donnees/data-donnees-eng.asp?medsid=C46004) | 1988-08-04 | -136.10 | 50.93
[C46036 South NOMAD](https://www.meds-sdmm.dfo-mpo.gc.ca/isdm-gdsi/waves-vagues/data-donnees/data-donnees-eng.asp?medsid=C46036) | 1987-09-22 | -133.94 | 48.35 
[C46131 Sentry Shoal](https://www.meds-sdmm.dfo-mpo.gc.ca/isdm-gdsi/waves-vagues/data-donnees/data-donnees-eng.asp?medsid=C46131) | 1992-10-20 |  -124.99 | 49.91 
[C46132 South Brooks](https://www.meds-sdmm.dfo-mpo.gc.ca/isdm-gdsi/waves-vagues/data-donnees/data-donnees-eng.asp?medsid=C46132) | 1994-05-05 | -127.93 | 49.74 
[C46145 Central Dixon Entrance](https://www.meds-sdmm.dfo-mpo.gc.ca/isdm-gdsi/waves-vagues/data-donnees/data-donnees-eng.asp?medsid=C46145) |  1991-04-16 | -132.42 | 54.38 
[C46146 Halibut Bank](https://www.meds-sdmm.dfo-mpo.gc.ca/isdm-gdsi/waves-vagues/data-donnees/data-donnees-eng.asp?medsid=C46146) | 1992-03-13  |-123.73 | 49.34 
[C46147 South Moresby](https://www.meds-sdmm.dfo-mpo.gc.ca/isdm-gdsi/waves-vagues/data-donnees/data-donnees-eng.asp?medsid=C46147) | 1993-06-17 |-131.23 | 51.83
[C46181 Nanakwa Shoal](https://www.meds-sdmm.dfo-mpo.gc.ca/isdm-gdsi/waves-vagues/data-donnees/data-donnees-eng.asp?medsid=C46181) | 1988-11-22 |-128.84 | 53.82 
[C46183 North Hecate Strait](https://www.meds-sdmm.dfo-mpo.gc.ca/isdm-gdsi/waves-vagues/data-donnees/data-donnees-eng.asp?medsid=C46183) | 1991-05-15 |  -131.14 | 53.57 
[C46184 North NOMAD](https://www.meds-sdmm.dfo-mpo.gc.ca/isdm-gdsi/waves-vagues/data-donnees/data-donnees-eng.asp?medsid=C46184) | 1987-09-20 | -138.85 | 53.92 
[C46185 South Hecate Strait](https://www.meds-sdmm.dfo-mpo.gc.ca/isdm-gdsi/waves-vagues/data-donnees/data-donnees-eng.asp?medsid=C46185) | 1991-09-12 | -129.79 | 52.42 
[C46204 West Sea Otter](https://www.meds-sdmm.dfo-mpo.gc.ca/isdm-gdsi/waves-vagues/data-donnees/data-donnees-eng.asp?medsid=C46204) | 1989-09-07 |  -128.77 | 51.38
[C46205 West Dixon Entrance](https://www.meds-sdmm.dfo-mpo.gc.ca/isdm-gdsi/waves-vagues/data-donnees/data-donnees-eng.asp?medsid=C46205) | 1988-11-22 | -134.32 | 54.19 
[C46206 La Perouse Bank](https://www.meds-sdmm.dfo-mpo.gc.ca/isdm-gdsi/waves-vagues/data-donnees/data-donnees-eng.asp?medsid=C46206) | 1988-11-22 | -126.00 | 48.83 
[C46207 East Dellwood](https://www.meds-sdmm.dfo-mpo.gc.ca/isdm-gdsi/waves-vagues/data-donnees/data-donnees-eng.asp?medsid=C46207) | 1989-10-18 |  -129.91 | 50.88 
 [C46208 West Moresby](https://www.meds-sdmm.dfo-mpo.gc.ca/isdm-gdsi/waves-vagues/data-donnees/data-donnees-eng.asp?medsid=C46208) | 1990-07-12 | -132.69 | 52.51
C46303 South Georgia Strait* |  2019-10-01 |   -123.4300 |  49.02500 
C46304 Entrance English Bay* | 2019-10-01 |-123.3570 | 49.30167

* *Note that these buoys do not have MEDS webpages with data*
  
</details>

</details>

<details>
<summary> 
 
## Other data sources and links of interest
</summary>

### El Niño
* [NOAA El Niño Index Dashboard](https://psl.noaa.gov/enso/dashboard.html)
* [NOAA ENSO Blog](https://www.climate.gov/news-features/blogs/enso)

### Hydrology, drought and climate
* [BC River Forecast Centre Map of 7-Day Average Streamflow](http://bcrfc.env.gov.bc.ca/lowflow/map_7dayflow.html)
* [BC Drought Information Portal](https://droughtportal.gov.bc.ca/)
* [BC Snow Conditions Summary](https://www2.gov.bc.ca/gov/content/environment/air-land-water/water/drought-flooding-dikes-dams/river-forecast-centre/snow-survey-water-supply-bulletin/snow-conditions-commentary)

### SST and Marine Heatwaves
* [California Current Marine Heatwave Tracker](https://www.integratedecosystemassessment.noaa.gov/regions/california-current/california-current-marine-heatwave-tracker-blobtracker)
* [CIOOS Pacific Marine Heatwave Monitor](https://cioospacific.ca/applied-data/marine-heat-monitor/)
* [Climate Reanalyzer Daily Global Sea Surface Temperature](https://climatereanalyzer.org/clim/sst_daily/)
* [Copernicus Climate Indicators](https://climate.copernicus.eu/climate-indicators)
* [Copernicus Climate Pulse](https://pulse.climate.copernicus.eu/)
* [Global daily SST, 7-day trend and anomaly (NOAA CoralReefWatch)](https://www.ospo.noaa.gov/Products/ocean/cb/sst5km/)
* [Marine Heatwaves International Working Group](http://www.marineheatwaves.org/)
* [Multi-Scale Ultra-High resolution SST Anomaly, Daily](https://coastwatch.pfeg.noaa.gov/erddap/griddap/jplMURSST41anom1day.graph?sstAnom%5B(last)%5D%5B(20.0):(63.0)%5D%5B(-179.99):(-110.0)%5D&amp;.draw=surface&amp;.vars=longitude%7Clatitude%7CsstAnom&amp;.trim=0&amp;.colorBar=%7C%7C%7C%7C%7C&.bgColor=0xffccccff) ***click to view latest image**
<img src="https://coastwatch.pfeg.noaa.gov/erddap/griddap/jplMURSST41anom1day.png?sstAnom%5B(last)%5D%5B(20.0):(63.0)%5D%5B(-179.99):(-110.0)%5D&amp;.draw=surface&amp;.vars=longitude%7Clatitude%7CsstAnom&amp;.trim=0&amp;.colorBar=%7C%7C%7C%7C%7C&.bgColor=0xffccccff" alt="Multi-Scale Ultra-High Resolution SST Anomaly, Daily">

* [NOAA Marine Heatwave Forecast Monthly Report](https://psl.noaa.gov/marine-heatwaves/#report)
* [NOAA CoastWatch Data Viewer](https://coastwatch.noaa.gov/cw_html/cwViewer.html) and [CoastWatch commonly used SST data sources](https://coastwatch.pfeg.noaa.gov/data.html)
* [NOAA Coral Reef Watch: MHW Watch](https://coralreefwatch.noaa.gov/product/marine_heatwave/)
* [NOAA Physical Sciences Lab Map Room: SST](https://psl.noaa.gov/map/clim/sst.shtml)
* [Pacific Islands Ocean Observing System](https://www.pacioos.hawaii.edu/voyager/): Near-Real Time data viewer including Coral Reef Watch SST and SST anomaly

### Articles and presentations
* [**November 2023 NOAA Slide Deck:** Global Ocean Monitoring: Recent Evolution, Current Status, and Predictions](https://origin.cpc.ncep.noaa.gov/products/GODAS/ocean_briefing_gif/global_ocean_monitoring_current.pdf)
* [**August 2022 Carbon Brief:** Mapped: Attributing extreme weather to climate change](https://www.carbonbrief.org/mapped-how-climate-change-affects-extreme-weather-around-the-world/)
* [**September 2019 NOAA Fisheries:** New Marine Heatwave Emerges off West Coast, Resembles "the Blob"](https://www.fisheries.noaa.gov/feature-story/new-marine-heatwave-emerges-west-coast-resembles-blob)
* [**September 2019 NOAA Fisheries:** Looking Back At The Blob: Record Warming Drives Unprecedented Ocean Change](https://www.fisheries.noaa.gov/feature-story/looking-back-blob-record-warming-drives-unprecedented-ocean-change)


</details>

<details>
<summary> 

## References
</summary>

* California Current Marine Heatwave Tracker: https://oceanview.pfeg.noaa.gov/projects/mhw/latest
* CoastWatch ERDDAP Server: https://coastwatch.pfeg.noaa.gov/erddap/index.html
* CIOOS Pacific ERDDAP Server: https://data.cioospacific.ca/erddap/index.html
* Galbraith, P.S., Larouche, P. & Caverhill, C. (2021): A Sea-Surface
Temperature Homogenization Blend for the Northwest Atlantic, Canadian Journal of Remote
Sensing, [doi:10.1080/07038992.2021.1924645](https://www.tandfonline.com/doi/full/10.1080/07038992.2021.1924645)
* Hilborn, A., Guan, L., Wan, D. & Peña, A. (2025): A Sea Surface Temperature product for monitoring Marine Heatwaves in the Northeast Pacific. Can. Tech. Rep. Hydrogr. Ocean Sci. 394: v + 23 p. [https://waves-vagues.dfo-mpo.gc.ca/library-bibliotheque/41282437.pdf](https://waves-vagues.dfo-mpo.gc.ca/library-bibliotheque/41282437.pdf)
* Hobday, A.J., Alexander, L., Perkins, S., Smale, D.A., Straub, S., Oliver, E., Benthuysen, J.A., Burrows, M., Donat, M.G., Feng, M., Holbrook, N.J., Moore, P.J., Scannell, H., Sen Gupta, A. & Wernberg, T. (2016): A hierarchical approach to defining marine heatwaves. Progress in Oceanography. 141, 227-238, [doi:10.1016/j.pocean.2015.12.014](https://doi.org/10.1016/j.pocean.2015.12.014)
* Hobday, A.J., Oliver, E.C.J., Sen Gupta, A., Benthuysen, J.A., Burrows, M.T., Donat, M.G., Holbrook, N.J., Moore, P.J., Thomsen, M.S., Wernberg, T., & Smale, D.A. (2018): Categorizing and naming marine heatwaves. Oceanography 31(2):162–173, [doi:10.5670/oceanog.2018.205](https://doi.org/10.5670/oceanog.2018.205)
* Kellogg, J., Rosenstock, N., Page, S., Hourston, R., Devred, E. and Hannah, C. (2021): Quality Control of Weather/Wave Buoy Temperature Data Provided by Environment and Climate Change Canada. CIOOS Pacific. [https://catalogue.cioospacific.ca/dataset/ca-cioos_b9c71eb2-b750-43d5-a50a-aee173916736](https://catalogue.cioospacific.ca/dataset/ca-cioos_b9c71eb2-b750-43d5-a50a-aee173916736/resource/12786acf-a634-4a5b-9867-2b39c6c11aae)

For other reading on Marine Heatwaves, check out the [reference list here](https://github.com/BIO-RSG/Pacific_SST_NRT_Monitoring/tree/main/docs/MHW_Literature.md)!
</details>
