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
options=optimoptions('fmincon','Display','notify');
theta=fmincon(@optimize,thetaguess,[],[],[],[],-10*ones(6,1),10*ones(6,1),[],options);
   
%-------------------------------------------------------------------------
%Optimization to Reduce Error Between Simulated and Recorded Pitch Moment
%-------------------------------------------------------------------------
    function [f]=optimize(theta)
    ysim=simulate(u_cal,theta);
    f=norm(ysim-y_cal);
    end
%-------------------------------------------------------------------------
%Simulation Using a Second-Order Model and the Estimated Coefficients
%-------------------------------------------------------------------------
    function [ysim]=simulate(uk,theta)
    ysim=zeros(length(uk),1);
    for i=1:length(uk)
        if i==1
            ysim(1,:)=theta(3,:)*uk(i)+theta(6,:);
        else if i==2
            ysim(2,:)=-theta(1,:)*ysim(i-1)+theta(3,:)*uk(i)...
                      +theta(4,:)*uk(i-1)+theta(6,:);
        else 
            ysim(i)=-theta(1,:)*ysim(i-1)-theta(2,:)*ysim(i-2)+....
                     theta(3,:)*uk(i)+theta(4,:)*uk(i-1)+...
                     theta(5,:)*uk(i-2)+theta(6,:);
            end
        end
    end
    end
    end