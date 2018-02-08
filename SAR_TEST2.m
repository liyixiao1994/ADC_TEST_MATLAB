% clc;
close all;
clear all;
syms n count data;
       n=8*2^10;
  data=zeros(n,1);
% fileName='D:\Œƒµµ\–æ∆¨≤‚ ‘\–æ∆¨≤‚ ‘-200M RA ADC\≤‚ ‘ ˝æ›\0828\03\2M\002.csv';
fileName='C:\Documents and Settings\fudan\My Documents\nzk\CF1\1_2\12.csv';
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
 mdac = textscan(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');
%  mdac = textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f %f %f');
fclose(fid);
data = 480*mdac{1,11}+256*mdac{1,10}+ 128*mdac{1,9}+ 64*mdac{1,8}... %1.12 1.13 30~32
         + 32*mdac{1,7}+ 32*mdac{1,6}+ 16*mdac{1,5}...
         + 8*mdac{1,4}+ 4*mdac{1,3}+ 2*mdac{1,2}+ 1*mdac{1,1};
code=data'-sum(data)/n;
% ENOB=FFT(code);
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numbit =10;
numdel =0;
sign_code= 0;    % 0 represent ‘≠¬Î, 1 represent ≤π¬Î
FREQ_SAMP = 20e6;
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