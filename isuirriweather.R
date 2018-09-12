## A utility object for managing ISU's individual weather data files
## Reads an ISU weather file with matching predefined columns with the IRRI weather data
## USAGE:
##  w <- isuweather()
##  w$loadsheets("<filename>.xlsx")
##  a <- w$getdata()
## ciatph, 20180912

# Dependencies
library(readxl)

# Global variables
data_path <- 'data/isu/'


## Utility object to manage ISU weather data
## @param year: year
## @param data: raw read data content
isuweather <- function(year = NULL, data = NULL, sheets = NULL){
  
  # Set the year
  setyear <- function(x) year <<- x
  
  # Get the year
  getyear <- function() year
  
  # Get the data
  getdata <- function() data
  
  # Read and cache the raw, unformatted ISU weather data (1st sheet)
  # @param filename: filename of xlsx data to load
  # @param sheet: sheet no. from the xlsx file
  # @param path: optional path to file
  load <- function(filename = NULL, sheetNo = 1, path = NULL) {
    if(is.null(filename))
      return(0)
    
    file <- data_path
    
    if(!is.null(path)) 
      file <- path

    # Read file into cache
    return (read_excel(paste0(file, filename), sheet = sheetNo))
  }
  
  # Read and extract only the specified columns into cache
  # Formats read data into a DOY (day of year) list  
  # [16] - windspeed
  # [27] - temperature max
  # [30] - temparature min
  # [50] - precipitation
  loadsheets <- function(filename = NULL, path = NULL) {
    if(is.null(filename))
      return(0)
    
    file <- data_path
    
    if(!is.null(path)) 
      file <- path
    
    # No. of sheets in the excel file
    maxSheets <- 12
    
    # Row to start reading from the excel file
    rowStart <- 6
    
    # End row of excel file
    rowEnd <- 37
    
    # Column header of excel file
    columns <- c("P", "AA", "AD", "AX")
    
    # Initialize master data frame
    allSheets <- data.frame()
    
    for(i in 1:maxSheets) {
      # Reset monthly data container
      temp <- NULL
      
      for(j in 1:length(columns)) {
        if(is.null(temp)) {
          # Iniitialize the content of monthly container with 1st column data
          temp <- read_excel(paste0(file, filename), sheet = i, 
                             range = paste0(columns[j], rowStart, ":", columns[j], rowEnd))  
        }
        else{
          # Append succeeding column data 
          temp <- cbind(temp, read_excel(paste0(file, filename), 
                            sheet = i, range = paste0(columns[j], rowStart, ":", columns[j], rowEnd))) 
        }
      }
      
      # Change variable header names
      names(temp) <- c("ws", "tmax", "tmin", "rainfall")
      
      # Remove null values (for leap years)
      temp <- temp[complete.cases(temp),]
      print(paste("allsheets", nrow(allSheets), "cols-count", ncol(temp), "rows-cols", nrow(temp)))
      
      # Append monthly data to master list
      if(nrow(allSheets) == 0) {
        allSheets <- temp
      }
      else{
        allSheets <- rbind(allSheets, temp)
      }    
    }
    
    data <<- allSheets
  }

    
  return(
    list(
      year = year,
      load = load,
      loadsheets = loadsheets,
      setyear = setyear,
      getyear = getyear,
      getdata = getdata
    )
  )
}