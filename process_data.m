function processed_data=process_data(forces_cal,velocity_cal,...
                                     forces_cor,velocity_cor)

%=========================================================================
%function PROCESS_DATA
%   1) Loads the corresponding calibration and validation data files 
%      obtained from the experiment  
%   2) Interpolates the sampling rate of measured belt velocity (D-Flow 
%      Record Module ~ 300 Hz) to the sampling rate of the pitch moment 
%      (D-Flow Mocap Module ~ 100 Hz)
%   3) Parses the pitch moment (Mx) from the GRF data
%   4) Obtains the acceleration by taking the derivative of the belt
%      velocity
%   5) Generates a table of the time, pitch moment, and acceleration for
%      both trials 
%
%--------
%Inputs
%--------
%     forces_cal         MOCAP filename containing the recorded pitch 
%                        moment from the calibration trial
%     velocity_cal       RECORD filename containing the recorded belt 
%                        velocity from the calibration trial
%     forces_cor         MOCAP filename containing the recorded pitch 
%                        moment to be corrected
%     velocity_cor       RECORD filename containing the recorded belt
%                        velocity from the trial to be corrected
%--------
%Outputs
%--------
%     processed_data   (Nsamples x 6) Array containing the time, pitch
%                                     moments, and accelerations from both 
%                                     the calibration and correction trials
%                                     
%=========================================================================

addpath('Data')
%-------------------------------------------------------------------------
%File Upload 
%-------------------------------------------------------------------------
    %Belt Velocity Calibration Data (RECORD)
        [t_velocity_cal,speed_cal]=record_module_read(velocity_cal);
    %GRF Calibration Data (MOCAP)
        [t_force_cal,~,c_force_cal,d_force_cal]=CarenRead(forces_cal);
        t_force_cal=t_force_cal-t_force_cal(1,1);
    %Belt Velocity Correction Data (RECORD)
        [t_velocity_cor,speed_cor]=record_module_read(velocity_cor);
    %GRF Correction Data (MOCAP)
        [t_force_cor,~,c_force_cor,d_force_cor]=CarenRead(forces_cor);
        t_force_cor=t_force_cor-t_force_cor(1,1); 
%-------------------------------------------------------------------------
%Interpolating
%-------------------------------------------------------------------------
     speed_cal_adj=interp1(t_velocity_cal,speed_cal,t_force_cal);
     speed_cor_adj=interp1(t_velocity_cor,speed_cor,t_force_cor);
%-------------------------------------------------------------------------
%Parsing Pitch Moment
%-------------------------------------------------------------------------
     moment_cal=d_force_cal(:,find(ismember(c_force_cal,'FP1.MomX')));
     moment_cor=d_force_cor(:,find(ismember(c_force_cor,'FP1.MomX')));
 %------------------------------------------------------------------------
 %Calculating Belt Acceleration
 %------------------------------------------------------------------------
     acc_cal=obtain_derivative(t_force_cal, speed_cal_adj);
     acc_cor=obtain_derivative(t_force_cor, speed_cor_adj);
 %------------------------------------------------------------------------
 %Create Table and Save File
 %------------------------------------------------------------------------
     processed_data=[t_force_cal(2:end-2,:) t_force_cor(2:end-2,:)...
                     moment_cal(2:end-2,:)  moment_cor(2:end-2,:)...
                     acc_cal(1:end-1,:) acc_cor(1:end-1)];
end