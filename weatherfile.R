## A utility object for managing IRRI's individual weather data files
## ciatph, 20180911
weatherfile <- function(lon = NULL, lat = NULL, data = NULL){
  
  ## Gets the IRRI weather station ID given coordinates in decimal degrees
  ## Uses the internal object lon and lat variables
  getcellid <- function(){
    if(!is.null(lon) & !is.null(lat)){
      row <-  1 + floor((90 - lat) / 0.25)
      col <- 1 + floor((lon + 180) / 0.25)
      cell <- (row - 1) * 1440 + col
      
      print(paste("row:", row))
      print(paste("col:", col))
      print(paste("cellid:", cell))
      
      return(cell) 
    }
  }  
  
  # Set the weather file's latitude
  # @param x: 1st degree
  # @param y: degree with the N/E
  setlat <- function(x, y){
    lat <- coord(x, y)
    lat <<- lat$convert()
  }
  
  
  # Set the weather file's longiture
  # @param x: 1st degree
  # @param y: degree with the N/E  
  setlon <- function(x, y){
    lon <- coord(x, y)
    lon <<- lon$convert()
  }
  
  # Set the weather file's raw/read data from external sources
  setdata <- function(d){
    data <<- d
  }
  
  # Get the normalized latitude
  getlat <- function() lat
  
  # Get the normalized longitude
  getlon <- function() lon
  
  # Get the read-in data
  getdata <- function() data
  
  # Load/read in the data
  # @param year: 3-digit year i.e., "014", "015"
  # @param path: path to weather file
  load <- function(year = NULL, path = NULL){
    if(is.null(year))
      return (0)
    
    filepath <- "data/irri/"
    
    if(!is.null(path))
      filepath <- path
    
    # Read the ISU weather files as csv
    data <<- read.csv(paste0(filepath, "nsch", 
                             getcellid(), ".", year), sep = ",")
  }
  
  # List of cached objects to return
  return(
    list(
      load = load,
      setlat = setlat,
      setlon = setlon,
      setdata = setdata,
      getcellid = getcellid,
      getdata = getdata,
      getlat = getlat,
      getlon = getlon
    ) 
  )
}


## Utility object for managing coordinates
## Accepts a coordinate in format: <degrees>, <degrees> N/E format
## Normalizes input into decimal degrees?
## @param degree: 1st degree
## @param NE: degree with the N/E
coord <- function(degree = NULL, NE = NULL){
  
  # Set the parameters
  set <- function(x, y){
    degree <<- x
    NE <<- y
  }
  
  # Convert into decimal degrees
  convert <- function(){
    return (degree + (NE / 60))
  }
  
  # return a list of cached functions and data
  return(
    list(
      set = set,
      convert = convert
    )
  )
}


## Gets the IRRI weather station ID given coordinates in decimal degrees
## @param lon: longitude (in decimal degrees)
## @param lat: latitude (in decimal degrees)
getCellId <- function(lon, lat){
  row <-  1 + floor((90 - lat) / 0.25)
  col <- 1 + floor((lon + 180) / 0.25)
  cell <- (row - 1) * 1440 + col
  
  print(paste("row:", row))
  print(paste("col:", col))
  print(paste("cellid:", cell))
  
  return(cell)
}
