# Getting and Cleaning Data - Data Science Specialization - Coursera
## Course Project
### Author: Felipe Balbi
### Email: balbif@gmail.com
=====================================================================

# Data Selection

After properly loading all files into R, we have used dplyr's *select()*
combined with *matches()* to pick all columns which contained 'mean' or 'std'
in their names. We have decided to select 'mean' or 'std' anywhere in the name
because Assignment's steps was unclear whether we should filter out only
measurements ending with 'mean()' or 'std()', or if we should also select
observations whose names contained 'mean' or 'std' in places other than the
end of the name string.

For the sake of completeness, we have decided to use all columns containing
'mean' or 'std' anywhere in the column name.

# Description of Files

This repository contains an
[R](http://en.wikipedia.org/wiki/R_%28programming_language%29) script which
will download and clean source data and also generate a [Tidy
Dataset](https://github.com/felipebalbi/gacd-project/blob/wip/data/uci_har_dataset_tidy.csv)
for further consumption later on. Together with it, we're also providing a
README.md file (this exact file which you're reading now) describing the
project as a whole, and a Codebook.md file which describes the variables within
our [Tidy
Dataset](https://github.com/felipebalbi/gacd-project/blob/wip/data/uci_har_dataset_tidy.csv).

There are a total of 4 (four) files within this repository, which we describe
below:

* README.md: This very file, describing the project as a whole;
* run\_analysis.R: An R script containing code to download, extract, clean,
  merge, select and generate a [Tidy
Dataset](https://github.com/felipebalbi/gacd-project/blob/wip/data/uci_har_dataset_tidy.csv)
in [Comma Separated Value
(CSV)](http://en.wikipedia.org/wiki/Comma-separated_values) file located at
file;
* Codebook.md: Serving as *metadata* for our [Tidy
  Dataset](https://github.com/felipebalbi/gacd-project/blob/wip/data/uci_har_dataset_tidy.csv),
Codebook.md
  describes all variables contained within our dataset so it becomes easier for
  anybody processing our data further down the line.
* dataset\_tidy.csv: This is our [Tidy
  Dataset](https://github.com/felipebalbi/gacd-project/blob/wip/data/uci_har_dataset_tidy.csv)
as mentioned multiple times
  above. Here you can find all cleaned up data which our script was able to
  generate.

## Script run\_analysis.R

The whole idea when developing this script is that it would be as
self-contained as possible. Due to that, we made sure the script knows how to
download its own source data, extract it and only then start processing, merging,
cleaning, etc.

There are two ways of running this script, both described in subsections below

### From within R interpreter

After starting R, you should see the following screen:

```R
R version 3.1.2 (2014-10-31) -- "Pumpkin Helmet"
Copyright (C) 2014 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> 
```

From that prompt, just type:

```R
> source("run_analysis.R")
```

And the following progress will be show:

```R
Attaching package: ‘dplyr’

The following object is masked from ‘package:stats’:

    filter

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

data.table 1.9.4  For help type: ?data.table
*** NB: by=.EACHI is now explicit. See README to restore previous behaviour.

Attaching package: ‘data.table’

The following objects are masked from ‘package:dplyr’:

    between, last

Processing...   Downloading dataset
data/dataset.zip has already been downloaded
data/dataset.zip has already been extracted
Processing...   Reading features
Processing...   Mutating feature names
Processing...   Done with features
Processing...   Reading activity labels
Processing...   Mutating activity labels
Processing...   Done with activity labels
Processing...   Reading training data
Processing...   Done with training data
Processing...   Reading test data
Processing...   Done with test data
Processing...   Summarising data
Processing...   Sorting data
Processing...   Writing tidy data
Processing done
> 
```

Once you're back that the *>* prompt, it means the script has finished running
and you have a new *dataset\_tidy.csv* file recreated.

### From command line

In order to run the script from within command line, we can tell R to take
input from our file, as can be seen below. We are also pasting a sample output
so users know what to expect when running this script.

```Bash
$ Rscript run_analysis.R

Attaching package: ‘dplyr’

The following object is masked from ‘package:stats’:

    filter

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union


Attaching package: ‘data.table’

The following objects are masked from ‘package:dplyr’:

    between, last

Processing...   Downloading dataset
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 59.6M  100 59.6M    0     0  12.0M      0  0:00:04  0:00:04 --:--:-- 12.9M
Processing...   Reading features
Processing...   Mutating feature names
Processing...   Done with features
Processing...   Reading activity labels
Processing...   Mutating activity labels
Processing...   Done with activity labels
Processing...   Reading training data
Processing...   Done with training data
Processing...   Reading test data
Processing...   Done with test data
Processing...   Summarising data
Processing...   Sorting data
Processing...   Writing tidy data
Processing done
```

## Output Tidy Dataset description

The resulting [Tidy
Dataset](https://github.com/felipebalbi/gacd-project/blob/wip/data/uci_har_dataset_tidy.csv),
a [Comma Separated Value
(CSV)](http://en.wikipedia.org/wiki/Comma-separated_values) file located at
data/uci\_har\_dataset\_tidy.csv, contains a total of 181 lines (1 header line
followed by 6 rows of observations for each of the 30 subjects).

A more complete description is available from our Codebook.md metadata file,
however we can briefly describe the structure of the data here.

Each row contains a total of 88 variables (88 different measurements for each
activity for each subject). A quick summary of the contents follows:

* id (Integer): Contains a subject identifier for each of the 30 subjects
  involved in the measurement.
* activity (Factor/Character): Activity involved with measurement. Valid values
  are:
	* walking
	* walking\_upstairs
	* walking\_downstairs
	* sitting
	* standing
	* laying
* 86 different numeric columns containing the average per subject per activity
  for all mean and standard deviation measurements. All data comes from
  measurements taken with Accelerometer and Gyroscope in all three directions
  (X, Y, and Z).

## Codebook.md

The metadata for our [Tidy
Dataset](https://github.com/felipebalbi/gacd-project/blob/wip/data/uci_har_dataset_tidy.csv)
is located in Codebook.md. That file describes all variables available in our
generated output data file and what type of value to expected for each column
of the table.

# R Package dependencies

*run\_analysis.R* depends on *dplyr* and *data.table*. We use *data.table*
instead of *data.frame* in most situations because of its fast operations on
larger data.

*dplyr* is used for its capabilities of selecting, arranging, filtering data in
a much more natural manner.

If you don't have those two packages installed, *run\_analysis.R* will try to
install them for you, but it will confirm with you first. If packages are
needed but you tell the script you don't want it to install them, execution
will stop with an error message. At which point, we expect the user to install
any missing packages manually using the command below and trying again.

```R
> install.packages(c("dplyr", "data.table"))
```

# Running Time

We can use *system.time()* for a rough estimation of the execution time for our
*run\_analysis.R* script. The system used was a Lenovo Desktop with a quad-core
Core I7 (4 cores, 8 threads) CPU running at 3.4GHz with 12GiB of RAM.

```
   user  system elapsed 
  5.012   0.000   5.013 
```

5 seconds to process a total of 270MiB of data isn't really a lot. We have
stopped looking for further optimizations once the time taken for this script
to run was down to an acceptable level.
