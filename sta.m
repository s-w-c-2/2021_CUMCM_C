clc
clear

limnum1=[];
limnum2=[];
reduce =zeros(402,240);

load('reduce','reduce');
load('supply','supply')
load('lab','lab')


for i= 1:402
    for j = 1:240
        if reduce(i,j)==0
            reduce(i,j)=1;
        else
            reduce(i,j)=reduce(i,j)./supply(i,j)   ;     
        end
    end
end



%{
%散点图怎么画好看点
leng=1:length(reduce(:));
c = 255.*rand(1,length(leng));

scatter(leng,reduce(:),5,c)
%}

naga=sum(reduce<0,2);

temp1=sort(naga(:));
limnaga=temp1(380);  %数量限制后百分之5   偷了个懒，手动取整

%A,B,C 权值
for i = 1:402
    if lab(i)=='A'
        reduce(i,:)=reduce(i,:)*132;
    end
    if lab(i)=='B'
        reduce(i,:)= reduce(i,:)*120;
    end
    if lab(i)=='C'
        reduce(i,:)=reduce(i,:)*110;
    end
end


temp2=sort(reduce(:));  
limvalue=temp2(241);     %数值限制后百分之2.5  

%周数统计

for i= 1:402
    if naga(i)>limnaga
        limnum1 = [limnum1,i];
       
    end
end




%数值统计
for i= 1:402
    for j = 1:240
        if reduce(i,j)<limvalue
            limnum2 = [limnum2,i];
            break
        end
    end
end

limnum=union(limnum1,limnum2);
line=1:size(reduce,1);


line(limnum)=[];  %筛选列

reduce(limnum,:)=[];
naga(limnum,:)=[];

res=reduce;     %筛选结果


%指标


%satisfy=zeros(402,1);
z_satisfy=naga./240;

%方差

z_vareduce=(std(reduce,0,2)).^2;

Z=[z_satisfy,z_vareduce];





%熵权

%正向化
%极小—>极大

%reduce=-reduce+max(max(reduce));

%标准化
Z=mapminmax(Z,0,1);

%元素概率

P=reduce./sum(reduce);







%e = -sum(P.*log(P))/log(length(line));
e = -sum(P.*My_log(P))/log(length(line));


d = 1 - e;

%熵权
W = d./sum(d);
W=W';


z_max=max(Z);


z_min=min(Z);




D_max = sum((Z-repmat(max(Z),size(Z,1),1)).^2,2).^0.5;

D_min= sum((Z-repmat(min(Z),size(Z,1),1)).^2,2).^0.5;

score = (D_min)./(D_max+D_min);


score_stand = score ./ sum(score);
[score_stand_sort, index] = sort(score_stand, 'descend');
rest=index(1:50);
disp('最终名次为:')
disp(rest);















            
        