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
FREQ_SAMP = 40e6;
fclk=FREQ_SAMP;
% COHER_SAMP = 0;     % 0 represent hanning window, 1 represent Blackman Harris 4-Term window, 2 represent not using window
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
inc = 491;
sec = 4*2^10;
dPnts = 16*2^10;
samples = 2^10*2^10;

numb = (samples-dPnts)/sec;

% ---------------------------------------------------
%  read data from data file to matrix named "rawdata"
% ---------------------------------------------------
fileName='D:\ÎÄµµ\Ð¾Æ¬²âÊÔ\Ð¾Æ¬²âÊÔ-200M RA ADC\²âÊÔÊý¾Ý\0910\04\i001.csv';
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
mdac = textscan(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');
% mdac = textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f %f %f');
fclose(fid);
cap=zeros(samples,3);

code_temp=zeros(1,samples);
for k=1:samples
    i=k;
    data(i) = (2^2*mdac{1,1}(i)+ 1.00*2^1*mdac{1,2}(i)+ 1.00*2^0*mdac{1,3}(i));
    if data(i)==0
        cap(i,1)=0;
        cap(i,2)=0;
        cap(i,3)=0;
    end
    if data(i)==1
        cap(i,1)=1;
        cap(i,2)=0;
        cap(i,3)=0;
    end
    if data(i)==2
        cap(i,1)=1;
        cap(i,2)=1;
        cap(i,3)=0;
    end
    if data(i)==3
        cap(i,1)=1;
        cap(i,2)=1;
        cap(i,3)=1;
    end
    if data(i)==4
        cap(i,1)=1;
        cap(i,2)=1;
        cap(i,3)=2;
    end
    if data(i)==5
        cap(i,1)=1;
        cap(i,2)=2;
        cap(i,3)=2;
    end
    if data(i)==6
        cap(i,1)=2;
        cap(i,2)=2;
        cap(i,3)=2;
    end
end
for k=1:samples
    i=k;
    code_temp(i) = 2^9*(1.00*cap(i,1)+1.002*cap(i,2)+0.995*cap(i,3))...
         + (1.0241*0.5*(1+(-1)^i)*(1*2^9*mdac{1,4}(i)+ 1.004*2^8*mdac{1,5}(i)+ 1.002*2^7*mdac{1,6}(i)...  %1.0706
         + 1.00*2^6*mdac{1,7}(i)+ 2^5*mdac{1,8}(i)+ 2^4*mdac{1,9}(i)...
         + 2^3*mdac{1,10}(i)+ 2^2*mdac{1,11}(i)+ 2^1*mdac{1,12}(i)+ 2^0*mdac{1,13}(i))...
         + 1.0309*0.5*(1+(-1)^(i+1))*(1*2^9*mdac{1,4}(i)+ 1.004*2^8*mdac{1,5}(i)+ 1.002*2^7*mdac{1,6}(i)...  %1.0594
         + 1.00*2^6*mdac{1,7}(i)+ 2^5*mdac{1,8}(i)+ 2^4*mdac{1,9}(i)...
         + 2^3*mdac{1,10}(i)+ 2^2*mdac{1,11}(i)+ 2^1*mdac{1,12}(i)+ 2^0*mdac{1,13}(i)))-DC_OFFSET;
%     data(i) = 2^9*(1*cap(i,1)+1.002*cap(i,2)+0.995*cap(i,3))...
%          + (0.9846*0.5*(1+(-1)^i)*(1*2^9*mdac{1,4}(i)+ 1.004*2^8*mdac{1,5}(i)+ 1.002*2^7*mdac{1,6}(i)...  %1.0706
%          + 1.00*2^6*mdac{1,7}(i)+ 2^5*mdac{1,8}(i)+ 2^4*mdac{1,9}(i)...
%          + 2^3*mdac{1,10}(i)+ 2^2*mdac{1,11}(i)+ 2^1*mdac{1,12}(i)+ 2^0*mdac{1,13}(i))...
%          + 0.9785*0.5*(1+(-1)^(i+1))*(1*2^9*mdac{1,4}(i)+ 1.004*2^8*mdac{1,5}(i)+ 1.002*2^7*mdac{1,6}(i)...  %1.0594
%          + 1.00*2^6*mdac{1,7}(i)+ 2^5*mdac{1,8}(i)+ 2^4*mdac{1,9}(i)...
%          + 2^3*mdac{1,10}(i)+ 2^2*mdac{1,11}(i)+ 2^1*mdac{1,12}(i)+ 2^0*mdac{1,13}(i)));


end
% ---------------------------------------------------
%  To acquire sampling frequency and sampling points
% ---------------------------------------------------


code_temp=floor(code_temp/(2^numdel));

for maxid = 1:numb
    code=code_temp((maxid*sec):(maxid*sec+dPnts-1));
    
% dPnts=length(code);
% fprintf('* Total sampling points : %d\n',dPnts);

% code=floor(code/(2^numdel));

% for i=1:(2^16)
%     if code(i)==8191
%         code(i)=0;
%     end
% end

% figure('color','w');
% axes('FontSize',12.5);
% box on;
% plot(code,'x','MarkerSize',3);
% %plot(code(1:min(dPnts,8000)),'x','MarkerSize',3);
% title('TIME DOMAIN',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% xlabel('SAMPLES',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% ylabel('DIGITAL OUTPUT CODE',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');

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



% fprintf('* Sampling frequency : %f MHz\n',fclk/1e6);
% if abs((1/tclk-FREQ_SAMP)/FREQ_SAMP)>1e-3
%     fprintf('\n  Warning\n')
%     fprintf('  Sampling frequency in data file : %f MHz\n',1/tclk/1e6);
%     fprintf('  Sampling frequency in data file departs from set value too much\n\n');
% end
% clear fileName fid data tclk;

% code_max=max(code);
% code_min=min(code);
% AIN = 20*log10((code_max-code_min)/(2^numbit-1));
% fprintf('code_max = %d, code_min = %d\n',code_max,code_min);
% fprintf('AIN = %.2fdBFS\n',AIN);

% calc fft process
% section
% twotone
dynproc_zhuk_2w_max
% close all;
Fund_m(maxid)          =  max(Fund_1       , Fund_2        );
SNR_m(maxid)           =  max(SNR_1        , SNR_2         );
SNRFS_m(maxid)         =  max(SNRFS_1      , SNRFS_2       );
SINAD_m(maxid)         =  max(SINAD_1      , SINAD_2       );
ENOB_m(maxid)          =  max(ENOB_1       , ENOB_2        );
SFDR_m(maxid)          =  max(SFDR_1       , SFDR_2        );
THD_m(maxid)           =  min(THD_1        , THD_2         );
NoiseFloor_m(maxid)    =  min(NoiseFloor_1 , NoiseFloor_2  );
H_2nd_m(maxid)         =  min(H_2nd_1      , H_2nd_2       );
H_3rd_m(maxid)         =  min(H_3rd_1      , H_3rd_2       );
H_4th_m(maxid)         =  min(H_4th_1      , H_4th_2       );
H_5th_m(maxid)         =  min(H_5th_1      , H_5th_2       );
H_6th_m(maxid)         =  min(H_6th_1      , H_6th_2       );
H_7th_m(maxid)         =  min(H_7th_1      , H_7th_2       );
H_8th_m(maxid)         =  min(H_8th_1      , H_8th_2       );
H_9th_m(maxid)         =  min(H_9th_1      , H_9th_2       );
H_10th_m(maxid)        =  min(H_10th_1     , H_10th_2      );
H23_m(maxid)           =  min(H23_1        , H23_2         );
H456_m(maxid)          =  min(H456_1       , H456_2        );
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [Fund_max,Fund_max_point]=max(Fund_m);
% [SNR_max,SNR_max_point]=max(SNR_m);
% [SNRFS_max,SNRFS_max_point]=max(SNRFS_m);
% [SINAD_max,SINAD_max_point]=max(SINAD_m);
% [ENOB_max,ENOB_max_point]=max(ENOB_m);
% [SFDR_max,SFDR_max_point]=max(SFDR_m);
% [THD_max,THD_max_point]=max(THD_m);
% [NoiseFloor_max,NoiseFloor_max_point]=max(NoiseFloor_m);
% [H_2nd_max,H_2nd_max_point]=max(H_2nd_m);
% [H_3rd_max,H_3rd_max_point]=max(H_3rd_m);
% [H_4th_max,H_4th_max_point]=max(H_4th_m);
% [H_5th_max,H_5th_max_point]=max(H_5th_m);
% [H_6th_max,H_6th_max_point]=max(H_6th_m);
% [H_7th_max,H_7th_max_point]=max(H_7th_m);
% [H_8th_max,H_8th_max_point]=max(H_8th_m);
% [H_9th_max,H_9th_max_point]=max(H_9th_m);
% [H_10th_max,H_10th_max_point]=max(H_10th_m);
% [H23_max,H23_max_point]=max(H23_m);
% [H456_max,H456_max_point]=max(H456_m);
% [Fund_min,Fund_min_point]=min(Fund_m);
% [SNR_min,SNR_min_point]=min(SNR_m);
% [SNRFS_min,SNRFS_min_point]=min(SNRFS_m);
% [SINAD_min,SINAD_min_point]=min(SINAD_m);
% [ENOB_min,ENOB_min_point]=min(ENOB_m);
% [SFDR_min,SFDR_min_point]=min(SFDR_m);
% [THD_min,THD_min_point]=min(THD_m);
% [NoiseFloor_min,NoiseFloor_min_point]=min(NoiseFloor_m);
% [H_2nd_min,H_2nd_min_point]=min(H_2nd_m);
% [H_3rd_min,H_3rd_min_point]=min(H_3rd_m);
% [H_4th_min,H_4th_min_point]=min(H_4th_m);
% [H_5th_min,H_5th_min_point]=min(H_5th_m);
% [H_6th_min,H_6th_min_point]=min(H_6th_m);
% [H_7th_min,H_7th_min_point]=min(H_7th_m);
% [H_8th_min,H_8th_min_point]=min(H_8th_m);
% [H_9th_min,H_9th_min_point]=min(H_9th_m);
% [H_10th_min,H_10th_min_point]=min(H_10th_m);
% [H23_min,H23_min_point]=min(H23_m);
% [H456_min,H456_min_point]=min(H456_m);
% fprintf('Maximum Fund  : Fund(%6d)  = %5.3f dBFS\n',Fund_max_point,Fund_max);
% fprintf('Maximum SNR   : SNR(%6d)   = %5.2f dBc\n',SNR_max_point,SNR_max);
% % fprintf('Maximum SNRFS : SNRFS(%6d) = %5.2f dBFS\n',SNRFS_max_point,SNRFS_max);
% fprintf('Maximum SINAD : SINAD(%6d) = %5.2f dBc\n',SINAD_max_point,SINAD_max);
% fprintf('Maximum ENOB  : ENOB(%6d)  = %5.2f Bits\n',ENOB_max_point,ENOB_max);
% fprintf('Maximum SFDR  : SFDR(%6d)  = %5.2f dBc\n',SFDR_max_point,SFDR_max);
% fprintf('Minimum THD   : THD(%6d)   = %5.2f dBc\n',THD_min_point-1,THD_min);
% % fprintf('Minimum NoiseFloor : NoiseFloor(%6d) = %5.2f dBFS\n',NoiseFloor_min_point-1,NoiseFloor_min);
% fprintf('Minimum H_2nd : H_2nd(%6d) = %5.2f dBc\n',H_2nd_min_point-1,H_2nd_min);
% fprintf('Minimum H_3rd : H_3rd(%6d) = %5.2f dBc\n',H_3rd_min_point-1,H_3rd_min);
% fprintf('Minimum H_4th : H_4th(%6d) = %5.2f dBc\n',H_4th_min_point-1,H_4th_min);
% fprintf('Minimum H_5th : H_5th(%6d) = %5.2f dBc\n',H_5th_min_point-1,H_5th_min);
% fprintf('Minimum H_6th : H_6th(%6d) = %5.2f dBc\n',H_6th_min_point-1,H_6th_min);
% fprintf('Minimum H_7th : H_7th(%6d) = %5.2f dBc\n',H_7th_min_point-1,H_7th_min);
% fprintf('Minimum H_8th : H_8th(%6d) = %5.2f dBc\n',H_8th_min_point-1,H_8th_min);
% fprintf('Minimum H_9th : H_9th(%6d) = %5.2f dBc\n',H_9th_min_point-1,H_9th_min);
% fprintf('Minimum H_10th: H_10th(%6d)= %5.2f dBc\n',H_10th_min_point-1,H_10th_min);
% fprintf('Minimum H23   : H23(%6d)   = %5.2f dBc\n',H23_min_point-1,H23_min);
% fprintf('Minimum H456  : H456(%6d)  = %5.2f dBc\n',H456_min_point-1,H456_min);

fprintf('Fund   = %8.3f / %8.3f / %8.3f dBFS\n',   max(Fund_m  ), min(Fund_m  ), mean(Fund_m  ));
fprintf('SNR    = %8.2f / %8.2f / %8.2f dBc\n' ,   max(SNR_m   ), min(SNR_m   ), mean(SNR_m   ));
% fprintf('SNRFS  = %8.2f / %8.2f / %8.2f dBFS\n',   max(SNRFS_m ), min(SNRFS_m ), mean(SNRFS_m ));
fprintf('SINAD  = %8.2f / %8.2f / %8.2f dBc\n' ,   max(SINAD_m ), min(SINAD_m ), mean(SINAD_m ));
fprintf('ENOB   = %8.2f / %8.2f / %8.2f Bits\n',   max(ENOB_m  ), min(ENOB_m  ), mean(ENOB_m  ));
fprintf('SFDR   = %8.2f / %8.2f / %8.2f dBc\n' ,   max(SFDR_m  ), min(SFDR_m  ), mean(SFDR_m  ));
fprintf('THD    = %8.2f / %8.2f / %8.2f dBc\n' ,   min(THD_m   ), max(THD_m   ), mean(THD_m   ));
fprintf('H_2nd  = %8.2f / %8.2f / %8.2f dBc\n' ,   min(H_2nd_m ), max(H_2nd_m ), mean(H_2nd_m ));
fprintf('H_3rd  = %8.2f / %8.2f / %8.2f dBc\n' ,   min(H_3rd_m ), max(H_3rd_m ), mean(H_3rd_m ));
fprintf('H_4th  = %8.2f / %8.2f / %8.2f dBc\n' ,   min(H_4th_m ), max(H_4th_m ), mean(H_4th_m ));
fprintf('H_5th  = %8.2f / %8.2f / %8.2f dBc\n' ,   min(H_5th_m ), max(H_5th_m ), mean(H_5th_m ));
fprintf('H_6th  = %8.2f / %8.2f / %8.2f dBc\n' ,   min(H_6th_m ), max(H_6th_m ), mean(H_6th_m ));
% fprintf('H_7th  = %8.2f / %8.2f / %8.2f dBc\n' ,   min(H_7th_m ), max(H_7th_m ), mean(H_7th_m ));
% fprintf('H_8th  = %8.2f / %8.2f / %8.2f dBc\n' ,   min(H_8th_m ), max(H_8th_m ), mean(H_8th_m ));
% fprintf('H_9th  = %8.2f / %8.2f / %8.2f dBc\n' ,   min(H_9th_m ), max(H_9th_m ), mean(H_9th_m ));
% fprintf('H_10th = %8.2f / %8.2f / %8.2f dBc\n' ,   min(H_10th_m), max(H_10th_m), mean(H_10th_m));
fprintf('H23    = %8.2f / %8.2f / %8.2f dBc\n' ,   min(H23_m   ), max(H23_m   ), mean(H23_m   ));
fprintf('H456   = %8.2f / %8.2f / %8.2f dBc\n' ,   min(H456_m  ), max(H456_m  ), mean(H456_m  ));
% fprintf('NoiseFloor  = %8.2f / %8.2f / %8.2f dBFS\n',min(NoiseFloor_m), max(NoiseFloor_m), mean(NoiseFloor_m));

% figure('color','w');
% axes('FontSize',12.5);
% box on;
% plot(Fund_m,'b-','MarkerSize',3);
% %plot(code(1:min(dPnts,8000)),'x','MarkerSize',3);
% title('Fund',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% xlabel('maxid',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% ylabel('Fund','color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% grid on;
% 
figure('color','w');
axes('FontSize',12.5);
box on;
plot(SNR_m,'b-','MarkerSize',3);
%plot(code(1:min(dPnts,8000)),'x','MarkerSize',3);
title('SNR',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
xlabel('maxid',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
ylabel('SNR','color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
grid on;
% 
% figure('color','w');
% axes('FontSize',12.5);
% box on;
% plot(SINAD_m,'b-','MarkerSize',3);
% %plot(code(1:min(dPnts,8000)),'x','MarkerSize',3);
% title('SINAD',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% xlabel('maxid',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% ylabel('SINAD','color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% grid on;
% 
% figure('color','w');
% axes('FontSize',12.5);
% box on;
% plot(ENOB_m,'b-','MarkerSize',3);
% %plot(code(1:min(dPnts,8000)),'x','MarkerSize',3);
% title('ENOB',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% xlabel('maxid',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% ylabel('ENOB','color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% grid on;
% 
figure('color','w');
axes('FontSize',12.5);
box on;
plot(SFDR_m,'b-','MarkerSize',3);
%plot(code(1:min(dPnts,8000)),'x','MarkerSize',3);
title('SFDR',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
xlabel('maxid',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
ylabel('SFDR','color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
grid on;

toc;
