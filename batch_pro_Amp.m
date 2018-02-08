
fileFolder = fullfile('/home/yixiao/DATAs/slee_fy_17_12_7/Amp');
dirOut = dir(fullfile(fileFolder,'*.csv'));
fileName = {dirOut.name};

SNR = zeros(1,length(fileName));
SINAD = zeros(1,length(fileName));
ENOB = zeros(1,length(fileName));
SFDR = zeros(1,length(fileName));
amp = zeros(1,length(fileName));
amp_db = zeros(1,length(fileName));

for i=1:length(fileName)
    S1= char(fileName{1,i});
    for j = 1:length(S1)-4
        if (S1(j) ~= '.')
            amp(1,i) = amp(1,i)*10 + str2num(S1(j));
        end
    end
end

amp = sort(amp);
for i=1:length(amp)
    [SNR(1,i),SINAD(1,i),ENOB(1,i),SFDR(1,i)] = SAR_TEST_Func(sprintf('/home/yixiao/DATAs/slee_fy_17_12_7/Amp/%d.csv',amp(1,i)));
end
    
amp_db = db((amp/4090));
figure(1);
subplot(2,2,1);
plot(amp_db,SNR);
grid on;
ylabel('SNR/dB');
xlabel('Amp/dB');
subplot(2,2,2);
plot(amp_db,SFDR);
grid on;
ylabel('SINAD/dB');
xlabel('Amp/dB');
subplot(2,2,3);
plot(amp_db,SFDR);
grid on;
ylabel('SFDR/dBc');
xlabel('Amp/dB');
figure(2);
subplot(1,1,1);
plot(amp_db,SNR,'k',amp_db,SINAD,'r',amp_db,SFDR,'g');
legend('SNR','SINAD','SFDR');
xlabel('AMp/dB');
grid on;
