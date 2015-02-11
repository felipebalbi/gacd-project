## run_analysis.R
##
## Script to download, clean, combine and merge data as a required deliverable
## for the Data Science Specialization - Getting And Cleaning Data course.
##
## Author: Felipe Balbi <balbif@gmail.com>
##

## Quite a few functions are defined here

##################################################################
##			LIBRARY DEPENDENCY			##
##################################################################
library(dplyr)

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

##
# read.features - read features.txt into a proper data frame
#
# This function will read features.txt and normalize the names of the features
# before returning final result.
#
# All transformations were done using dplyr's select() and mutate() in
# conjunction with sub(), gsub(), and tolower().
#
# The list of transformations follows below:
#	1. make all feature names lower case
#	2. split the string so that tBody and fBody read as t.body and f.body
#	respectively
#	3. replace - with .
#	4. remove () pairs
#	5. remaining ( are converted into .
#	6. remaining ) are removed
#	7. remove duplicate 'bodybody' so that we're left with 'body'
#	8. always add a . after each word
#	9. remove any duplicate period characters there might have been added
#	after step 8
##
read.features <- function()
{
	filename <- paste(destination.directory, destination.source,
			  "features.txt", sep = "/")
	features <- read.table(filename, sep = " ", header = FALSE)
	names(features) <- c("id", "feature")

	features <- mutate(features, feature = tolower(feature))
	features <- mutate(features, feature = sub("^(t|f)", "\\1\\.", feature))
	features <- mutate(features, feature = gsub("\\-|\\,", ".", feature))
	features <- mutate(features, feature = gsub("\\(\\)", "", feature))
	features <- mutate(features, feature = gsub("\\(", ".", feature))
	features <- mutate(features, feature = gsub("\\)", "", feature))
	features <- mutate(features, feature = gsub("bodybody", "body", feature))
	features <- mutate(features, feature = gsub("(body|gravity|gyro|mag|acc|jerk|energy|bands)", "\\1\\.", feature))
	features <- mutate(features, feature = gsub("\\.\\.", ".", feature))

	features
}
