function [time, velocity]=record_module_read(record_module_filename)

%=========================================================================
%FUNCTION record_module_read
%   1) Loads a file recorded from D-Flow's record module
%   2) Separates the time and left and right belt speed, for the purpose
%      of using in the pitch_moment_calibration and pitch_moment_correction
%
%--------
%Inputs
%--------
%   record_module_filename      In the format: 'filename.txt'
%--------
%Outputs
%--------
%   time             (Nsamples x 1) Column vector of recorded timestamps
%   velocity         (Nsamples x 1) Column vector of recorded belt velocity
%=========================================================================
     velocity_cal=load(record_module_filename);
     time=velocity_cal(:,1);
     time=time-time(1,1);
     velocity=velocity_cal(:,2);
end
