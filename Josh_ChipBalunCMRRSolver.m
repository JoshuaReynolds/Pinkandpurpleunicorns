MeasuredData = read(rfdata.data,'JTX-2.s3p'); % Reading in S-parameter data from PNA file
% Measuredf = MeasuredData.freq; % Extracting frequency data from measurement file
[MeasuredS,freq] = extract(MeasuredData,'S_PARAMETERS'); % Extracting S parameter data from measurement file

for n = 1:length(freq)
S21(n) = MeasuredS(3,1,n);
S31(n) = MeasuredS(2,1,n);
CMRRdB(n) = 20*log10((S21(n)+S31(n))/(S21(n)-S31(n)));

amp_diff(n) = abs(S21(n))-abs(S31(n));
phase_diff(n) = phase(S21(n))-phase(S31(n));
end

figure(1)
plot(freq,20*log10(abs(S21)+abs(S31)))
figure(2)
plot(freq,amp_diff)