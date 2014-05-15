function [moment_cal_filt,moment_cor_filt,acc_cal_filt,acc_cor_filt]=...
         filter_data(data_table, cutoff_frequency)

%=========================================================================
%function FILTER_DATA
%      Filters the data through a low-pass Butterworth filter based on the 
%      provided cutoff frequency.  Clips the first second from
%      the data to remove the initiation of the filter
%
%-------
%Inputs
%-------
%     data_table  (Nsamples x 4)  Array of pitch moment and
%                                 accelerations from both the
%                                 calibration and correction trials in
%                                 the form:
%                                 [Mom_cal, Mom_cor, Acc_cal, Acc_cor]
%     cutoff_frequency (scalar)   The desired cutoff frequency for the
%                                 %low-pass filter
%
%--------
%Outputs
%--------
%     moment_cal_filt   (Nsamples-100 x 1)  Filtered pitch moment (cal)
%     moment_cor_filt   (Nsamples-100 x 1)  Filtered pitch moment (cor)
%     acc_cal_filt      (Nsamples-100 x 1)  Filtered acceleration (cal)
%     acc_cor_filt      (Nsamples-100 x 1)  Filtered acceleration (cor)
%=========================================================================
    %Filtering
        [num,den]=butter(2,cutoff_frequency/(100/2));
        moment_cal_filt=filter(num,den,data_table(:,1));
        moment_cor_filt=filter(num,den,data_table(:,2));
        acc_cal_filt=filter(num,den,data_table(:,3));
        acc_cor_filt=filter(num,den,data_table(:,4));
    %Clip Transients
        moment_cal_filt=moment_cal_filt(100:end,:);
        moment_cor_filt=moment_cor_filt(100:end,:);
        acc_cal_filt=acc_cal_filt(100:end,:);
        acc_cor_filt=acc_cor_filt(100:end,:);