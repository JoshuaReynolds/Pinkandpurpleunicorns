%%%%%%%%%%%%%%%%%%%
% Joshua Reynolds %
% CMRR Solver     %
% 3-29-2017       %
%%%%%%%%%%%%%%%%%%%

% Instructions for use: Ensure this file is in the path you are currently
% using. Input the correct file name in the read command for MeasuredData.
% Example: 'JTX-2.s3p'
%
% WARNING: If your file name contains '.' anywhere, this solver will not be
% able to recognize the file type and will give you errors. Rename your
% file to exclude using '.' and the problem should be corrected.

MeasuredData = read(rfdata.data,''); % Reading in S-parameter data from PNA file
% Measuredf = MeasuredData.freq; % Extracting frequency data from measurement file
[MeasuredS,freq] = extract(MeasuredData,'S_PARAMETERS'); % Extracting S parameter data from measurement file

for n = 1:length(freq) %Loop for calculating S21 and S31
S21(n) = MeasuredS(3,1,n);
S31(n) = MeasuredS(2,1,n);

CMRRdB(n) = 20*log10((S21(n)+S31(n))/(S21(n)-S31(n)));
amp_diff(n) = abs(S21(n))-abs(S31(n));
phase_diff(n) = phase(S21(n))-phase(S31(n));
end

figure(1)
plot(freq,CMRRdB)
figure(2)
plot(freq,amp_diff)
figure(3)
plot(freq,phase_diff)