% using Matlab to analyze ADC's static performance when the input is sine wave
% Author: Zhu Kai
% ASIC & System State Key Lab, Fudan University
% Version 20080310

tic;
 clear;
close all;

numbit= 9;
numdel = 0;
sign_code= 0 ;    % 0 represent Ô­Âë, 1 represent ²¹Âë
numLSB=2^(numbit-numdel);
num_missingcode=0;
samples = 64*2^10;
n=samples;
data=zeros(n,1);
% ---------------------------------------------------
%  read data from data file to matrix named "rawdata"
% ---------------------------------------------------
fileName='H:\0528\i028.csv';
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
mdac = textscan(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');

fclose(fid);
data = 240*mdac{1,1}+ 128*mdac{1,2}+ 64*mdac{1,3}... %1.12 1.13 30~32
         + 36*mdac{1,4}+ 20*mdac{1,5}+ 10*mdac{1,6}...
         + 6*mdac{1,7}+ 4*mdac{1,8}+ 2*mdac{1,9}+ 1*mdac{1,10};
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

fwriteid=fopen('H:\0528\INL 001.txt','w');
fprintf(fwriteid, '            Dout            count                percent\n');
fprintf(fwriteid, '%15d  %15d  %20.2f \n', h);
status = fclose(fwriteid);

toc;