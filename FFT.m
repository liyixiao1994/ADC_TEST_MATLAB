% close all;
function [ENOB]=FFT(code)
fclk=40;                      % Sampling frequency:(MHz)
cohear=0;
numpt=length(code);
Delt = sum(code(1:(numpt)))/(numpt);
% % % plot(code,'red');                       
%**************************** 

code=code-(max(code)+min(code))/2;
codew = code.*hanning(numpt)';
% % % % hold on;   
% % % plot(codew);
%********************************
if cohear==0
    codef=codew;
else
    codef=code;
end
%********************************
Dout_spect=fft(codef);
Dout_dB=20*log10(abs(Dout_spect));


spectP=(abs(Dout_spect)).*(abs(Dout_spect));
maxdB=max(Dout_dB(1:numpt/2));
fin=find(Dout_dB(1:numpt/2)==maxdB);
span=max(round(numpt/100),2);
% if fin<=span
   % errordlg('Please change a number for numpt','Input Error 1');
   % break;
% end 
spanh=0;



% SS=calculateSNR(Dout_spect(1:numpt/2),fin-1)
%Vector/matrix to store both frequency and power of signal and harmonics
%The 1st element in the vector/matrix represents the signal, the next element represents 
%the 2nd harmonic, etc.
%Find harmonic frequencies and power components in the FFT spectrum
Fh=[];
Qh=[];
Ph=[];
Ah=[];
Pc=spectP(1);
for har_num=1:10
    %Input tones greater than fSAMPLE are aliased back into the spectrum
   tone=rem((har_num*(fin-1)+1)/numpt,1);
   if tone==0
      tone=2/numpt;
   else
      ton=(numpt+2-tone*numpt)/numpt;
      tone=min(ton,tone);
   end
   to=(tone*numpt-1)/numpt;
   Fh=[Fh to];
   t=tone*numpt;
   Ah=[Ah t];
    %For this procedure to work, ensure the folded back high order harmonics do not overlap
   %with DC or signal or lower order harmonics
   har_peak=max(spectP(round(tone*numpt)-spanh:round(tone*numpt)+spanh));
   har_bin=find(spectP(round(tone*numpt)-spanh:round(tone*numpt)+spanh)==har_peak);
   har_bin=har_bin+round(tone*numpt)-spanh-1; %%?
   Ph=[Ph sum(spectP(har_bin:har_bin))];
   sh=Dout_dB(tone*numpt)-maxdB;
   Qh=[Qh sh];
end

Dd=[];
[Bh,p,Dd]=v2d(Ah(1:5),span,spectP);

Pdc=sum(spectP(1:span));
if rem(numpt/2,1)==0
   numptt=numpt+2; 
else
   numptt=numpt+1;
end 
if fin<=11
   Pdc=Pc;
 end
Pd=sum(Dd(1:p));
Ps=sum(spectP(fin-span:fin+span));
% Ps=sum(spectP(1:fin+span));
Pn=sum(spectP(1:numptt/2))-Pdc-Ps-Pd;
% if Pn<=0
% %     disp('please change a number for numpt');
% %     errordlg('Please change a number for numpt','Input Error 2');
%     return;
% end 
if Pn<=0
Pn=0;
end 

Cd=m2d(Ah,span,spectP);

format;
FS=fin*fclk/numpt;
SNDR=10*log10(Ps/(Pn+Pd));
ENOB=(SNDR-1.763)/6.02;
SNR=10*log10(Ps/Pn);
SFDR=10*log10(Ph(1)/Cd);
% disp('THD is calculated from 2nd through 5th order harmonics');
THD=10*log10(Pd/Ph(1));
HD=10*log10(Ph(1:10)/Ph(1));
% disp('Signal & Harmonic Power Components:');
if SNDR<=0
    errordlg('Please change a number for numpt','Input Error 3');
end




%Distinguish all harmonics locations within the FFT plo

%plot([0:numpt/2-1].*fclk/numpt,Dout_dB(1:numpt/2)-maxdB,'k');

%h1=gca;
%set(h1,'color',[1,0.91,0.84]);

%hold on;
%plot(Fh(2)*fclk,0,'mo',Fh(3)*fclk,0,'cx',Fh(4)*fclk,0,'r+',Fh(5)*fclk,0,'g*',...
%Fh(6)*fclk,0,'bs',Fh(7)*fclk,0,'bd',Fh(8)*fclk,0,'kv',Fh(9)*fclk,0,'y^');
%legend('1st','2nd','3rd','4th','5th','6th','7th','8th','9th');
%grid on;
%title('FFT PLOT');
%xlabel('ANALOG INPUT FREQUENCY (MHz)');
%ylabel('AMPLITUDE (dB)');
%hold off;

% % % % % % % t=[0:numpt/2-1].*fclk/numpt;
% % % % % % % s=Dout_dB(1:numpt/2)-maxdB;
% % % % % % % figh=figure('Position',[110,30,560,405],'DefaultAxesColor',[1,0.91,0.84],'color',[.79 .77 .82]);
% % % % % % % %figh=figure('Position',[110,30,560,405]);
% % % % % % % AX_H1=subplot(1,1,1);
% % % % % % % grid on;
% % % % % % % set(AX_H1,'LineWidth',2);
% % % % % % % set(AX_H1,'Color',[1 1 1]);
% % % % % % % plot(t,s)
% % % % % % % hold on;
% % % % % % % plot(Fh(2)*fclk,0,'mo',Fh(3)*fclk,0,'cx',Fh(4)*fclk,0,'r+',Fh(5)*fclk,0,'g*',...
% % % % % % % Fh(6)*fclk,0,'bs',Fh(7)*fclk,0,'bd',Fh(8)*fclk,0,'kv',Fh(9)*fclk,0,'y^');
% % % % % % % legend('1st','2nd','3rd','4th','5th','6th','7th','8th','9th');
% % % % % % % grid on;
% % % % % % % %FS=FS+100;
% % % % % % % string=sprintf('SNDR=%3.1fdB    SFDR=%3.1fdb    SNR=%3.1fdb    ENOB=%3.2f    Fin=%7.1fMHz ',SNDR,SFDR,SNR,ENOB,FS);
% % % % % % % title(string);
% % % % % % % xlabel('ANALOG INPUT FREQUENCY (MHz)');
% % % % % % % ylabel('AMPLITUDE (dB)');
% % % % % % % hold off;
end

%Ê±Óò
%figure;
%plot([1:numpt],code,'k');
%h1=gcf;
%set(h1,'color',[.79 .77 .82]);

%figure;
%plot([1:numpt],code);

%title('TIME DOMAIN');
%xlabel('SAMPLES');
%ylabel('DIGITAL OUTPUT CODE');
%grid on;

%plot(output)

