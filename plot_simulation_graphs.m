function plot_simulation_graphs(data1,data2)

%=========================================================================
%function PLOT_SIMULATION_GRAPHS
%      Plots a graph comparing the simulated and measured pitch moment
%
%------
%Input
%------
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
     %------------
     %Data Set 1
     %------------
        subplot(2,1,1)
        hold on
        plot(data1(:,1),data1(:,2),'k--')
        plot(data1(:,1),data1(:,3),'r')
        xlabel('Time (s)','fontweight','bold')
        ylabel('Pitch Moment (Nm)','fontweight','bold')
        legend('Measured','Simulated')
        title('Average Speed 1.2 m/s','Fontweight','bold','Fontsize',12)
        xlim([200 205])
     %------------
     %Data Set 2
     %------------
        subplot(2,1,2)
        hold on
        plot(data2(:,1),data2(:,2),'k--')
        plot(data2(:,1),data2(:,3),'r')
        xlabel('Time (s)','fontweight','bold')
        ylabel('Pitch Moment (Nm)','fontweight','bold')
        legend('Measured','Simulated')
        title('Average Speed 2.0 m/s','Fontweight','bold','Fontsize',12)
        xlim([200 205])
end