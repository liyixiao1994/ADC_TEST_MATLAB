% using FFT to analyze adc's static noise performance 
% Author: Ding Junbiao
% asic lab, fudan Univ.
% Version 20050126
tic;
clear;
close all;

% ---------------------------------------------------
%  Parameters table
% ---------------------------------------------------
numbit = 12;
numdel = 0;
sign_code= 0;    % 0 represent ‘≠¬Î, 1 represent ≤π¬Î
FREQ_SAMP = 200e6;
COHER_SAMP = 0;     % 0 represent hanning window, 1 represent Blackman Harris 4-Term window, 2 represent not using window
if sign_code== 0
    DC_OFFSET = 2^(numbit-1);
else if sign_code== 1
        DC_OFFSET = 0;
    end
end
SINE_AMP  = 2^(numbit-numdel-1)-0.5;
numLSB=2^(numbit-numdel);
% if (COHER_SAMP == 0)|(COHER_SAMP == 1)
%     MIN_HAR_POW_RATIO_DB=20;
% else
%     MIN_HAR_POW_RATIO_DB=14;
% end

ckc = 2^13;
inc = 2203;
samples = 2^6*2^10;

% ---------------------------------------------------
%  read data from data file to matrix named "rawdata"
% ---------------------------------------------------

data=zeros(samples,1);
% fileName='D:\Œƒµµ\–æ∆¨≤‚ ‘\–æ∆¨≤‚ ‘-200M RA ADC\≤‚ ‘ ˝æ›\0828\03\2M\002.csv';
fileName='H:\noise.csv';
if isempty(fileName)
    return;
end
fid = fopen(fileName,'r');
%display(fid);
if (fid == -1) 
    fprintf('File not found.');
    return;
end
fgetl(fid);
display(ans);
 mdac = textscan(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');
%  mdac = textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f %f %f');
fclose(fid);


for i=1:samples
    data(i) = 2^11*mdac{1,1}(i)+ 1.00*2^10*mdac{1,2}(i)+ 2^9*mdac{1,3}(i)+ 2^8*mdac{1,4}(i)...
         + 1*0.5*(1+(-1)^i)*(240*mdac{1,5}(i)+ 128*mdac{1,6}(i)+ 64*mdac{1,7}(i)... 
         + 36*mdac{1,8}(i)+ 20*mdac{1,9}(i)+ 10*mdac{1,10}(i)...
         + 6*mdac{1,11}(i)+ 2^2*mdac{1,12}(i)+ 2^1*mdac{1,13}(i)+ 2^0*mdac{1,14}(i))...
         + 1*0.5*(1+(-1)^(i+1))*(240*mdac{1,5}(i)+ 128*mdac{1,6}(i)+ 64*mdac{1,7}(i)... 
         + 36*mdac{1,8}(i)+ 20*mdac{1,9}(i)+ 10*mdac{1,10}(i)...
         + 6*mdac{1,11}(i)+ 2^2*mdac{1,12}(i)+ 2^1*mdac{1,13}(i)+ 2^0*mdac{1,14}(i));
end
code=data';



dPnts=length(code);
fprintf('* Total sampling points : %d\n',dPnts);

code=floor(code/(2^numdel))+1;
noise=std(code);
fprintf('Noise: %d LSB\n',noise);

count=zeros(1,numLSB);
for i=1:dPnts
    count(code(i))=count(code(i))+1;
end
% for i=1:numLSB
%     temp=find(code==i);
%     count(i)=length(temp);
%     clear temp;
% end
clear code;

percent=(count/dPnts)*100; 
h=zeros(3,numLSB);
d_min=1;
min=0;
d_max=0;
for i=1:numLSB;
    h(1,i)=i-1;
    h(2,i)=count(i);
    if(h(2,i)&&d_min)
        min=h(1,i);
        d_min=0;
    end
    if((h(2,i)==0)&&(d_min==0)&&(d_max==0))
        max=h(1,i);
        d_max=1;
    end
    h(3,i)=percent(i);
end

bar(h(1,(min-1):(max+1)),h(2,(min-1):(max+1)));