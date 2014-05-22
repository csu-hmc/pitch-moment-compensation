function [all_data]=load_data(filename1,filename2)

%=========================================================================
%function FILENAME_PARSER
%     Loads the filenames passed by the user and creates a data matrix
%     for the compensation_test.m script 
%
%-------
%Inputs
%-------
%   filename1   string         The filename of the calibration trial
%   filename2   string         The filename of the data to be corrected
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
    addpath('Data')
    data1=load(filename1);
    data2=load(filename2);
%Creating Data Matrix
    all_data=[data1(:,1) data2(:,1)...    %TimeStamps
              data1(:,2) data2(:,2)...    %Pitch Moments
              data1(:,3) data2(:,3)];     %Belt Velocities
end