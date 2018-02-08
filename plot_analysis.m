% clc;
close all;
clear all;
syms n count data;
       n=16*2^10;
  data=zeros(n,1);
fileName='c:\cyz\0822\030.csv';
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
%  mdac = textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f %f %f');
fclose(fid);


for i=1:n
    data(i) = 2^11*mdac{1,1}(i)+ 1.002*2^10*mdac{1,2}(i)+ 2^9*mdac{1,3}(i)...
         + 1.0690*0.5*(1+(-1)^i)*(2^9*mdac{1,4}(i)+ 2^8*mdac{1,5}(i)+ 2^7*mdac{1,6}(i)... 
         + 2^6*mdac{1,7}(i)+ 2^5*mdac{1,8}(i)+ 2^4*mdac{1,9}(i)...
         + 2^3*mdac{1,10}(i)+ 2^2*mdac{1,11}(i)+ 2^1*mdac{1,12}(i)+ 2^0*mdac{1,13}(i))...
         + 1.0579*0.5*(1+(-1)^(i+1))*(2^9*mdac{1,4}(i)+ 2^8*mdac{1,5}(i)+ 2^7*mdac{1,6}(i)... 
         + 2^6*mdac{1,7}(i)+ 2^5*mdac{1,8}(i)+ 2^4*mdac{1,9}(i)...
         + 2^3*mdac{1,10}(i)+ 2^2*mdac{1,11}(i)+ 2^1*mdac{1,12}(i)+ 2^0*mdac{1,13}(i));
end
    code=data';
    plot(code);
   
