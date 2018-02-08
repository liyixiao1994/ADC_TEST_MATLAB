fileFolder = fullfile('/home/yixiao/Desktop/Matlab/data/Syn_0.15n_0.75p_100m/');
dirOut = dir(fullfile(fileFolder,'*.csv'));
fileName = {dirOut.name};

SNR = zeros(1,11);
SINAD = zeros(1,11);
ENOB = zeros(1,11);
SFDR = zeros(1,11);
S = zeros(1,length(fileName));

for i=1:length(fileName)
    S1=regexp(fileName(1,i),'_','split');
    X = S1{1,1}(1,5);
    X1 = X{1,1};
    num = 0;
    d = 1;
    for j=1:length(X1)-4
        if(X1(j) ~= '.')
            num = num + str2num(X1(j)) / d;
            d= d*10;
        end
    S(1,i) = num; 
    end
   [SNR(1,i),SINAD(1,i),ENOB(1,i),SFDR(1,i)]=SAR_TEST_Func(sprintf('/home/yixiao/Desktop/Matlab/data/Syn_0.15n_0.75p_100m/%s',char(fileName(1,i))));
end
figure(1);
subplot(2,2,1);
plot(S,SNR);
grid on;
title('Vcm-SNR');
xlabel('Vcm/V');
ylabel('SNR/dB');
xlim([0.3 0.4]);
subplot(2,2,2);
plot(S,SFDR);
grid on;
title('Vcm-SINAD');
xlabel('Vcm/V');
ylabel('SINAD/dB');
xlim([0.3 0.4]);
subplot(2,2,3);
plot(S,ENOB);
grid on;
title('Vcm-ENOB');
xlabel('Vcm/V');
ylabel('ENOB/Bits');
xlim([0.3 0.4]);
subplot(2,2,4);
plot(S,SFDR);
grid on;
title('Vcm-SFDR');
xlabel('Vcm/V');
ylabel('SFDR/dBc');
xlim([0.3 0.4]);
figure(2);
subplot(1,1,1);
plot(S,SNR,'kdiamond',S,SINAD,'rv',S,ENOB,'b^',S,SFDR,'g+');
legend('SNR','SINAD','ENOB','SFDR');
xlabel('Vcm/V');
grid on;
