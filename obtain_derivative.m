function [new_data]=obtain_derivative(all_data)

%=========================================================================
%FUNCTION obtain_derivative
%      Calculates the acceleration of the calibration and correction trials
%      by taking the derivative of the belt velocity.  Clips the first
%      frame of the time, pitch moment, and acceleration to remove any NAN
%      that can occur with taking the derivative
%
%--------
%Inputs
%--------
%   all_data  (Nsamples x 6)  An array containing the the time, pitch 
%                             moment, and velocity for the calibration and
%                             correction trials of the form:
%                             [t_cal t_cor m_cal m_cor v_cal_v_cor]
%--------
%Outputs
%--------
%   new_data  (Nsamples x 6)  An array containing the the time, pitch 
%                             moment, and acceleration for the calibration and
%                             correction trials of the form:
%                             [t_cal t_cor m_cal m_cor a_cal_a_cor]
%
%--------------------------------------------------------------------------

%-----------------------------------------------------------------------
%Defining Variables
%-----------------------------------------------------------------------
    time_cal=all_data(:,1);     time_cor=all_data(:,2);
    moment_cal=all_data(:,3);   moment_cor=all_data(:,4);
    velocity_cal=all_data(:,5); velocity_cor=all_data(:,6);
%-----------------------------------------------------------------------
%Obtaining Acceleration
%-----------------------------------------------------------------------
    %Calibration 
        acc_cal=zeros(length(time_cal)-2,1); 
        for i=2:length(time_cal)-1
              acc_cal1 = (velocity_cal(i+1,:)- velocity_cal(i-1,:))/(time_cal(i+1,:)- time_cal(i-1,:));
              acc_cal(i-1,:)=acc_cal1;
        end
    %Correction    
        acc_cor=zeros(length(time_cor)-2,1); 
        for i=2:length(time_cor)-1
              acc_cor1 = (velocity_cor(i+1,:)- velocity_cor(i-1,:))/(time_cor(i+1,:)- time_cor(i-1,:));
              acc_cor(i-1,:)=acc_cor1;
        end
%-----------------------------------------------------------------------
%Creating Data Matrix
%-----------------------------------------------------------------------
     new_data=[time_cal(2:end-2,:) time_cor(2:end-2,:)...
               moment_cal(2:end-2,:)  moment_cor(2:end-2,:)...
               acc_cal(1:end-1,:) acc_cor(1:end-1,:)];
end