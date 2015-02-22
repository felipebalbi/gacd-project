## run_analysis.R
##
## Script to download, clean, combine and merge data as a required deliverable
## for the Data Science Specialization - Getting And Cleaning Data course.
##
## Author: Felipe Balbi <balbif@gmail.com>
##

## URL with source .zip file
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Folder to store data
destination.directory = "data"

## destination filename within destination.directory
destination.file = "dataset.zip"

## name of destination tidy dataset
destination.tidy = "uci_har_dataset_tidy.csv"

## name of directory after modifying
destination.source = "uci_har_dataset"

##
# download.extract - downloads and extracts ZIP archive
##
download.extract <- function()
{
	cat("Processing...\tDownloading dataset\n")

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
	cat("Processing...\tReading features\n")
	filename <- paste(destination.directory, destination.source,
			  "features.txt", sep = "/")
	features <- fread(filename, sep = " ", header = FALSE)
	setnames(features, c("id", "feature"))

	cat("Processing...\tMutating feature names\n")
	features <- mutate(features, feature = tolower(feature))
	features <- mutate(features, feature = sub("^(t|f)", "\\1\\.", feature))
	features <- mutate(features, feature = gsub("\\-|\\,", ".", feature))
	features <- mutate(features, feature = gsub("\\(\\)", "", feature))
	features <- mutate(features, feature = gsub("\\(", ".", feature))
	features <- mutate(features, feature = gsub("\\)", "", feature))
	features <- mutate(features, feature = gsub("bodybody", "body", feature))
	features <- mutate(features, feature =
			   gsub("(body|gravity|gyro|mag|acc|jerk|energy|bands)",
				"\\1\\.", feature))
	features <- mutate(features, feature = gsub("\\.\\.", ".", feature))
	features <- mutate(features, feature = gsub("\\.$", "", feature))

	cat("Processing...\tDone with features\n")
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
	cat("Processing...\tReading activity labels\n")
	filename <- paste(destination.directory, destination.source,
		       "activity_labels.txt", sep = "/")
	activities <- fread(filename, sep = " ")
	setnames(activities, c("id", "activity"))
	cat("Processing...\tMutating activity labels\n")
	activities <- mutate(activities, activity = tolower(activity))
	cat("Processing...\tDone with activity labels\n")
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
	cat("Processing...\tReading training data\n")
	data <- read.data("train")
	cat("Processing...\tDone with training data\n")

	data
}

##
# read.data.test - reads X, Y, subject and activity test data and merges them
# so we're left with a single data.table
##
read.data.test <- function()
{
	cat("Processing...\tReading test data\n")
	data <- read.data("test")
	cat("Processing...\tDone with test data\n")

	data
}

##
# run.analysis - top level function tying everything together
##
run.analysis <- function()
{
	# First download data
	download.extract()

	# Read features
	features <- read.features()

	# Read activity labels
	activity.labels <- read.activity.labels()

	# Read training data
	training <- read.data.training()

	# Read test data
	test <- read.data.test()

	# Here's the tricky part. We need to first row-bind training and test
	# so we're left with a single data.table
	internal.dt <- rbind(training, test)

	# Now we need to set column names properly. Column names are the first
	# two column names from internal.dt concatenated with features$feature.
	#
	# first we grab first two names from internal.dt and concatenate to the
	# 'feature' column from 'internal.dt' and pass all that to setnames().
	setnames(internal.dt, c("id", "activity", features$feature))

	# Replace activity IDs with actual strings
	internal.dt <- internal.dt %>%
			mutate(activity = activity.labels[activity, ]$activity)

	# Select only mean and std columns, together with subject and activity
	tmp.dt <- select(internal.dt, id, activity,
			 contains("mean"), contains("std"))

	cat("Processing...\tSummarising data\n")
	result.dt <- tmp.dt %>%
			group_by(id, activity) %>%
			summarise_each(funs(mean))

	cat("Processing...\tSorting data\n")
	result.dt <- arrange(result.dt, id)

	cat("Processing...\tWriting tidy data\n")

	output <- paste(destination.directory, destination.tidy, sep = "/")

	write.table(result.dt, file = output, sep = ",", row.names = FALSE)

	cat("Processing done\n")
}

# empty character vector for packages names which might need to be installed
packages = character(0)
packages.needed = FALSE

# check if dplyr needs to be installed
if (!("dplyr" %in% installed.packages())) {
	packages.needed <- TRUE

	if (interactive()) {
		reply <- readline("Do you want me to install package 'dplyr'? ")
		if (grepl("^[Yy](es)?", reply))
			packages <- c(packages, 'dplyr')
	}
}

# check if data.table needs to be installed
if (!("data.table" %in% installed.packages())) {
	packages.needed <- TRUE

	if (interactive()) {
		reply <- readline("Do you want me to install package 'data.table'? ")
		if (grepl("^[Yy](es)?", reply))
			packages <- c(packages, 'data.table')
	}
}

# conditionally install packages
if (length(packages) > 0) {
	install.packages(packages, repo = "http://cran.rstudio.com/")
} else if (length(packages) == 0 & packages.needed) {
	stop("Can't run without 'dplyr' and 'data.table'")
}

# load dependencies
library(dplyr)
library(data.table)

# finally, run our analysis
run.analysis()
