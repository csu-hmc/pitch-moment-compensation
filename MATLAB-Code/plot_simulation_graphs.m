function plot_simulation_graphs(data1,data2)

%=========================================================================
%function PLOT_SIMULATION_GRAPHS
%      Plots a graph comparing the simulated and measured pitch moment
%
%------
%Input
%------
%    time      (Nsamples x 1)  Vector of timestamps from calibration
%    data1     (Nsamples x 3)  Array of time, recorded pitch moment, and
%                              simulated pitch moment from the first
%                              dataset
%    data2     (Nsamples x 3)  Array of time, recorded pitch moment, and
%                              simulated pitch moment from the second
%                              dataset
%-------
%Output
%-------
%    Automatically generates the plot
%========================================================================= 
     figure(1)
     subplot(1,2,1)
     hold on
     plot(data1(:,1),data1(:,2),'k--')
     plot(data1(:,1),data1(:,3),'r')
     xlabel('Time (s)','fontweight','bold')
     ylabel('Pitch Moment (Nm)','fontweight','bold')
     legend('Measured','Simulated')
     title('Simulation vs. Measurement, Data Set 1','Fontweight','bold','Fontsize',14)
     xlim([200 205])
     subplot(1,2,2)
     hold on
     plot(data2(:,1),data2(:,2),'k--')
     plot(data2(:,1),data2(:,3),'r')
     xlabel('Time (s)','fontweight','bold')
     ylabel('Pitch Moment (Nm)','fontweight','bold')
     legend('Measured','Simulated')
     title('Simulation vs. Measurement, Data Set 2','Fontweight','bold','Fontsize',14)
     xlim([200 205])
end