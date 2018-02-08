% to analyze adc's sampled data by section
% Author: ZhuKai
% Asic & System State Key Lab, Fudan University
% Version:3.0

code_max=max(code);
code_min=min(code);
% fprintf('code_max = %d, code_min = %d\n\n',code_max,code_min);
DC_OFFSET_section=(code_max+code_min)/2;
SINE_AMP_section=(code_max-code_min)/2;

% process data

j=1:dPnts;
k=1:ckc;
m=rem((j-1)*inc,ckc)+1;
m_max=find(code==code_max);
point_max=mean(m(m_max));    
clear m_max;

% m_ckc=find(m==3587);
% for i=100:110
%     temp=find(code(m_ckc)==i);
%     length_k(i)=length(temp);
%     clear temp;
% end
% i=100:110;
% figure('color','w');
% plot(i,length_k(i),'b-');
% grid;




for i=1:ckc;
    m_ckc=find(m==i);
    length_ckc(i)=length(m_ckc);
    if length_ckc(i)==0
        fprintf('length_ckc(%d)=0, please make the value of ckc smaller!!!',i);
        return;
    end  
    mean_ckc(i)=mean(code(m_ckc));
    std_ckc(i)=std(code(m_ckc));
    range_ckc(i)=max(code(m_ckc))-min(code(m_ckc));
    errorrate_ckc(i)=mean_ckc(i)-(SINE_AMP_section*cos(2*pi*(i-point_max)/ckc)+DC_OFFSET_section); 
    clear m_ckc;
end

% plot

figure('color','w');
axes('FontSize',12.5);
box on;
hold on;
plot(m(j)-1,code(j),'b.');
plot(k-1,mean_ckc(k),'r-',k-1,SINE_AMP_section*cos(2*pi*(k-point_max)/ckc)+DC_OFFSET_section,'g-');
title('section1',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
xlabel('time(s)',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
ylabel('output',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
grid;
figure;
plot(k-1,SINE_AMP_section*cos(2*pi*(k-point_max)/ckc)+DC_OFFSET_section-mean_ckc(k));

% figure('color','w');
% axes('FontSize',12.5);
% box on;
% plot(k-1,mean_ckc(k),'r-',k-1,SINE_AMP_section*cos(2*pi*(k-point_max)/ckc)+DC_OFFSET_section,'g-');
% title('section2',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% xlabel('time(s)',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% ylabel('output',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% grid;
% 
% figure('color','w');
% axes('FontSize',12.5);
% box on;
% plot(k-1,std_ckc(k),'r-',k-1,cos(2*pi*(k-point_max)/ckc),'b-');
% title('std',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% xlabel('time(s)',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% ylabel('std[LSB]',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% grid;
% 
% figure('color','w');
% axes('FontSize',12.5);
% box on;
% plot(k-1,std_ckc(k),'r-',k-1,range_ckc(k),'b-',k-1,cos(2*pi*(k-point_max)/ckc),'b-');
% title('range',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% xlabel('time(s)',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% ylabel('range[LSB]',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% grid;
% 
% figure('color','w');
% axes('FontSize',12.5);
% box on;
% plot(k-1,errorrate_ckc(k),'r-',k-1,cos(2*pi*(k-point_max)/ckc),'b-');
% title('errorrate',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% xlabel('time(s)',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% ylabel('errorrate[LSB]',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% grid;
% 
% figure('color','w');
% axes('FontSize',12.5);
% box on;
% plot(k-1,length_ckc(k),'b.');
% title('length',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% xlabel('time(s)',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% ylabel('length_ckc',          'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
% grid;

clear m length_ckc std_ckc range_ckc errorrate_ckc;
