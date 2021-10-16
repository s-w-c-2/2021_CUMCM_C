%main
clc
clear


reduce =zeros(402,240);
satisfy =zeros(402,240);
need =zeros(402,240);
supply =zeros(402,240);

limnum=[];
aline=[];
bline=[];
cline=[];


load('need','need');
load('reduce','reduce');
load('supply','supply')
load('lab','lab')

needcopy=need;
reducecopy=reduce;
supplycopy=supply;
labcopy=lab;



for i = 1:402

    if lab(i)=='B'
        reduce(i,:)= reduce(i,:)*(11/10);
        need(i,:)=need(i,:)*(11/10);
        supply(i,:)=supply(i,:)*(11/10);
        
    end
    if lab(i)=='C'
        reduce(i,:)=reduce(i,:)*(12/11);
        need(i,:)=need(i,:)*(12/11);
        supply(i,:)=supply(i,:)*(12/11);
        
    end
end




for i= 1:402
    for j = 1:240
        if reduce(i,j)==0
            satisfy(i,j)=0;
        else
            satisfy(i,j)=1-abs(supply(i,j)-need(i,j))/need(i,j) ;     
        end
    end
end

%订单次数，筛选前
orderda=sum(need>0,2);

%满意度
satisfy_i=sum(satisfy,2)./orderda;


temp=sort(satisfy_i);  
limvalue=temp(20);


for i= 1:402
        if satisfy_i(i)<limvalue
            limnum = [limnum,i];
            
        end
   
end
%筛选
%satisfy_i(limnum)=[];

%supply(limnum,:)=[];

%need(limnum,:)=[];

%orderda=sum(need>0,2);

%reduce(limnum,:)=[];



%散点图怎么画好看点
leng=1:length(satisfy_i(:));
c = 255.*rand(1,length(leng));

scatter(leng,satisfy_i(:),5,c)


%满意度
Zsatisfy=satisfy_i;
%供货量
Zto_supply=sum(supply,2);

%订货量
Zto_need=sum(need,2)./orderda;

%供减求方差
Zredevar=(std(reduce,0,2)).^2;
%供应方差
Zsuppvar=(std(supply,0,2)).^2;

%
%Zorderda=orderda;

%需求方差
%Zneedvar=(std(need,0,2)).^2;

%


Z=[Zsatisfy,Zto_supply,Zto_need,Zredevar,Zsuppvar];
%熵权

%正向化
%极小—>极大
%我将供减求方差，供应方差视为极小
Zredevar=-Zredevar+max(Zredevar);
%Zsuppvar=-Zsuppvar+max(Zsuppvar);
%Zneedvar=-Zneedvar+max(Zneedvar);


%标准化
Z=mapminmax(Z,0,1);


%
P=Z./sum(Z);

e = -sum(P.*My_log(P))/log(size(Z,1));

d = 1 - e;

W = d./sum(d);

W=W';

D_max = sum((Z-repmat(max(Z),size(Z,1),1)).^2,2).^0.5;

D_min= sum((Z-repmat(min(Z),size(Z,1),1)).^2,2).^0.5;

score = (D_min)./(D_max+D_min);



[score_stand_sort, index] = sort(score, 'descend');
rest=index(1:50);
disp('最终名次为:')
disp(rest);

lab_rest=lab(rest);


for i = 1:length(lab_rest)
    if lab_rest(i)=='A'
        aline=[aline;rest(i)];
       
    end
    if lab_rest(i)=='B'

        bline=[bline;rest(i)];
    end
    if lab_rest(i)=='C'

        cline=[cline;rest(i)];
    end
end

    supply_a=supplycopy(aline,:);
    supply_b=supplycopy(bline,:);
    supply_c=supplycopy(cline,:);
    
    suma=sum(supply_a)
    sumb=sum(supply_b)
    sumc=sum(supply_c)
 











