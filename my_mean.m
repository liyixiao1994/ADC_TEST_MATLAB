
close all;
clear all;
step=1;
start=1;
num_0 = 0;
num_1 = 0;
bit_x = 16;
sum_0 = 0;
sum_1 = 0;
syms n N count data DATA;
       N=step*8*2^10;               %%%???????????????????????????
       n=8*2^10;
  data=zeros(n,1);
  data1=zeros(N,12);
fileName='/home/yixiao/DATAs/Slee_fy_test/slee_fy_17_12_30/4/4480_16.csv';
if isempty(fileName)
    return;
end
fid = fopen(fileName,'r');
if (fid == -1) 
    fprintf('File not found.');
    return;
end
fgetl(fid);
 mdac = textscan(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');
fclose(fid);
data1 = cell2mat(mdac);
for i=1:length(data1)
    if(data1(i,bit_x) == 0)
      sum_1 = sum_1 + 2890.35*(data1(i,16) == 1)+ 1575.74*(data1(i,15)==0)+875.31*(data1(i,14)==0)+ 481.6*(data1(i,13)==0)+ 262.85*(data1(i,12)==0)... %1.12 1.13 30~32
          + 141.83*(data1(i,11)==0)+ 75.08*(data1(i,10)==0)+ 43.86*(data1(i,9)==0)...
         + 21.47*(data1(i,8)==0)+ 14.5*(data1(i,7)==0)+ 8.64*(data1(i,6)==0)+ 6*(data1(i,5)==0)+3*(data1(i,4)==0)+2*(data1(i,3)==0)...
         +1*(data1(i,2)==0)+0.5*(data1(i,1)==0);
     num_1 = num_1 +1;
    else
      sum_0 = sum_0 + 2890.35*(data1(i,16) == 0)+ 1575.74*(data1(i,15)==0)+875.31*(data1(i,14)==0)+ 481.6*(data1(i,13)==0)+ 262.85*(data1(i,12)==0)... %1.12 1.13 30~32
          + 141.83*(data1(i,11)==0)+ 75.08*(data1(i,10)==0)+ 43.86*(data1(i,9)==0)...
         + 21.47*(data1(i,8)==0)+ 14.5*(data1(i,7)==0)+ 8.64*(data1(i,6)==0)+ 6*(data1(i,5)==0)+3*(data1(i,4)==0)+2*(data1(i,3)==0)...
         +1*(data1(i,2)==0)+0.5*(data1(i,1)==0);
     num_0 = num_0 +1;  
    end
end
format long;
sum_0/num_0 - sum_1/num_1