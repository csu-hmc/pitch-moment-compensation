function plot_frequency_graphs(data1,data2)

%=========================================================================
%function PLOT_SIMULATION_GRAPHS
%      Plots a graph comparing the simulated and measured pitch moment
%
%------
%Input
%------
%    time      (Nsamples x 1)  Vector of timestamps from calibration
%    data1     (Nsamples x 3)  Array of frequency, RMS before compensation,
%                              and RMS after compensation for the first
%                              data set
%    data2     (Nsamples x 3)  Array of frequency, RMS before compensation,
%                              and RMS after compensation for the second
%                              data set
%-------
%Output
%-------
%    Automatically generates the plot
%=========================================================================
     figure(2)
     subplot(1,2,1)
     hold on
     plot(data1(:,1),data1(:,2),'b','Linewidth',2)
     plot(data1(:,1),data1(:,3),'r','Linewidth',2)
     xlabel('Frequency (Hz)','fontweight','bold')
     ylabel('Pitch Moment (Nm)','fontweight','bold')
     title('Cutoff Frequency, 1.2 m/s','Fontweight','bold','Fontsize',14)
     legend('Uncompensated','Compensated')

     subplot(1,2,2)
     hold on
     plot(data2(:,1),data2(:,2),'b','Linewidth',2)
     plot(data2(:,1),data2(:,3),'r','Linewidth',2)
     xlabel('Frequency (Hz)','fontweight','bold')
     ylabel('Pitch Moment (Nm)','fontweight','bold')
     title('Cutoff Frequency, 2 m/s','Fontweight','bold','Fontsize',14)
     legend('Uncompensated','Compensated')

end