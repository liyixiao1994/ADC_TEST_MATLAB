close all;
clear all;
step=1;
start=1;
syms n N count data DATA;
       N=step*8*2^10;               %%%???????????????????????????
       n=8*2^10;
  data=zeros(n,1);
  data1=zeros(N,12);
fileName='/home/yixiao/DATAs/Slee_fy_test/slee_fy_17_12_20/VC_Vcmin/VC0.45/0.44.csv';
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
data1 = 3696.52*mdac{1,16}+ 2015.78*mdac{1,15}+1119.25*mdac{1,14}+ 616.03*mdac{1,13}+ 336.19*mdac{1,12}... %1.12 1.13 30~32
         + 181.27*mdac{1,11}+ 96*mdac{1,10}+ 56.13*mdac{1,9}...
         + 27.34*mdac{1,8}+ 18.71*mdac{1,7}+ 10.83*mdac{1,6}+ 7.8*mdac{1,5}+3.9*mdac{1,4}+2.6*mdac{1,3}...
         +1.3*mdac{1,2}+0.65*mdac{1,1};
     for i=start:step:N
         data((i-start)/step+1,:)=data1(i,:);
     end
code=data'-sum(data)/n;
% ENOB=FFT(code);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbit = 16;
numdel =0;
sign_code= 0;    % 0 represent ????????, 1 represent ????????????
FREQ_SAMP = 125e6;
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

title('TIME DOMAIN', 'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
xlabel('SAMPLES', 'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
ylabel('DIGITAL OUTPUT CODE', 'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');

fclk=FREQ_SAMP;

section
% twotone
dynproc_zhuk_2w
% close all;