# ciat-isuirriweather
Script for extracting, merging and comparing ISU weather data with IRRI's


## Files

1. **weatherfile.R**<br>
A utility object for managing IRRI's individual weather data files

2. **isuirriweather.R**<br>
A utility object for managing ISU's individual weather data files

3. **main.R**<br>
Main script for processing ISU's and IRRI's weather data files

4. **main.bat**<br>
Windows batch script for running `main.R` without opening in RStudio. *(see Usage #4)*

	

## Usage

1. Clone this repository into your local PC.
2. ISU's and IRRI's weather files are confidential— please contact us for further details if you need to use it.  Put the files in their respective directories in `/data/irri/*` or `/data/isu/*` and read the README's for each data set regarding cleaning and preparing data.
3. In RStudio, 
	- Set the working directory to the cloned repository, i.e.: <br>
		`setwd(setwd("D:/LAB/R/ciat-isuirriweather")`
	- Run `source("main.R")`.
	- Alternatively, you can do #4 instead.
4. Open main.bat in a text editor and set `pathtorexe` to your R's `\bin` installation directory. For example,<br>
	`set pathtorexe="C:\Program Files\R\R-3.5.0\bin\"`
	- Click *main.bat* to run
5. Wait for (5) csv files to be generated in the `/extracted` directory:
	- export\_irri_014.csv 
	- export\_irri_015.csv
	- export\_irri_016.csv
	- export\_isu_2014.csv 
	- export\_isu_2015.csv

## External Links

1. [**Trello**](https://trello.com/b/b7vZQL7i) project board _(private)_

<br>

**Date Created:** 20180911<br>
**Date Modified:** 20180913