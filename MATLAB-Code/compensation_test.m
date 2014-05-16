%=========================================================================
%SCRIPT mx_correction.m
%   1) Filters the moments and acceleration within a range of provided
%      cutoff frequencies 
%   2) Passes the acceleration and the pitch moment into the mx_calibration
%      and mx_correction functions
%   3) Calculates the R^2 and the RMS before and after the compensation, as
%      well as the reduction in RMS
%   4) Produces plots comparing the simulated pitch moment and the measured
%      pitch moment
%   5) Produces compensation as a function of the cutoff frequency
%========================================================================

clc
clear

%------------------------------------------------------------------------
%Uploading Data Set 
%------------------------------------------------------------------------
   %Finding Directory and Obtaining Names
        allFiles = dir('Data');
        allNames = { allFiles.name };
        [slow_files,fast_files]=filename_parser(allNames);
     %Post-Processing
        slow_data=process_data(slow_files{1},slow_files{2},slow_files{3},slow_files{4});
        fast_data=process_data(fast_files{1},fast_files{2},fast_files{3},fast_files{4});
%-------------------------------------------------------------------------
%Filtering,Simulating,and Compensating
%-------------------------------------------------------------------------
    frequencies=6:6;
    for i=1:length(frequencies)
    statistics_table_slow=zeros(length(frequencies),5);
    statistics_table_fast=zeros(length(frequencies),5);
        %-------------------------
        %Data Set 1 (Slow)
        %-------------------------
            %Filter
                [moment_cal_filt_slow,moment_cor_filt_slow,acc_cal_filt_slow,acc_cor_filt_slow]=...
                filter_data(slow_data(:,3:6),frequencies(i));
            %Obtain Coefficients
                theta_slow=pitch_moment_calibration(acc_cal_filt_slow,moment_cal_filt_slow);
            %Simulate
                [moment_cal_sim_slow, ~]=pitch_moment_correction(acc_cal_filt_slow,moment_cal_filt_slow,theta_slow);
                [~, moment_corrected_slow]=pitch_moment_correction(acc_cor_filt_slow,moment_cor_filt_slow,theta_slow);
        %-------------------------
        %Data Set 2 (Fast)
        %-------------------------
            %Filter
                 [moment_cal_filt_fast,moment_cor_filt_fast,acc_cal_filt_fast,acc_cor_filt_fast]=...
                 filter_data(fast_data(:,3:6),frequencies(i));
            %Obtain Coefficients
                theta_fast=pitch_moment_calibration(acc_cal_filt_fast,moment_cal_filt_fast);
            %Simulate
                [moment_cal_sim_fast, ~]=pitch_moment_correction(acc_cal_filt_fast,moment_cal_filt_fast,theta_fast);
                [~, moment_corrected_fast]=pitch_moment_correction(acc_cor_filt_fast,moment_cor_filt_fast,theta_fast);
        %-----------------------------------
        %Plot Measured vs. Simulated @ 6 Hz
        %-----------------------------------
        if frequencies(i)==6
            slow_sim=[slow_data(100:end,1),moment_cal_filt_slow,moment_cal_sim_slow];
            fast_sim=[fast_data(100:end,1),moment_cal_filt_fast,moment_cal_sim_fast];
            plot_simulation_graphs(slow_sim,fast_sim)
            %Saving
                fpat='Results';
                figname1='Simulation_vs_Measured.eps';
                saveas(gcf,[fpat,filesep,figname1],'epsc');
        end
%-------------------------------------------------------------------------
%Calculate Statistics, Generate Table, Produce Frequency Plot
%-------------------------------------------------------------------------
    %Calculation
        statistics_table_slow_new=calculate_statistics(frequencies(i),moment_cor_filt_slow,moment_corrected_slow);
        statistics_table_fast_new=calculate_statistics(frequencies(i),moment_cor_filt_fast,moment_corrected_fast);
        statistics_table_slow(i,:)=statistics_table_slow_new;
        statistics_table_fast(i,:)=statistics_table_fast_new;
            %Save if Cutoff Frequency = 6 Hz
                if frequencies(i)==6
                    c={'R^2','Uncompensated','Compensated','Difference'}
                    results_table=[statistics_table_slow_new(2:end);statistics_table_fast_new(2:end)]
                    path = '\Results\';
                    tablename1 = 'statistical_results.txt';
                    dlmwrite([path tablename1],results_table,'\t'); 
                end
    end
    
    if length(frequencies)>1
        %Cutoff Frequency Plot
             slow_graphs=[statistics_table_slow(:,1),statistics_table_slow(:,3),statistics_table_slow(:,4)];
             fast_graphs=[statistics_table_fast(:,1),statistics_table_fast(:,3),statistics_table_fast(:,4)];
             plot_frequency_graphs(slow_graphs,fast_graphs)
                %Saving
                     figname2='CutoffFrequency.eps';
                     saveas(gcf,[fpat,filesep,figname2],'epsc')
    end
