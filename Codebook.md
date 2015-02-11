# Getting and Cleaning Data - Data Science Specialization - Coursera
## Course Project
### Author: Felipe Balbi
### Email: balbif@gmail.com
=====================================================================

The uci\_har\_dataset\_tidy.csv contains data for 30 subjects, 8 records for
each subject (1 record for each of the 6 activities).

Field Label | Variable | Variable Type | Allowable Values | Comments
:-----------|:---------|:--------------|:-----------------|:---------
id  | Subject Identifier | numeric | 1 through 30
activity  | Activity Name | Character / Factor | standing, sitting, laying, walking, walking\_downstairs, walking\_upstairs
t.body.acc.mean.x  | Time Domain Body Acceleration Mean On X Axis | numeric | any
t.body.acc.mean.y  | Time Domain Body Acceleration Mean On Y Axis | numeric | any
t.body.acc.mean.z  | Time Domain Body Acceleration Mean On Z Axis | numeric | any
t.body.acc.std.x  | Time Domain Body Acceleration Standard Deviation On X Axis | numeric | any
t.body.acc.std.y  | Time Domain Body Acceleration Standard Deviation On Y Axis | numeric | any
t.body.acc.std.z  | Time Domain Body Acceleration Standard Deviation On Z Axis | numeric | any
t.gravity.acc.mean.x  | Time Domain Gravity Acceleration Mean On X Axis | numeric | any
t.gravity.acc.mean.y  | Time Domain Gravity Acceleration Mean On Y Axis | numeric | any
t.gravity.acc.mean.z  | Time Domain Gravity Acceleration Mean On Z Axis | numeric | any
t.gravity.acc.std.x  | Time Domain Gravity Acceleration Standard Deviation On X Axis | numeric | any
t.gravity.acc.std.y  | Time Domain Gravity Acceleration Standard Deviation On Y Axis | numeric | any
t.gravity.acc.std.z  | Time Domain Gravity Acceleration Standard Deviation On Z Axis | numeric | any
t.body.acc.jerk.mean.x  | Time Domain Body Acceleration Jerk Mean On X Axis | numeric | any
t.body.acc.jerk.mean.y  | Time Domain Body Acceleration Jerk Mean On Y Axis | numeric | any
t.body.acc.jerk.mean.z  | Time Domain Body Acceleration Jerk Mean On Z Axis | numeric | any
t.body.acc.jerk.std.x  | Time Domain Body Acceleration Jerk Standard Deviation On X Axis | numeric | any
t.body.acc.jerk.std.y  | Time Domain Body Acceleration Jerk Standard Deviation On Y Axis | numeric | any
t.body.acc.jerk.std.z  | Time Domain Body Acceleration Jerk Standard Deviation On Z Axis | numeric | any
t.body.gyro.mean.x  | Time Domain Body Angular Speed Mean On X Axis | numeric | any
t.body.gyro.mean.y  | Time Domain Body Angular Speed Mean On Y Axis | numeric | any
t.body.gyro.mean.z  | Time Domain Body Angular Speed Mean On Z Axis | numeric | any
t.body.gyro.std.x  | Time Domain Body Angular Speed Standard Deviation On X Axis | numeric | any
t.body.gyro.std.y  | Time Domain Body Angular Speed Standard Deviation On Y Axis | numeric | any
t.body.gyro.std.z  | Time Domain Body Angular Speed Standard Deviation On Z Axis | numeric | any
t.body.gyro.jerk.mean.x  | Time Domain Body Angular Speed Jerk Mean On X Axis | numeric | any
t.body.gyro.jerk.mean.y  | Time Domain Body Angular Speed Jerk Mean On Y Axis | numeric | any
t.body.gyro.jerk.mean.z  | Time Domain Body Angular Speed Jerk Mean On Z Axis | numeric | any
t.body.gyro.jerk.std.x  | Time Domain Body Angular Speed Jerk Standard Deviation On X Axis | numeric | any
t.body.gyro.jerk.std.y  | Time Domain Body Angular Speed Jerk Standard Deviation On Y Axis | numeric | any
t.body.gyro.jerk.std.z  | Time Domain Body Angular Speed Jerk Standard Deviation On Z Axis | numeric | any
t.body.acc.mag.mean  | Time Domain Body Acceleration Magnitude Mean | numeric | any
t.body.acc.mag.std  | Time Domain Body Acceleration Magnitude Standard Deviation | numeric | any
t.gravity.acc.mag.mean  | Time Domain Gravity Acceleration Magnitude Mean | numeric | any
t.gravity.acc.mag.std  | Time Domain Gravity Acceleration Magnitude Standard Deviation | numeric | any
t.body.acc.jerk.mag.mean  | Time Domain Body Acceleration Jerk Magnitude Mean | numeric | any
t.body.acc.jerk.mag.std  | Time Domain Body Acceleraton Jerk Magnitude Standard Deviation | numeric | any
t.body.gyro.mag.mean  | Time Domain Body Angular Speed Magnitude Mean | numeric | any
t.body.gyro.mag.std  | Time Domain Body Angular Speed Magnitude Standard Deviation | numeric | any
t.body.gyro.jerk.mag.mean  | Time Domain Body Angular Speed Jerk Magnitude Mean | numeric | any
t.body.gyro.jerk.mag.std  | Time Domain Body Angular Speed Jerk Magnitude Standard Deviation | numeric | any
f.body.acc.mean.x  | Frequency Domain Body Acceleration Mean On X Axis | numeric | any
f.body.acc.mean.y  | Frequency Domain Body Acceleration Mean On Y Axis | numeric | any
f.body.acc.mean.z  | Frequency Domain Body Acceleration Mean On Z Axis | numeric | any
f.body.acc.std.x  | Frequency Domain Body Acceleration Standard Deviation On X Axis | numeric | any
f.body.acc.std.y  | Frequency Domain Body Acceleration Standard Deviation On Y Axis | numeric | any
f.body.acc.std.z  | Frequency Domain Body Acceleration Standard Deviation On Z Axis | numeric | any
f.body.acc.meanfreq.x  | Frequency Domain Body Acceleration Mean Frequency On X Axis | numeric | any
f.body.acc.meanfreq.y  | Frequency Domain Body Acceleration Mean Frequency On Y Axis | numeric | any
f.body.acc.meanfreq.z  | Frequency Domain Body Acceleration Mean Frequency On Z Axis | numeric | any
f.body.acc.jerk.mean.x  | Frequency Domain Body Acceleration Jerk Mean On X Axis | numeric | any
f.body.acc.jerk.mean.y  | Frequency Domain Body Acceleration Jerk Mean On Y Axis | numeric | any
f.body.acc.jerk.mean.z  | Frequency Domain Body Acceleration Jerk Mean On Z Axis | numeric | any
f.body.acc.jerk.std.x  | Frequency Domain Body Acceleration Jerk Standard Deviation On X Axis | numeric | any
f.body.acc.jerk.std.y  | Frequency Domain Body Acceleration Jerk Standard Deviation On Y Axis | numeric | any
f.body.acc.jerk.std.z  | Frequency Domain Body Acceleration Jerk Standard Deviation On Z Axis | numeric | any
f.body.acc.jerk.meanfreq.x  | Frequency Domain Body Acceleration Jerk Mean Frequency On X Axis | numeric | any
f.body.acc.jerk.meanfreq.y  | Frequency Domain Body Acceleration Jerk Mean Frequency On Y Axis | numeric | any
f.body.acc.jerk.meanfreq.z  | Frequency Domain Body Acceleration Jerk Mean Frequency On Z Axis | numeric | any
f.body.gyro.mean.x  | Frequency Domain Body Angular Speed Mean On X Axis | numeric | any
f.body.gyro.mean.y  | Frequency Domain Body Angular Speed Mean On Y Axis | numeric | any
f.body.gyro.mean.z  | Frequency Domain Body Angular Speed Mean On Z Axis | numeric | any
f.body.gyro.std.x  | Frequency Domain Body Angular Speed Standard Deviation On X Axis | numeric | any
f.body.gyro.std.y  | Frequency Domain Body Angular Speed Standard Deviation On Y Axis | numeric | any
f.body.gyro.std.z  | Frequency Domain Body Angular Speed Standard Deviation On Z Axis | numeric | any
f.body.gyro.meanfreq.x  | Frequency Domain Body Angular Speed Mean Frequency On X Axis | numeric | any
f.body.gyro.meanfreq.y  | Frequency Domain Body Angular Speed Mean Frequency On Y Axis | numeric | any
f.body.gyro.meanfreq.z  | Frequency Domain Body Angular Speed Mean Frequency On Z Axis | numeric | any
f.body.acc.mag.mean  | Frequency Domain Body Acceleration Magnitude Mean | numeric | any
f.body.acc.mag.std  | Frequency Domain Body Acceleration Magnitude Standard Deviation | numeric | any
f.body.acc.mag.meanfreq  | Frequency Domain Body Acceleration Magnitude Mean Frequency | numeric | any
f.body.acc.jerk.mag.mean  | Frequency Domain Body Acceleration Jerk Magnitude Mean | numeric | any
f.body.acc.jerk.mag.std  | Frequency Domain Body Acceleration Jerk Magnitude Standard Deviation | numeric | any
f.body.acc.jerk.mag.meanfreq  | Frequency Domain Body Acceleration Jerk Magnitude Mean Frequency | numeric | any
f.body.gyro.mag.mean  | Frequency Domain Body Angular Speed Magnitude Mean | numeric | any
f.body.gyro.mag.std  | Frequency Domain Body Angular Speed Magnitude Standard Deviation | numeric | any
f.body.gyro.mag.meanfreq  | Frequency Domain Body Angular Speed Magnitude Mean Frequency | numeric | any
f.body.gyro.jerk.mag.mean  | Frequency Domain Body Angular Speed Jerk Magnitude Mean | numeric | any
f.body.gyro.jerk.mag.std  | Frequency Domain Body Angular Speed Jerk Magnitude Standard Deviation | numeric | any
f.body.gyro.jerk.mag.meanfreq  | Frequency Domain Body Angular Speed Jerk Magnitude Mean Frequency | numeric | any
angle.tbody.acc.mean.gravity  | Angle Time Domain Body Acceleration Mean vs Gravity | numeric | any
angle.tbody.acc.jerk.mean.gravity.mean  | Angle Time Domain Body Acceleration Jerk Mean vs Gravity Mean | numeric | any
angle.tbody.gyro.mean.gravity.mean  | Angle Time Domain Angular Speed Mean vs Gravity Mean | numeric | any
angle.tbody.gyro.jerk.mean.gravity.mean  | Angle Time Domain Body Angular Speed Jerk Mean vs Gravity Mean | numeric | any
angle.x.gravity.mean  | Angle X Axis vs Gravity Mean | numeric | any
angle.y.gravity.mean  | Angle Y Axis vs Gravity Mean | numeric | any
angle.z.gravity.mean  | Angle Z Axis vs Gravity Mean | numeric | any
