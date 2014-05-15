function statistics_table=calculate_statistics(frequency,uncompensated,compensated)

%=========================================================================
%function DISPLAY_STATISTICS
%      1) Calculates the R^2 value
%      2) Calculates the RMS before and after compensation
%      3) Calculates the RMS reduction percentage
%
%-------
%Inputs
%-------
%   uncompensated  (Nsamples x 1)    Vector of the uncompensated variable
%   compensated    (Nsamples x 1)    Vector of the compensated variable
%--------
%Outputs
%--------
%   Automatically generates a table of statistics of R^2, RMS before and
%   after compensation, and the percent difference in RMS
%=========================================================================

%----------------
%R^2
%----------------
    Ssresid=sum(compensated.^2);
    Sstotal=(length(uncompensated)-1)*var(uncompensated);
    rsq=1-Ssresid/Sstotal;
%----------------
%RMS Reduction
%----------------
    compensated=sqrt(mean(compensated.^2));
    uncompensated=sqrt(mean(uncompensated.^2));
    difference=((uncompensated-compensated)/uncompensated)*100; 
%----------------
%Create Table
%----------------
    statistics_table=[frequency rsq uncompensated compensated difference];
end
