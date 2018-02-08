% Author: Ding Junbiao
% asic lab, fudan Univ.
% Version 20050126
% revised by zhukai, 2007/08/28
% revised by zhukai, 2010/04/09
% revised by zhukai, 2010/06/17
% revised by zhukai, 2010/07/20, ENOB
% revised by zhukai, 2011/09/14, set all span_dc=6 and span_base=25(hanning);
% ---------------------------------------------------
%  Set parameters
% ---------------------------------------------------
% --- to calc base spectrum cluster ---
if (COHER_SAMP==0)
    span_base=25;     % 15  for Blackman Harris 4-Term window and 24 for hanning window
    span_har=6;       %  3  for Blackman Harris 4-Term window and  6 for hanning window
    span_dc=6;
    else if (COHER_SAMP==1)
        span_base=15;
        span_har=3;
        span_dc=6;
        else
            span_base=1;
            span_har=1;
            span_dc=6;
        end
end
span_spur=span_har;

% ---------------------------------------------------
%  Calculate Fund
% ---------------------------------------------------
ak=1/dPnts*fft(code);
fmax=round((dPnts-1)/2);
if mod(dPnts-1,2)
    ak_pow=[(abs(ak(0+1)))^2 2*(abs(ak(1+1:fmax-1+1))).^2 (abs(ak(fmax+1)))^2];
else
    ak_pow=[(abs(ak(0+1)))^2 2*(abs(ak(1+1:fmax+1))).^2];
end
fbase=find(ak_pow == max(ak_pow(span_dc+1+1:fmax+1)))-1;
fbase1=max(span_dc+1,fbase-span_base+1)-1; 
fbase2=min(fbase+span_base+1,fmax+1)-1;
Psig=sum(ak_pow(fbase1+1:fbase2+1));
Fund=10*log10(Psig/(SINE_AMP^2/2));
clear ak ak_pow fbase fbase1 fbase2 Psig;
% if (COHER_SAMP==0)
%     Fund=Fund_1;
%     else if (COHER_SAMP==1)
%             Fund=Fund_2;
%         end
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ---------------------------------------------------
%  Using FFT to analyze signal spectrum 
% ---------------------------------------------------
if (COHER_SAMP==0)
    codew = code.* hanning(dPnts)';
    else if (COHER_SAMP==1)
            codew = code.* blackmanharris(dPnts)';
        else
            codew=code;
        end
end

ak=1/dPnts*fft(codew);
clear codew;

fmax=round((dPnts-1)/2);
if mod(dPnts-1,2)
    ak_pow=[(abs(ak(0+1)))^2 2*(abs(ak(1+1:fmax-1+1))).^2 (abs(ak(fmax+1)))^2];
    f_nyq=fmax;
else
    ak_pow=[(abs(ak(0+1)))^2 2*(abs(ak(1+1:fmax+1))).^2];
    f_nyq=fmax+1/2;
end


% ---------------------------------------------------
%  calc Psig(signal power) Pdc(dc power) 
%  Pn_d(noise and distortion power)
% ---------------------------------------------------
% --- to find base cluster ---
fbase=find(ak_pow == max(ak_pow(span_dc+1+1:fmax+1)))-1;
% if (COHER_SAMP==0)
%     fbase=fbase+0.5*(ak_pow(fbase+1+1)-ak_pow(fbase-1+1))/...  % fbase interpolation
%         (2*ak_pow(fbase+1)-ak_pow(fbase-1+1)-ak_pow(fbase+1+1));
% end
fbase1=max(span_dc+1,round(fbase)-span_base); 
fbase2=min(round(fbase)+span_base,fmax);

% --- to find maximum spur cluster ---
if (fbase1-span_dc)<2
    fmspur=find(ak_pow == max(ak_pow(fbase2+1+1:fmax+1)))-1;
else if (fmax-fbase2)<2
        fmspur=find(ak_pow == max(ak_pow(span_dc+1+1:fbase1-1+1)))-1;
    else
        fmspur=find(ak_pow == max(max(ak_pow(span_dc+1+1:fbase1-1+1)),max(ak_pow(fbase2+1+1:fmax+1))))-1;
    end
end
fmspur1=max(span_dc+1,fmspur-span_spur);
fmspur2=min(fmspur+span_spur,fmax);

% --- to find harmonics cluster ---
% --- initial ---
max_har_num=10;
idx=1;  % harmonic index
har_pow_max=0;  % maximum harmonic power
har_pow_max_order=0;
har_uth=0; % harmonic power under threshold
fh=zeros(1,max_har_num);
fh1=zeros(1,max_har_num);
fh2=zeros(1,max_har_num);

while (idx<max_har_num)
    idx=idx+1;
    f_har=round(fbase*idx);
    if mod(fix(f_har/f_nyq),2)    % calc folded harmonic freq
        fh(idx)=f_nyq - mod(f_har,f_nyq);
    else
        fh(idx)=mod(f_har,f_nyq);
    end
    fh(idx)=round(fh(idx));  % finite precision induces the fh is not an integer
 
    for i=2:(idx-1)
        if (abs(fh(idx)-fh(i))<= 2*span_har)|(fh(idx)-span_har <= span_dc)|(abs(fh(idx)-fbase) <= span_har+span_base)   
            % check if collide with other harmonic or base frequency or dc.
            fh(idx)=0;
%             break;
        end
    end
    
    if fh(idx)~=0
        fh1(idx)=fh(idx)-span_har;
        fh2(idx)=min(fh(idx)+span_har,fmax);
        har_pow=sum(ak_pow(fh1(idx)+1:fh2(idx)+1));
        har_pow_text(idx)=max(ak_pow(fh1(idx)+1:fh2(idx)+1));
        if har_pow>har_pow_max
            har_pow_max=har_pow;
            har_pow_max_order=idx;
        end
        
%         if har_pow < har_pow_max/10^(MIN_HAR_POW_RATIO_DB/10)
%             har_uth=har_uth+1;
%         else
%             har_uth=har_uth;
%         end
%     else
%         har_uth=har_uth+1;
    end
    
    % loop break when contiguous harmonics 
    % which's power under threshold exceed criteria
%     if har_uth>9 
%         fh=fh(1:idx-10);
%         fh1=fh1(1:idx-10);
%         fh2=fh2(1:idx-10);
% %         break;
%     end
end
% --- plot power spectrum ---
fint=(fclk/dPnts)/1e6; 
% figure('color','w');
% axes('FontSize',12.5);
% box on;
% hold on;
% % pow_norm=10*log10(SINE_AMP^2/2);
% pow_norm=10*log10(max(ak_pow(span_dc+1+1:fmax+1)))-Fund;
% plot([0:fmax]*fint,10*log10(ak_pow(1,:))-pow_norm, '-k');
% 
% plot([fbase1:fbase2]*fint, 10*log10(ak_pow(fbase1+1:fbase2+1))-pow_norm, '-r');
% plot([0:span_dc]*fint, 10*log10(ak_pow(0+1:span_dc+1))-pow_norm, '-g');
% 
% for idx=2:min(max_har_num,6)
%     if fh(idx)==0
%         continue;
%     end
%     plot([fh1(idx):fh2(idx)]*fint, 10*log10(ak_pow(fh1(idx)+1:fh2(idx)+1))-pow_norm, '-m');
%     text((fh(idx)-0)*fint,10*log10(har_pow_text(idx))+4-pow_norm,...
%         num2str(idx),'color','m','FontSize',10);
% end
% plot([fmspur1:fmspur2]*fint, 10*log10(ak_pow(fmspur1+1:fmspur2+1))-pow_norm, '-b');
% text((fmspur-60)*fint,10*log10(ak_pow(fmspur+1))+10-pow_norm,...
%     'msp','color','b','FontSize',12);
% 
% hold off;
% grid on;
% xlabel('FREQUENCY [MHz]',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% ylabel('AMPLITUDE [dBFS]',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% % title('FREQUENCY DOMAIN',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');



Ptot=sum(ak_pow);
Psig=sum(ak_pow(fbase1+1:fbase2+1));
Pdc=sum(ak_pow(0+1:span_dc+1));
Ph=zeros(1,length(fh));
for idx=2:max_har_num
    if fh1(idx)==0
        continue;
    end
    Ph(idx)=sum(ak_pow(fh1(idx)+1:fh2(idx)+1));
end
Pmspur=sum(ak_pow(fmspur1+1:fmspur2+1));

% ---------------------------------------------------
%  calc SINAD, ENOB
% ---------------------------------------------------
SNR=10*log10(Psig/(Ptot-Psig-Pdc-sum(Ph(2:6))));
SNRFS=SNR-Fund;
SINAD=10*log10(Psig/(Ptot-Psig-Pdc));
ENOB=(SINAD - 1.761 - Fund)/6.0206;
SFDR=10*log10(Psig/Pmspur);
THD=10*log10(sum(Ph(2:6))/Psig);
NoiseFloor=-SNRFS-10*log10(dPnts/2);
H_2nd=10*log10(Ph(2)/Psig);
H_3rd=10*log10(Ph(3)/Psig);
H_4th=10*log10(Ph(4)/Psig);
H_5th=10*log10(Ph(5)/Psig);
H_6th=10*log10(Ph(6)/Psig);
H_7th=10*log10(Ph(7)/Psig);
H_8th=10*log10(Ph(8)/Psig);
H_9th=10*log10(Ph(9)/Psig);
H_10th=10*log10(Ph(10)/Psig);

% fprintf('* Maximum harmonic order : %d / %.3f MHz \n',har_pow_max_order, fh(har_pow_max_order)*fint);
% fprintf('* Encode: %.3f MHz\n',fclk/1e6);
% fprintf('* Analog: %.3f MHz\n',fbase*fint);
% fprintf('* Fund:  %.3f  dBFS\n',Fund);
% fprintf('* SNR:   %.2f  dB\n',SNR);
% fprintf('* SINAD: %.2f  dB\n',SINAD);
% fprintf('* ENOB:  %.2f  Bits\n',ENOB);
% fprintf('* SFDR:  %.2f  dBc\n',SFDR);
% fprintf('* SNRFS: %.2f  dB\n',SNRFS);
% fprintf('* 2nd:  %.2f  dBc \n',H_2nd);
% fprintf('* 3rd:  %.2f  dBc \n',H_3rd);
% fprintf('* 4th:  %.2f  dBc \n',H_4th);
% fprintf('* 5th:  %.2f  dBc \n',H_5th);
% fprintf('* 6th:  %.2f  dBc \n',H_6th);
% fprintf('* THD:  %.2f  dBc \n',THD);
% fprintf('* Noise Floor:  %.2f  dBFS \n',NoiseFloor);
% fprintf('* Samples:  %d \n',dPnts);
% if (COHER_SAMP==0)
%     fprintf('* Windowing:  Hanning\n');
%     else if (COHER_SAMP==1)
%         fprintf('* Windowing:  Bh4\n');
%         else
%             fprintf('* Windowing:  None\n');
%         end
% end
% fprintf('* 7th:  %.2f  dBc \n',H_7th);
% fprintf('* 8th:  %.2f  dBc \n',H_8th);
% fprintf('* 9th:  %.2f  dBc \n',H_9th);
% fprintf('* 10th: %.2f  dBc \n',H_10th);

