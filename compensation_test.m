%=========================================================================
%SCRIPT mx_correction.m
%   1) Loads data
%   2) Obtains acceleration from belt velocity using obtain_derivative.m
%   3) Filters the belt accelerations and pitch moments
%   4) Passes the acceleration and the pitch moment into the 
%      pitch_moment_calibration and simulate functions
%   3) Calculates the R^2 and the RMS before and after the compensation, as
%      well as the reduction in RMS. Displays a table at the desired 
%      cutoff frequency
%   4) Produces plots comparing the simulated pitch moment and the measured
%      pitch moment at the desired cutoff frequency
%   5) Produces a plot of the pitch moment RMS before and after compensation
%      as a function of the range of cutoff frequencies (only if the range
%      is greater than one)
%========================================================================

clc
clear

%-------------------------------------------------------------------------
%Uploading Data Set 
%-------------------------------------------------------------------------
   display('Starting Computation...')
   %Specifying Filenames
        display('Loading Data...')
        filename_slow1='RandomSlowSpeed1.txt';
        filename_slow2='RandomSlowSpeed2.txt';
        filename_fast1='RandomFastSpeed1.txt';
        filename_fast2='RandomFastSpeed2.txt';
   %Loading Data
        [slow_data_vel]=load_data(filename_slow1,filename_slow2);
        [fast_data_vel]=load_data(filename_fast1,filename_fast2);
%-------------------------------------------------------------------------
%Obtaining Belt Acceleration
%-------------------------------------------------------------------------
    display('Calculating Belt Acceleration...')
    %Acceleration
        [slow_data]=obtain_derivative(slow_data_vel);
        [fast_data]=obtain_derivative(fast_data_vel);
%-------------------------------------------------------------------------
%Filtering,Simulating,and Compensating
%-------------------------------------------------------------------------
    %Range of Cutoff Frequencies
        frequencies=1:20;
        desired_frequency=6;
    %Preallocating Statistics Tables
        stat_table_slow=zeros(length(frequencies),5);
        stat_table_fast=zeros(length(frequencies),5);
    %Begin Compensation
    for i=1:length(frequencies)
        fprintf('Estimating Model Coefficients and Simulating for %d Hz...\n', frequencies(i))
        %-------------------------
        %Filtering
        %-------------------------
            [m_cal_filt_slow,m_cor_filt_slow,a_cal_filt_slow,a_cor_filt_slow]=...
                            filter_data(slow_data(:,3:6),frequencies(i));
            [m_cal_filt_fast,m_cor_filt_fast,a_cal_filt_fast,a_cor_filt_fast]=...
                            filter_data(fast_data(:,3:6),frequencies(i));
        %-------------------------
        %Obtaining Coefficients
        %-------------------------
            theta_slow=pitch_moment_calibration(a_cal_filt_slow,m_cal_filt_slow);
            theta_fast=pitch_moment_calibration(a_cal_filt_fast,m_cal_filt_fast);
        %----------------------------
        %Simulation and Compensation
        %-----------------------------
            %Simulation Results
                [m_cal_sim_slow, ~]=simulate(a_cal_filt_slow,m_cal_filt_slow,theta_slow);
                [m_cal_sim_fast, ~]=simulate(a_cal_filt_fast,m_cal_filt_fast,theta_fast);
            %Compensation
                [~, m_corrected_slow]=simulate(a_cor_filt_slow,m_cor_filt_slow,theta_slow);
                [~, m_corrected_fast]=simulate(a_cor_filt_fast,m_cor_filt_fast,theta_fast);  
        %-------------------------------------------------
        %Plot Measured vs. Simulated at Desired Frequency
        %-------------------------------------------------
            if frequencies(i)==desired_frequency
                slow_sim=[slow_data(100:end-100,1),m_cal_filt_slow(100:end-100,:),m_cal_sim_slow];
                fast_sim=[fast_data(100:end-100,1),m_cal_filt_fast(100:end-100,:),m_cal_sim_fast];
                plot_simulation_graphs(slow_sim,fast_sim)
            end
        %----------------------------------------------------------------
        %Calculate Statistics
        %----------------------------------------------------------------
            %Calculation
                stat_table_slow_new=calculate_statistics(frequencies(i),...
                                          m_cor_filt_slow(100:end-100,:),m_corrected_slow);
                stat_table_fast_new=calculate_statistics(frequencies(i),...
                                          m_cor_filt_fast(100:end-100,:),m_corrected_fast);
                stat_table_slow(i,:)=stat_table_slow_new;
                stat_table_fast(i,:)=stat_table_fast_new;
                %Display and Save at Desired Frequency
                     if frequencies(i)==desired_frequency
                        results_table=[stat_table_slow_new(2:end);stat_table_fast_new(2:end)];
                        fprintf('________________________________________________________\n')
                        fprintf('  R^2   RMS Before   RMS After   RMS Reduction      \n')
                        fprintf('_________________________________________________________\n')
                        fprintf('  %2.2f    %2.2f        %2.2f         %2.2f          \n',results_table')
                        fprintf('________________________________________________________\n\n')
                    %Update Simulation Graph with R^2 
                        figure(1)
                        subplot(1,2,1)
                        legend('Measured',sprintf('Simulated (%2.2f%%)',results_table(1,1)*100))
                        subplot(1,2,2)
                        legend('Measured',sprintf('Simulated (%2.2f%%)',results_table(2,1)*100))
                        %Saving
                            fpat='Results';
                            figname1='Simulation_vs_Measured.eps';
                            saveas(gcf,[fpat,filesep,figname1],'epsc');
                     end
    end
        %-----------------------------------------------------------------
        %Plot Cutoff Frequency vs. Pitch Moment Graph
        %-----------------------------------------------------------------
            if length(frequencies)>1
            %Cutoff Frequency Plot
                slow_graphs=[stat_table_slow(:,1),stat_table_slow(:,3),stat_table_slow(:,4)];
                fast_graphs=[stat_table_fast(:,1),stat_table_fast(:,3),stat_table_fast(:,4)];
                plot_frequency_graphs(slow_graphs,fast_graphs,desired_frequency)
                %Saving
                     figname2='CutoffFrequency.eps';
                     saveas(gcf,[fpat,filesep,figname2],'epsc')
            end
    display('Computation Completed.')