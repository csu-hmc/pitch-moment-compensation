function [derivative]=obtain_derivative(time, variable)

%=========================================================================
%FUNCTION obtain_derivative
%      Stuff
%
%--------
%Inputs
%--------
%   u_cal     (Nsamples x 1)    Column vector of recorded accelerations
%
%--------
%Outputs
%--------
%   theta     (6 x 1)           Column vector of the estimated coefficients
%
%--------------------------------------------------------------------------
     derivative=zeros(length(time)-2,1); 
        for i=2:length(time)-1
              der1 = (variable(i+1,:)- variable(i-1,:))/(time(i+1,:)- time(i-1,:));
            derivative(i-1,:)=der1;
        end