function [all_data]=load_data(filename1,filename2)

%=========================================================================
%function load_data
%     Loads the filenames passed by the user and creates a data matrix
%     for the compensation_test.m script.
%
%-------
%Inputs
%-------
%   filename1   char          The filename of the calibration trial
%   filename2   char          The filename of the data to be corrected
%
%--------
%Outputs
%--------
%   all_data  (Nsamples x 6)  An array containing the the time, pitch
%                             moment, and velocity for the calibration and
%                             correction trials of the form:
%                             [t_cal t_cor m_cal m_cor v_cal_v_cor]
%=========================================================================

%Loading
    data1=importdata(['Data' filesep filename1]);
    data2=importdata(['Data' filesep filename2]);
%Creating Data Matrix
    all_data=[data1.data(:,1) data2.data(:,1)...    %TimeStamps
              data1.data(:,2) data2.data(:,2)...    %Pitch Moments
              data1.data(:,3) data2.data(:,3)];     %Belt Velocities
end
