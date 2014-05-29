function statistics_table=calculate_statistics(frequency,measured,predicted,compensated)

%=========================================================================
%function CALCULATE_STATISTICS
%      1) Calculates the R^2 value
%      2) Calculates the RMS before and after compensation
%      3) Calculates the RMS reduction percentage
%
%-------
%Inputs
%-------
%   frequency      (Nfrequencies x 1) Vector of the range of cutoff
%                                     frequencies
%   uncompensated  (Nfrequencies x 1) Vector of the uncompensated moment
%   compensated    (Nfrequencies x 1) Vector of the compensated moment
%--------
%Outputs
%--------
%   Automatically generates a table of statistics of R^2, RMS before and
%   after compensation, and the percent difference in RMS
%=========================================================================

%----------------
%R^2
%----------------
    Ssres=sum(((measured-predicted).^2));
    Sstotal=sum(((measured-mean(measured)).^2));
    rsq=1-Ssres/Sstotal;
%----------------
%RMS Reduction
%----------------
    compensated=sqrt(mean(compensated.^2));
    uncompensated=sqrt(mean(measured.^2));
    difference=((uncompensated-compensated)/uncompensated)*100; 
%----------------
%Create Table
%----------------
    statistics_table=[frequency rsq uncompensated compensated difference];
end
