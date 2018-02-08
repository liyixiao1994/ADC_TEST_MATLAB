% clc;
close all;
clear all;
step=1;
start=1;
syms n N count data DATA;
       N=step*8*2^10;               
       n=8*2^10;
  data=zeros(n,1);
  data1=zeros(N,12);
fileName='/home/yixiao/DATAs/Slee_fy_test/data_for_report/clk50M_in2.38M_10.68dbm_vc0.42_vcmin0.45.csv';
if isempty(fileName)
    return;
end
fid = fopen(fileName,'r');
if (fid == -1) 
    fprintf('File not found.');
    return;
end
fgetl(fid);
display(ans);
 mdac = textscan(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');
fclose(fid);
data1 = 3696*mdac{1,16}+2016*mdac{1,15}+1120*mdac{1,14}+616*mdac{1,13}+336*mdac{1,12}+ 182*mdac{1,11}+ 98*mdac{1,10}+... %1.12 1.13 30~32
         56*mdac{1,9}+ 28*mdac{1,8}+19*mdac{1,7}+ 11*mdac{1,6}+ 6*mdac{1,5}...
         + 3*mdac{1,4}+ 2*mdac{1,3}+ 1*mdac{1,2}+ 0.5*mdac{1,1};
     for i=start:step:N
         data((i-start)/step+1,:)=data1(i,:);
     end
code=data'-sum(data)/n;
% ENOB=FFT(code);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbit = 12.998;
numdel =0;
sign_code= 1;    % 0 represent ????????, 1 represent ????????????
FREQ_SAMP = 50e6;
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