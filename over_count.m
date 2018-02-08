close all;
clear all;

sum_of_over = 0;

fileName='/home/yixiao/DATAs/Slee_fy_test/cal/3/noise_extract.csv';
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
 mdac = textscan(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f');
fclose(fid);
DATA=cell2mat(mdac);
j=1;
print=1;
for i=2:length(DATA)
    if(DATA(i,16)==0)
        %
        %print the start point of over
        %
%         if(j == 1430 && print==1)
%             i
%            print=0;
%         end
        sum_of_over = sum_of_over + 1;
        count(1,j)=sum_of_over;
    else if(DATA(i-1,16)==0)
        j = j+1;
        sum_of_over = 0;
        end
    end
end
for i=884:1:9075
    data((i-884)/1+1,:) = DATA(i,:);
end
csvwrite('/home/yixiao/DATAs/Slee_fy_test/cal/3/final_noise_extract.csv',data);