% using FFT to analyze adc's dynamic performance 
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
sign_code= 0;    % 0 represent Ô­Âë, 1 represent ²¹Âë
FREQ_SAMP = 200e6;
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

ckc = 2^12;
inc = 493;
samples = 2^14;

% ---------------------------------------------------
%  read data from data file to matrix named "rawdata"
% ---------------------------------------------------
fileName='D:\ÎÄµµ\Ð¾Æ¬²âÊÔ\Ð¾Æ¬²âÊÔ-200M RA ADC\cyz\041.csv';
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
% mdac = textscan(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f','HeaderLines',1);
mdac = textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f %f %f');
fclose(fid);
for i=1:samples
    data(i) = 2^11*mdac{1,1}(i)+ 2^10*mdac{1,2}(i)+ 2^9*mdac{1,3}(i)...
         + 1.122*0.5*(1+(-1)^i)*(2^9*mdac{1,4}(i)+ 2^8*mdac{1,5}(i)+ 2^7*mdac{1,6}(i)... 
         + 2^6*mdac{1,7}(i)+ 2^5*mdac{1,8}(i)+ 2^4*mdac{1,9}(i)...
         + 2^3*mdac{1,10}(i)+ 2^2*mdac{1,11}(i)+ 2^1*mdac{1,12}(i)+ 2^0*mdac{1,13}(i))...
         + 1.11*0.5*(1+(-1)^(i+1))*(2^9*mdac{1,4}(i)+ 2^8*mdac{1,5}(i)+ 2^7*mdac{1,6}(i)... 
         + 2^6*mdac{1,7}(i)+ 2^5*mdac{1,8}(i)+ 2^4*mdac{1,9}(i)...
         + 2^3*mdac{1,10}(i)+ 2^2*mdac{1,11}(i)+ 2^1*mdac{1,12}(i)+ 2^0*mdac{1,13}(i));
end


%     data = 2^11*mdac{1,1}+ 2^10*mdac{1,2}+ 2^9*mdac{1,3}...
%          + 1.1*(2^9*mdac{1,4}+ 2^8*mdac{1,5}+ 2^7*mdac{1,6}... %1.12 1.13 30~32
%          + 2^6*mdac{1,7}+ 2^5*mdac{1,8}+ 2^4*mdac{1,9}...
%          + 2^3*mdac{1,10}+ 2^2*mdac{1,11}+ 2^1*mdac{1,12}+ 2^0*mdac{1,13});
code=data- DC_OFFSET;
dPnts=length(code);
fprintf('* Total sampling points : %d\n',dPnts);

code=floor(code/(2^numdel));

% for i=1:(2^16)
%     if code(i)==8191
%         code(i)=0;
%     end
% end

figure('color','w');
axes('FontSize',12.5);
box on;
plot(code,'x','MarkerSize',3);
%plot(code(1:min(dPnts,8000)),'x','MarkerSize',3);
title('TIME DOMAIN',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
xlabel('SAMPLES',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
ylabel('DIGITAL OUTPUT CODE',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');

% acquire sample frequency from file
% tclk = mean(data(4,:));
% switch lower(data(5,10))
%     case {'p'}
%         tclk=tclk*1e-12;
%     case {'n'}
%         tclk=tclk*1e-9;
%     case {'u'}
%         tclk=tclk*1e-6;
%     case {'m'}
%         tclk=tclk*1e-3;
% end


fclk=FREQ_SAMP;
% fprintf('* Sampling frequency : %f MHz\n',fclk/1e6);
% if abs((1/tclk-FREQ_SAMP)/FREQ_SAMP)>1e-3
%     fprintf('\n  Warning\n')
%     fprintf('  Sampling frequency in data file : %f MHz\n',1/tclk/1e6);
%     fprintf('  Sampling frequency in data file departs from set value too much\n\n');
% end
clear fileName fid data tclk;

% code_max=max(code);
% code_min=min(code);
% AIN = 20*log10((code_max-code_min)/(2^numbit-1));
% fprintf('code_max = %d, code_min = %d\n',code_max,code_min);
% fprintf('AIN = %.2fdBFS\n',AIN);

% calc fft process
section
% twotone
dynproc_zhuk_2w
% close all;
toc;
