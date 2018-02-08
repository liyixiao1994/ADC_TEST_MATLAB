close all;
clear all;
step=1;
start=1;
syms n N count data DATA1 DATA2;
       N=step*8*2^10;               
       n=8*2^10;
  data=zeros(n,1);
  data1=zeros(N,12);
fileName='/home/yixiao/DATAs/Slee_fy_test/cal/3/final_noise_extract.csv';
if isempty(fileName)
    return;
end
fid = fopen(fileName,'r');
if (fid == -1) 
    fprintf('File not found.');
    return;
end
fgetl(fid);
mdac1 = textscan(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');
fclose(fid);
DATA1= 3696*mdac1{1,16}+ 2016*mdac1{1,15}+1120*mdac1{1,14}+ 616*mdac1{1,13}+ 336*mdac1{1,12}... %1.12 1.13 30~32
         + 182*mdac1{1,11}+ 98*mdac1{1,10}+ 56*mdac1{1,9}...
         + 28*mdac1{1,8}+ 19*mdac1{1,7}+ 11*mdac1{1,6}+ 6*mdac1{1,5}+3*mdac1{1,4}+2*mdac1{1,3}...
         +1*mdac1{1,2}+0.5*mdac1{1,1};
fileName='/home/yixiao/DATAs/Slee_fy_test/cal/3/test_src.csv';
if isempty(fileName)
    return;
end
fid = fopen(fileName,'r');
if (fid == -1) 
    fprintf('File not found.');
    return;
end
fgetl(fid);
 mdac2 = textscan(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');
fclose(fid);
DATA2 = 3696*mdac2{1,15}+ 2016*mdac2{1,14}+1120*mdac2{1,13}+ 616*mdac2{1,12}+ 336*mdac2{1,11}... %1.12 1.13 30~32
         + 182*mdac2{1,10}+ 98*mdac2{1,9}+ 56*mdac2{1,8}...
         + 28*mdac2{1,7}+ 19*mdac2{1,6}+ 11*mdac2{1,5}+ 6*mdac2{1,4}+3*mdac2{1,3}+2*mdac2{1,2}...
         +1*mdac2{1,1};
for i=1:8192
    data(i,1) = DATA1(i,1)+DATA2(i,1);
end
code=data'-sum(data)/n;
sum(code)/n;
% ENOB=FFT(code);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbit = 12.998;
numdel =0;
sign_code= 0;    % 0 represent ????????, 1 represent ????????????
FREQ_SAMP = 5e6;
COHER_SAMP = 0;     % 0 represent hanning window, 1 represent Blackman Harris 4-Term window, 2 represent not using window
if sign_code== 0
    DC_OFFSET = 2^(numbit-1);
else if sign_code== 1
        DC_OFFSET = 0;
    end
end
SINE_AMP  = 2^(numbit-numdel-1)-0.5;
% if (COHER_SAMP == 0)|(COHER_SAMP == 1)
%     MIN_HAR_POW_RATIO_DB=20;
% else
%     MIN_HAR_POW_RATIO_DB=14;
% end

ckc = 2^13;
inc = 491;  %491 3079 6143 14347 20483
% samples =64*2^10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% code=data'- DC_OFFSET;
dPnts=length(code);
fprintf('* Total sampling points : %d\n',dPnts);

code=floor(code/(2^numdel));

figure('color','w');
axes('FontSize',12.5);
box on;
plot(code,'x','MarkerSize',3);
%plot(code(1:min(dPnts,8000)),'x','MarkerSize',3);
title('TIME DOMAIN', 'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
xlabel('SAMPLES', 'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
ylabel('DIGITAL OUTPUT CODE', 'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');

fclk=FREQ_SAMP;

section
% twotone
dynproc_zhuk_2w
% close all;