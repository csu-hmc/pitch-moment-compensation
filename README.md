Pitch Moment Compensation for Belt Acceleration of an Instrumented Treadmill
============================================================================

This is the source code which reproduces the results for the paper entitled:

"<insert final paper citation here>"

The acceleration of the belt of a treadmill which is instrumented to measure
the ground reaction loads may introduce an undesired superimposed pitch moment.
This source code provides a computational method for reducing the effect the
belt accelerations have on the pitch moment measurement and produces all of the
results in the aforementioned publication.

Dependencies
============

- Matlab R2014b (8.3.0.532)
- Optimization Toolbox (Version 7.0)
- Signal Processing Toolbox (Version 6.21)

Basic Installation
==================

Download the source code and data from the Git repository:

    $ wget https://github.com/csu-hmc/pitch-moment-compensation/archive/master.zip
    $ unzip pitch-moment-compensation-master.zip
    $ cd pitch-moment-compensation-master

Usage
=====

The complete results can be computed by starting Matlab with the main source
code directory in your Matlab path and typing the following at the command
prompt:

    >> compensation_test

Once the function has run you will find all of the plots in the `Results`
directory. For the cutoff frequency of interest, a table of results including
the reduction in the root-mean-square (RMS) between uncompensated and
compensated pitch moment and the R^2 fit between the model simulation output
and the measured acceleration.

Computation Steps
=================

The data processing pipeline follows this general process:

1. Specifies filenames located in the `Data` directory.
2. Loads data from tab separated ACSII data files (`load_data.m`). Data
   includes the timestamps, recorded belt velocities, and recorded pitch moment
   (Mx) from four data files (two slow speeds at 1.2 m/s and two fast speeds at
   (2.0 m/s).
3. Computes belt acceleration by numerical
   differentiation.(`obtain_derivative.m`)
4. Sets a range of desired cutoff frequencies for the lowpass filter (1-20 Hz).
   Also sets a cutoff frequency of interest (6 Hz).
5. Filters signals (acceleration and pitch moment) with the cutoff
   frequency(`filter_data.m`)
6. Computes model coefficients for the belt acceleration pitch moment model.
   (`pitch_moment_calibration.m`)
7. Simulates the model with the acceleration as the independent variable.
   (`simulate.m`)
8. Truncates the filtered data to avoid end effects (one second from beginning
   and end of the trial. (`simulate.m`)
9. Subtracts the difference in the pitch moment due to belt acceleration.
    (`simulate.m`)
10. Computes the coefficient of determination (R^2) of the model with respect to
    the data from the other trial. (`caluclate_statistics.m`)
11. Computes the RMS of the uncompensated and compensated pitch moment of the
    trials, as well as the percent reduction (`caluclate_statistics.m`)
11. Displays the table of results for the desired frequency (6 Hz).
12. Shows a plot of simulation versus actual data at the desired frequency (6
    Hz).  (`plot_simulation_graphs.m`)
13. Shows a comparison of RMS with respect to the filter frequency for
    compensated and uncompensated. (`plot_frequency_graphs.m`). If the range of
    the cutoff frequencies is 1, then the graph will not generate.
14. Saves the graphs to the `Results` data directory.
