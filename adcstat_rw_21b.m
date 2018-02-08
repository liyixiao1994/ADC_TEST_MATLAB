% using Matlab to analyze ADC's static performance when the input is sine wave
% Author: Zhu Kai
% ASIC & System State Key Lab, Fudan University
% Version 20080310

tic;
 clear;
close all;

numbit= 11;
numdel = 0;
sign_code= 0 ;    % 0 represent ‘≠¬Î, 1 represent ≤π¬Î
numLSB=2^(numbit-numdel)+10;
num_missingcode=0;
samples = 64*2^10;
n=samples;
data=zeros(n,1);
% ---------------------------------------------------
%  read data from data file to matrix named "rawdata"
% ---------------------------------------------------
fileName='D:\Œƒµµ\–æ∆¨≤‚ ‘\–æ∆¨≤‚ ‘-200M RA ADC\≤‚ ‘ ˝æ›\0910\04\i001.csv';
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

for k=1:samples
    i=k;
    data(i) = (2^11*mdac{1,1}(i)+ 1.002*2^10*mdac{1,2}(i)+ 0.995*2^9*mdac{1,3}(i)...
         + (0.9866*0.5*(1+(-1)^i)*(1*2^9*mdac{1,4}(i)+ 1.002*2^8*mdac{1,5}(i)+ 1.004*2^7*mdac{1,6}(i)...  %1.0706
         + 2^6*mdac{1,7}(i)+ 2^5*mdac{1,8}(i)+ 2^4*mdac{1,9}(i)...
         + 2^3*mdac{1,10}(i)+ 2^2*mdac{1,11}(i)+ 2^1*mdac{1,12}(i)+ 0*2^0*mdac{1,13}(i))...
         + 0.9915*0.5*(1+(-1)^(i+1))*(1*2^9*mdac{1,4}(i)+ 1.002*2^8*mdac{1,5}(i)+ 1.004*2^7*mdac{1,6}(i)...  %1.0594
         + 2^6*mdac{1,7}(i)+ 2^5*mdac{1,8}(i)+ 2^4*mdac{1,9}(i)...
         + 2^3*mdac{1,10}(i)+ 2^2*mdac{1,11}(i)+ 2^1*mdac{1,12}(i)+ 0*2^0*mdac{1,13}(i))))/2;

end
% [y] = LMS_INL(data(1:2:n), data(2:2:n),1000,0.01e-10, W(:,32*2^10));% 50 0.2e-10
% [y, W, e] = LMS1(data(1:2:n), data(2:2:n),1000, 0.01e-10, 1);% 50 0.2e-10
% data(2:2:n)=y;
% datao=zeros(n/4,1);
% for i=(3*n/4+1):n
%     k=i-3*n/4;
%     datao(k)= data(i);
% %      data(k)=y(i);
% end

code=data';
% code=(code-min(code))/(max(code)-min(code))*2^11;
code=floor(code/(2^numdel))+1;
dPnts=length(code);
clear data W e;
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
h=zeros(1,3*numLSB);
for i=1:numLSB;
    h(3*i-2)=i-1;
    h(3*i-1)=count(i);
    h(3*i-0)=percent(i);
end

fwriteid=fopen('D:\Œƒµµ\–æ∆¨≤‚ ‘\–æ∆¨≤‚ ‘-200M RA ADC\≤‚ ‘ ˝æ›\0910\04\Histogram001_bc.txt','w');
fprintf(fwriteid, '            Dout            count                percent\n');
fprintf(fwriteid, '%15d  %15d  %20.2f \n', h);
status = fclose(fwriteid);

toc;