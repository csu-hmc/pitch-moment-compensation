function [theta]=pitch_moment_calibration(u_cal,y_cal)

%=========================================================================
%FUNCTION mx_calibration
%      Estimates the coefficients of a second-order model using the data 
%      from the calibration trial.  Coefficients are estimated using the   
%      simulation and optimization function, where theta is optimized by
%      minimizing the error between the measured and simulated pitch
%      moment.
%
%--------
%Inputs
%--------
%   u_cal     (Nsamples x 1)    Column vector of recorded accelerations
%                               from the calibration trial
%   y_cal     (Nsamples x 1)    Column vector of recorded pitch moment
%                               from the calibration trial
%--------
%Outputs
%--------
%   theta     (6 x 1)           Column vector of the estimated coefficients
%                               from the second-order model and
%                               optimization
%
%--------------------------------------------------------------------------

    thetaguess=rand(6,1);
    theta=fmincon(@optfunc,thetaguess,[],[],[],[],-10*ones(6,1),10*ones(6,1));
   
%-------------------------------------------------------------------------
%Optimization to Reduce Error Between Simulated and Recorded Pitch Moment
%-------------------------------------------------------------------------
    function [f]=optfunc(theta)
        [ysim,~]=simulate(u_cal,theta);
        f=norm(ysim-y_cal);
    end

end
  