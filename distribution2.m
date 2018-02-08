close all;
clear all;
step=2;
start=1;
bit_x = 8;
num_x = 0;
syms n N count data DATA;
       N=step*8*2^10;               %%%���������
       n=8*2^10;
  data1=zeros(N,12);
% fileName='D:\�ĵ�\оƬ����\оƬ����-200M RA ADC\�������\0828\03\2M\002.csv';
fileName='/home/yixiao/DATAs/Slee_fy_test/slee_fy_17_12_24/7.csv';
if isempty(fileName)
    return;
    %%
    % $x^2+e^{\pi i}$
end
fid = fopen(fileName,'r');
%display(fid);
if (fid == -1) 
    fprintf('File not found.');
    return;
end
fgetl(fid);
%display(ans);
 mdac = textscan(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');
 
 data1 = cell2mat(mdac);
 
id = find(data1(:,bit_x) == 1);
data1(id,:) = [];
% mdac = mat2cell(data1,length(data1),ones(1,16));
% data1 = 3696*mdac{1,16}+ 2016*mdac{1,15}+1120*mdac{1,14}+ 616*mdac{1,13}+ 336*mdac{1,12}... %1.12 1.13 30~32
%          + 182*mdac{1,11}+ 98*mdac{1,10}+ 56*mdac{1,9}...
%          + 28*mdac{1,8}+ 19*mdac{1,7}+ 11*mdac{1,6}+ 6*mdac{1,5}+3*mdac{1,4}+2*mdac{1,3}...
%          +1*mdac{1,2}+0.5*mdac{1,1};
% bar_data = tabulate(data1);
% bar(bar_data(:,1),bar_data(:,2));
% grid on;