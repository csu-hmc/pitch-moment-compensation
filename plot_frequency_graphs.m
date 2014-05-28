function plot_frequency_graphs(data1,data2,desired)

%=========================================================================
%function PLOT_FREQUENCY_GRAPHS
%      Plots a graph comparing the RMS of the uncompensated and compensated
%      pitch moment as a function of the cutoff frequency of the lowpass
%      filter. A dashed line will appear between the uncompensated and
%      compensated moments at location of the desired cutoff frequency.
%
%------
%Input
%------
%    data1     (Nsamples x 3)  Array of the cutoff frequencies, RMS before 
%                              compensation,and RMS after compensation for 
%                              the first data set
%    data2     (Nsamples x 3)  Array of the cutoff frequencies, RMS before 
%                              compensation,and RMS after compensation for
%                              the second data set
%    desired   double          The cutoff frequency of the most interest
%-------
%Output
%-------
%    Automatically generates the plot
%=========================================================================
     figure(2)
     %--------------
     %Data Set 1
     %--------------
        subplot(1,2,1)
        hold on
        plot(data1(:,1),data1(:,2),'b','Linewidth',2)
        plot(data1(:,1),data1(:,3),'r','Linewidth',2)
        xlabel('Cutoff Frequency (Hz)','fontweight','bold')
        ylabel('RMS Pitch Moment (Nm)','fontweight','bold')
        title('Average Speed 1.2 m/s','Fontweight','bold','Fontsize',12)
        legend('Uncompensated','Compensated')
            %Dashed Line at the Desired Cutoff Frequency
                if find(data1(:,1)==desired)~=0
                    location=find(data1(:,1)==desired);
                    x1=[data1(location,1),data1(location,1)];
                    y1=[data1(location,2) data1(location,3)];
                    plot(x1,y1,'k--')
                    plot(x1(1), y1(1),'.k')
                    plot(x1(2), y1(2),'.k')
                end
     %--------------
     %Data Set 2
     %--------------
        subplot(1,2,2)
        hold on
        plot(data2(:,1),data2(:,2),'b','Linewidth',2)
        plot(data2(:,1),data2(:,3),'r','Linewidth',2)
        xlabel('Cutoff Frequency (Hz)','fontweight','bold')
        ylabel('RMS Pitch Moment (Nm)','fontweight','bold')
        title('Average Speed 2.0 m/s','Fontweight','bold','Fontsize',12)
        legend('Uncompensated','Compensated')
            %Dashed Line at the Desired Cutoff Frequency
                if find(data2(:,1)==desired)~=0
                    location=find(data1(:,1)==desired);
                    x2=[data2(location,1),data2(location,1)];
                    y2=[data2(location,2) data2(location,3)];
                    plot(x2,y2,'k--')
                    plot(x2(1), y2(1),'.k')
                    plot(x2(2), y2(2),'.k')
                end
end
