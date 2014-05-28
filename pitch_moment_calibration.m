function [theta]=pitch_moment_calibration(acc,moment)

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
%   acc       (Nsamples x 1)    Column vector of recorded accelerations
%                               from the calibration trial
%   moment     (Nsamples x 1)   Column vector of recorded pitch moment
%                               from the calibration trial
%--------
%Outputs
%--------
%   theta     (6 x 1)           Column vector of the estimated coefficients
%                               from the second-order model and
%                               optimization
%
%--------------------------------------------------------------------------

thetaguess=zeros(5,1)+0.001;
options=optimoptions('fmincon','Display','notify');
theta=fmincon(@optfunc,thetaguess,[],[],[],[],-10*ones(5,1),10*ones(5,1),[],options);
   
%-------------------------------------------------------------------------
%Optimization to Reduce Error Between Simulated and Recorded Pitch Moment
%-------------------------------------------------------------------------
    function [f]=optfunc(theta)
        [moment_simulated,~]=simulate(acc,moment,theta);
        f=norm(moment_simulated-moment(100:end-100,:));
    end
end