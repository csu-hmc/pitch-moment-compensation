function [mx_sim,mx_corrected]=pitch_moment_correction(u_cor,y_cor,theta)

%=========================================================================
%FUNCTION mx_correction
%   1) Compensates for inertial errors in pitch moment due to the 
%      rotation of the treadmill rollers.  
%   2) Simulates the pitch moment by using recorded accelerations and 
%      the coefficients obtained from the calibration function mx_calibration
%   3) Compensates the pitch moment by subtracting the simulated pitch
%      moment from the pitch moment obtained from the experiment.  
%
%--------
%Inputs
%--------
%   u_cor     (Nsamples x 1)    Column vector of recorded accelerations
%                               from the trial to be corrected
%   y_cor     (Nsamples x 1)    Column vector of recorded pitch moment
%                               from the trial to be corrected
%   theta     (6 x 1)           Column vector coefficients obtained from the
%                               mx_calibration function
%--------
%Outputs
%--------
%   mx_sim       (Nsamples x 1) Column vector with simulated pitch moment
%                               after applying the coefficients from the
%                               calibration trial
%   mx_corrected (Nsamples x 1) Column vector of corrected pitch moment 
%                               after substracting the simulation from the
%                               recorded data
%=========================================================================

    ysim=zeros(length(u_cor),1);
    for i=1:length(u_cor)
        if i==1
            ysim(1,:)=theta(3,:)*u_cor(i)+theta(6,:);
        else if i==2
            ysim(2,:)=-theta(1,:)*ysim(i-1)+theta(3,:)*u_cor(i)+...
                       theta(4,:)*u_cor(i-1)+theta(6,:);
        else 
            ysim(i)=-theta(1,:)*ysim(i-1)-theta(2,:)*ysim(i-2)+...
                     theta(3,:)*u_cor(i)+theta(4,:)*u_cor(i-1)+...
                     theta(5,:)*u_cor(i-2)+theta(6,:);
            end
        end
        mx_sim=ysim;
        mx_corrected=y_cor-ysim;
    end
 end