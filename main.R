## Main script for processing ISU's and IRRI's weather data files
## @ciatph 20180911

## Dependency scripts
library(stringr)
source("weatherfile.R")
source("isuirriweather.R")

# Path of extracted file output
path <- 'extracted/'



## Process and extract IRRI weather data
extractIRRI <- function() {
  # Set the years to read: 2014 and 2015 based from ISU's weather files
  year <- c("014", "015", "016")
  
  # Ignore the following columns from IRRR's weather file columns
  # Because they don't exist in ISU's weather files
  ignore <- c("sr","vp")
  
  # Read and extract data
  for(i in 1:length(year)){
    print(paste("processing:", year[i]))
    
    # Set the IRRI weather file object
    w <- irriweather()
    
    # Set Isabela's coordinates longitude and latitude to the weather file
    # (These are static, based from ISU's weather files)
    w$setlat(16, 42.3)
    w$setlon(121, 40.0)
    
    # Read, load the IRRI weather file at given year
    w$load(year[i])
    
    # Get the read-in weather data
    a <- w$getdata()
    
    for(j in 1:length(ignore)){
      # Delete the ignored columns
      a[ignore[j]] = NULL
      print(paste("--processing", ignore[j]))
    }
    
    # Export files to csv
    write.csv(a, file = paste0(path, "export_irri_", year[i], ".csv"))
  }  
}


## Process and extract ISU weather data
extractISU <- function() {
  filenames <- c("Weather2015_Isabela.xlsx")
  #filenames <- c("Weather2014_Isabela.xlsx")
  
  for(i in 1:length(filenames)) {
    
    # Set the ISU weather file object
    w <- isuweather()
    
    # Load all sheets data in DOY format (1-365/366)
    w$loadsheets(filenames[i])
    
    # Export files to csv
    write.csv(w$getdata(), 
              file = paste0(path, "export_isu_", str_extract(filenames[i], "\\-*\\d+\\.*\\d*"), ".csv"))    
  }
}


## Main program start
extractIRRI()
extractISU()
