%==========================================================================
% CarenRead
% reads data from a standard CAREN text file
%==========================================================================
function [timestamps, framenumbers, channelnames, data] = CarenRead(filename);

      % open file and read channel names from line 1
      % fprintf('Reading %s...\n', filename);
      fid = fopen(filename);
      if (fid == -1)
          error('CarenRead: cannot open file %s', filename);
      end
      line = fgetl(fid);
      channelnames = textscan(line,'%s');
      channelnames = channelnames{:};
      fclose(fid);
      nchannels = size(channelnames,1);

      % read data matrix
      data = dlmread(filename, '', 1, 0);
      if (size(data,2) ~= nchannels)
          error('CarenRead: header and data in file were not consistent');
      end

      % extract timestamps and framenumbers
      timestamps = data(:,1);
      framenumbers = round(data(:,2));

      % remove channels 1 and 2 from data matrix, these are the time stamps and frame numbers
      data = data(:,3:end);
      channelnames = channelnames(3:end,:);

end
