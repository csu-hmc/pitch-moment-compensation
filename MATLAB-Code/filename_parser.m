function [filenames_slow,filenames_fast]=filename_parser(allNames)

%=========================================================================
%function FILENAME_PARSER
%     Organizes the filenames of the data sets
%
%-------
%Inputs
%-------
%   allNames   (1 x NFiles)        Column vector of all filesnames in \Data
%
%--------
%Outputs
%--------
    %filenames_slow (1 x Nfiles)   Separated
%=========================================================================

    %Data Set 1, Slow
    velocity_cal_slow=allNames(:,find(ismember(allNames,'RandomSlowSpeed_1_Record.txt')));
    force_cal_slow=allNames(:,find(ismember(allNames,'RandomSlowSpeed_1_Mocap.txt')));
    velocity_cor_slow=allNames(:,find(ismember(allNames,'RandomSlowSpeed_2_Record.txt')));
    force_cor_slow=allNames(:,find(ismember(allNames,'RandomSlowSpeed_2_Mocap.txt')));
    filenames_slow=[force_cal_slow,velocity_cal_slow,force_cor_slow,velocity_cor_slow];

    %Data Set 2, Fast
    velocity_cal_fast=allNames(:,find(ismember(allNames,'RandomFastSpeed_1_Record.txt')));
    force_cal_fast=allNames(:,find(ismember(allNames,'RandomFastSpeed_1_Mocap.txt')));
    velocity_cor_fast=allNames(:,find(ismember(allNames,'RandomFastSpeed_2_Record.txt')));
    force_cor_fast=allNames(:,find(ismember(allNames,'RandomFastSpeed_2_Mocap.txt')));
    filenames_fast=[force_cal_fast,velocity_cal_fast,force_cor_fast,velocity_cor_fast];
end