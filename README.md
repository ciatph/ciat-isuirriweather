# ciat-isuirriweather
Script for extracting, merging and comparing ISU weather data with IRRI's


## Files

1. **weatherfile.R**<br>
A utility object for managing IRRI's individual weather data files

2. **main.R**<br>
Main script for processing ISU's and IRRI's weather data files


## Usage

1. Clone this repository into your local PC.
2. ISU's and IRRI's weather files are confidential— please contact us for further details if you need to use it.  Put the files in their respective directories in `/data/irri/*` or `/data/isu/*` and read the README's for each data set regarding cleaning and preparing data.
3. In RStudio, 
	- Set the working directory to the cloned repository, i.e.: <br>
		`setwd(setwd("D:/LAB/R/ciat-isuirriweather")`
	- Run `source("main.R")`.
4. Wait for (5) csv files to be generated in the `/extracted` directory:
	- export\_irri_014.csv 
	- export\_irri_015.csv
	- export\_irri_016.csv
	- export\_isu_2014.csv 
	- export\_isu_2015.csv

## External Links

1. [**Trello**](https://trello.com/b/b7vZQL7i) project board _(private)_

<br>

**Date Created:** 20180911<br>
**Date Modified:** 20180912