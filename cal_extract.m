% clc;
close all;
clear all;
step = 8;
start = 1;
fileName='/home/yixiao/DATAs/160M_12b_SAR_Test/data/INL_DNL_NOISE/100M.csv';
if isempty(fileName)
    return;
end
fid = fopen(fileName,'r');
if (fid == -1) 
    fprintf('File not found.');
    return;
end
fgetl(fid);
display(ans);
 mdac = textscan(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');
fclose(fid);
DATA=cell2mat(mdac);
for i=start:step:65536
    data((i-1)/step+1,:) = DATA(i,:); 
end
csvwrite('/home/yixiao/DATAs/160M_12b_SAR_Test/data/INL_DNL_NOISE/100.csv',data);