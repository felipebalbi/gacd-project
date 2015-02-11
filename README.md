# Getting and Cleaning Data Course Project - Data Science Specialization - Coursera
## Peer assessment project
### Author: Felipe Balbi
### Email: balbif@gmail.com
=====================================================================

# Description of Files

This repository contains an R script which will download and clean source data
and also generate a *Tidy Dataset* for further consumption later on. Together
with it, we're also providing a README.md file (this exact file which you're
reading now) describing the project as a whole, and a Codebook.md file which
describes the variables within our *Tidy Dataset*.


There are a total of 4 (four) files within this repository, which we describe
below:

* README.md: This very file, describing the project as a whole;
* run\_analysis.R: An R script containing code to download, extract, clean,
  merge, select and generate a *Tidy Dataset* in CSV (Comma Separated Value)
  file;
* Codebook.md: Serving as *metadata* for our *Tidy Dataset*, Codebook.md
  describes all variables contained within our dataset so it becomes easier for
  anybody processing our data further down the line.
* dataset\_tidy.csv: This is our *Tidy Dataset* as mentioned multiple times
  above. Here you can find all cleaned up data which our script was able to
  generate.

## Script run\_analysis.R

The whole idea when developing this script is that it would be as
self-contained as possible. Due to that, we made sure the script knows how to
download its own source data, extract it and only then start processing, merging,
cleaning, etc.

There are two ways of running this script, both described in subsections below

### From command line

In order to run the script from within command line, we can tell R to take
input from our file, as can be seen below. We are also pasting a sample output
so users know what to expect when running this script.

```Bash
$ R --no-save --quiet --slave -f run_analysis.R

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

Options passed to R interpreter are described below:

* --no-save: tells R that we don't want to save the resulting workspace (mandatory)
* --quiet: tells R to run quietly (optional)
* --slave: tells R to run as silently as possible (optional)

Without *--slave*, R will print out the entire *run\_analysis.R* script before
starting it. That was deemed unnecessary so *--slave* was added to command line
arguments.

### From within R interpreter

After starting R, you should see the following screen:

```
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

## Output Tidy Dataset description

The resulting *Tidy Dataset* contains a total of 181 lines (1 header line
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

## R Package dependencies

*run\_analysis.R* depends on *dplyr* and *data.table*. We use *data.table*
instead of *data.frame* in most situations because of its fast operations on
larger data.

*dplyr* is used for its capabilities of selecting, arranging, filtering data in
a much more natural manner.

If you don't have those two packages installed, *run\_analysis.R* will not be
able to run. Make sure they are installed with the following command:

```R
> install.packages(c("dplyr", "data.table"))
```

## Performance

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
