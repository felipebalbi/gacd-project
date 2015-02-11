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
library(data.table)

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
	features <- fread(filename, sep = " ", header = FALSE)
	setnames(features, c("id", "feature"))

	features <- mutate(features, feature = tolower(feature))
	features <- mutate(features, feature = sub("^(t|f)", "\\1\\.", feature))
	features <- mutate(features, feature = gsub("\\-|\\,", ".", feature))
	features <- mutate(features, feature = gsub("\\(\\)", "", feature))
	features <- mutate(features, feature = gsub("\\(", ".", feature))
	features <- mutate(features, feature = gsub("\\)", "", feature))
	features <- mutate(features, feature = gsub("bodybody", "body", feature))
	features <- mutate(features, feature = gsub("(body|gravity|gyro|mag|acc|jerk|energy|bands)", "\\1\\.", feature))
	features <- mutate(features, feature = gsub("\\.\\.", ".", feature))
	features <- mutate(features, feature = gsub("\\.$", "", feature))

	features
}

##
# read.activity.labels - read activity_labels.txt into a proper data frame
#
# This function reads activity_labels.txt and returns a properly formatted
# data.frame with activity labels themselves converted into lowercase.
##
read.activity.labels <- function()
{
	filename <- paste(destination.directory, destination.source,
		       "activity_labels.txt", sep = "/")
	activities <- fread(filename, sep = " ")
	setnames(activities, c("id", "activity"))
	activities <- mutate(activities, activity = tolower(activity))
	activities
}

##
# read.data - reads X, Y, subject and activity data and merges them so we're
# left with a single data.table
#
# @type: type of data to read. Valid values are 'train' or 'test'
##
read.data <- function(type = "train")
{
	basedir <- paste(destination.directory, destination.source,
			  type, sep = "/")

	x_filename <- paste("X_", type, ".txt", sep = "")
	x_filename <- paste(basedir, x_filename, sep = "/")

	y_filename <- paste("y_", type, ".txt", sep = "")
	y_filename <- paste(basedir, y_filename, sep = "/")

	subject_filename <- paste("subject_", type, ".txt", sep = "")
	subject_filename <- paste(basedir, subject_filename, sep = "/")

	# Because of an issue with data.table (at least up until 1.9.5) where
	# it crashes with a buffer overflow due to any leading spaces before
	# the first actual data, we must use read.table() here. Of course we
	# could preprocess the file with a foreign script, but that's just
	# extra (non-R) work.
	#
	# In order to try and improve performance of read.table, we're setting
	# comment.char = "" to disable comments altogether, and also passing
	# colClasses appropriately (they're all numeric values)
	#
	# We are also passing nrows argument with the exact number of rows that
	# will be read into R. This is easily calculated with UNIX's wc utility
	x <- data.table(read.table(x_filename, stringsAsFactors = FALSE,
				   comment.char = "",
				   colClasses = "numeric",
				   nrows = 7352))
	activity <- fread(y_filename, header = FALSE, stringsAsFactors = FALSE)
	setnames(activity, "activity")

	subject <- fread(subject_filename, header = FALSE, stringsAsFactors = FALSE)
	setnames(subject, "subject")

	data <- data.table(subject, activity, x)
	data
}

##
# read.data.training - reads X, Y, subject and activity training data and
# merges them so we're left with a single data.table
##
read.data.training <- function()
{
	read.data("train")
}

##
# read.data.test - reads X, Y, subject and activity test data and merges them
# so we're left with a single data.table
##
read.data.test <- function()
{
	read.data("test")
}
