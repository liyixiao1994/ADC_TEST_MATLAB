close all;
clear all;

out_bits = 16;%????????
code_bits = 15;%????????????????
step = 100;%????????
start = 1;%????????????
over_len = 100;%??????????????
cal_offset = 2;%??????????????????????????????????over_len - cal_offset??????????
weight_array=[3696 2016 1120 616 336 182 98 56 28 19 11 6 3 2 1 0.5];%????
code_array=[3696 2016 1120 616 336 182 98 56 28 19 11 6 3 2 1];%????????????
numbit = 12;%ADC????????
numdel =0;
sign_code= 0;    % 0 represent ????, 1 represent ????
FREQ_SAMP = 27e6;
COHER_SAMP = 0;     % 0 represent hanning window, 1 represent Blackman Harris 4-Term window, 2 represent not using window

 N=8*2^10;
 
%N=step*n;               %%%????????????

fileName = '/run/media/yixiao/DCEF-D681/input.csv';
codeName = '/run/media/yixiao/DCEF-D681/test_src.csv';
if isempty(fileName)
   return;
end
fid = fopen(fileName,'r');
if (fid == -1)
    fprintf('File not found\n');
    return;
end

if(length(weight_array) ~= out_bits)
   disp('weight_array and outbits does not match\n');
   return;
end

fgetl(fid);
display(ans);

%
%????????
%
str = '%f';
str1 = ',%f';
for i=2:out_bits
    str = [str str1];
end
mdac = textscan(fid,str);
fclose(fid);

DATA = cell2mat(mdac);

%
%????step????????????
%
for i=start:step:length(DATA)
    data1((i-start)/step+1,:) = DATA(i,:);
end

%
%??????????????????????????
%
sum_of_over = 0;
j=1;
[rows,columns] = size(data1);
array_start = 0;
array_end = 0;

if(columns ~= out_bits)
   disp('out_bits is error\n');
   return;
end

for i=2:length(data1)
    if(data1(i,columns) == 0)
        sum_of_over = sum_of_over +1;
        over_count(j,1) = sum_of_over;
    else
        if(data1(i-1,columns) == 0)
           sum_of_over = 0;
           if(over_count(j,1) > over_len - cal_offset)
               if (array_start == 0)
                  array_start = i;
               else
                   if(array_end == 0)
                       array_end = i-over_count(j,1)-1;
                   end
               end
           end
           j = j+1;
        end
    end
end

%
%????????????????????????????????????????????????????????????????????????????????????????????????????
%
array_len = array_end - array_start + 1;
if(array_len ~= N)
    if(abs(array_len - N)>2)
       fprintf('Error!!!!!!!!!!!:The length of array is %d and it is incompatible',array_len);
       return;
    end
    fprintf('Warning!!!!!!!!!!The length of array is not %d\n',N);
    fprintf('The length of array is %d\n',array_len);
    fprintf('The start point is %d and the end point is %d\n',array_start,array_end);
    fprintf('Please input the start point and the end point so that the length of array is %d\n',N);
    array_start = input('start point:');
    array_end = input('end point:');
    
    if(array_end - array_start ~= N-1)
       fprintf('Error!!!!!!!!!!The length of array is not %d\n',N);
       return;
    end
end
%csvwrite('H:\SLee\Projects\????\FY\datas\cal.csv',data1);

j=1;
outdata=zeros(N,1);
for i=array_start:array_end
    for k=1:out_bits
       outdata(j,1) = outdata(j,1) + weight_array(1,k)*data1(i,out_bits-k+1);
    end
    j = j+1;
end

%
%??????????????
%

if isempty(codeName)
   return;
end
fid = fopen(codeName,'r');
if (fid == -1)
    fprintf('File not found\n');
    return;
end

fgetl(fid);
display(ans);

%
%????????
%
str = '%f';
str1 = ',%f';
for i=2:code_bits
    str = [str str1];
end
mdac = textscan(fid,str);
fclose(fid);

code_data = cell2mat(mdac);

[rows,columns]=size(code_data);
if (columns ~= code_bits)
   disp('code file error\n');
   return;
end

j=1;
codedata=zeros(rows,1);
for i=1:rows
    for k=1:columns
       codedata(j,1) = codedata(j,1) + code_array(1,k)*code_data(i,code_bits-k+1);
    end
    j = j+1;
end

if(length(outdata) ~= length(codedata))
   disp('extract array does not match code array\n'); 
   return;
end
syms n count data;        
n=8*2^10;
data=zeros(N,1);
for i=1:N
   data(i,1)=outdata(i,1)+code_data(i,1); 
end

code=data'-sum(data)/N;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sign_code== 0
    DC_OFFSET = 2^(numbit-1);
else if sign_code== 1
        DC_OFFSET = 0;
    end
end
SINE_AMP  = 2^(numbit-numdel-1)-0.5;

ckc = 2^13;
inc = 491;  %491 3079 6143 14347 20483

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dPnts=length(code);
fprintf('* Total sampling points : %d\n',dPnts);

code=floor(code/(2^numdel));

figure('color','w');
axes('FontSize',12.5);
box on;
plot(code,'x','MarkerSize',3);
title('TIME DOMAIN', 'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
xlabel('SAMPLES', 'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');
ylabel('DIGITAL OUTPUT CODE', 'color','k','FontSize',12.5,'FontName','Arial','FontWeight','normal');

fclk=FREQ_SAMP;

section
dynproc_zhuk_2w