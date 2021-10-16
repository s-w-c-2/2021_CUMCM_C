%周数统计
%state
clc
clear
%评价2，3问
%load('data','data');
%load('data2','data2');data=data2;
load('ori_data','ori_data');data=ori_data;
save_data=28200*2;
numflase=0;
num=0;

for i = 1:length(data)
    save_data=save_data-28200+data(i);
    if  save_data <0
        numflase=numflase+1;
    end
    
    if save_data<2*28200
        num=num+1;
    end
 
end

        
            
            
        
    