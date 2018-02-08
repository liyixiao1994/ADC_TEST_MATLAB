close all;
clear all;
step=5;
start=1;
syms n N count data DATA;
       N=step*8*2^10;               %%%???????????????????????????
       n=8*2^10;
  data=zeros(n,1);
  data1=zeros(N,12);
fileName='/home/yixiao/DATAs/160M_12b_SAR_Test/data/INL_DNL_NOISE/noise_100M.csv';
if isempty(fileName)
    return;
end
fid = fopen(fileName,'r');
if (fid == -1) 
    fprintf('File not found.');
    return;
end
fgetl(fid);
 mdac = textscan(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');
fclose(fid);
data1 = 2048*mdac{1,12}+1024*mdac{1,11}+512*mdac{1,10}+ 256*mdac{1,9}+ 128*mdac{1,8}... %1.12 1.13 30~32
         + 64*mdac{1,7}+ 32*mdac{1,6}+ 16*mdac{1,5}...
         + 8*mdac{1,4}+ 4*mdac{1,3}+ 2*mdac{1,2}+ 1*mdac{1,1};
bar_data = tabulate(data1);
bar(bar_data(:,1),bar_data(:,2));
grid on;