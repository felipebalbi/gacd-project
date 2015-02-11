## run_analysis.R
##
## Script to download, clean, combine and merge data as a required deliverable
## for the Data Science Specialization - Getting And Cleaning Data course.
##
## Author: Felipe Balbi <balbif@gmail.com>
##

## Quite a few functions are defined here


##################################################################
##			GLOBAL CONSTANTS			##
##################################################################

## URL with source .zip file
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Folder to store data
destination.directory = "data"

## destination filename within destination.directory
destination.file = "dataset.zip"

## name of destination tidy dataset
destination.tidy = "dataset_tidy.csv"

## name of directory after modifying
destination.source = "uci_har_dataset"

##
# download.extract - downloads and extracts ZIP archive
##
download.extract <- function()
{
	filename <- paste(destination.directory, destination.file, sep = "/")

	if (file.exists(filename))
		cat(filename, "has already been downloaded\n")
	else
		zip <- download.file(url, filename, method = "curl",
				     mode = "wb")

	sourcedir <- paste(destination.directory, destination.source, sep = "/")

	if (file.exists(sourcedir)) {
		cat(filename, "has already been extracted\n")
	} else {
		result <- unzip(filename, exdir = destination.directory)

		# normalize directory name
		old <- strsplit(result, "/")[[1]][2]

		file.rename(paste(destination.directory, old, sep = "/"),
			    paste(destination.directory, destination.source, sep = "/"))
	}
}
