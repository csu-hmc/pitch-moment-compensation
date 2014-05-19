Pitch Moment Compensation for Belt Acceleration of an Instrumented Treadmill
============================================================================

This is the source code which reproduces the results for the paper entitled:

"<insert final paper title here>"

The acceleration of the belt of a treadmill which is instrumented to measure
the ground reaction loads may introduce an undesired superimposed pitch moment.
This source code provides a computational method for reducing the effect the
belt accelerations have on the pitch moment measurement and produces all of the
results in the aforementioned publication.

Dependencies
============

- Matlab R2013b (8.2.0.701)
- Optimization Toolbox <version>
- Signal Processing Toolbox <version>

Basic Installation
==================

Download the source code

   $ wget https://github.com/csu-hmc/pitch-moment-compensation/archive/master.zip
   $ unzip pitch-moment-compensation-master.zip
   $ cd pitch-moment-compensation-master

Download the sample data files to a directory `<directory>`

   $ wget <insert link here>
   $ unzip pitch-moment-compensation-data.zip

TODO: We should zip the data into one file including the `Data` directory. Then
when you download and unzip in the main directory it drops it into the correct
spot. Also, the data is 20 mb zipped and ~55 mb unzipped.

Usage
=====

The complete results can be computed by starting Matlab with the main source
code directory in your Matlab path and typing the following at the command
prompt

   >> compensation_test

Once the function has run you will find all of the tables and plots in the
`Results` directory.

Computation Steps
=================

The data processing pipeline follows this general process:

1. Search for correct data filenames. (`filename_parser.m`)
2. Load data from tab separated ACSII data files. (`process_data.m`)
3. Synchronize the data with respect to time from the two files. (`process_data.m`)
4. Selects the pitch moment and the belt velocity from the data set. (`process_data.m`)
5. Computes belt acceleration by numerical differentiation.
   (`obtain_derivative.m`)
6. For each desired low pass cutoff frequency both signals are filtered.
   (`filter_data.m`)
7. Truncate the filtered data to avoid end effects. (`filter_data.m`)
8. Compute model coefficients for the belt acceleration pitch moment model.
   (`pitch_moment_calibration.m`)
9. Simulate the model with the acceleration as the independent variable.
   (`simulate.m`)
10. Subtract the difference in the pitch moment due to belt acceleration.
    (`simulate.m`)
11. Compute the coefficient of determination (R^2) of the model with respect to
    the data used to compute the model coefficients. (`caluclate_statistics.m`)
    TODO: I think it would be better to compute this value with respect to
    another data set if that is not being done.
12. Computes the RMS of data from one trial before and after the undesired
    forces have been subtracted. (`caluclate_statistics.m`)
13. Displays the table results for just the 6 hz filter frequency.
14. Shows plot of simulation versus actual data at 6 hz.
15. Shows a comparison of RMS with respect filter frequency for compensated
    and uncompensated.
16. Saves the graphs and the table to the `Results` data directory.
