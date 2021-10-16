clc
clear

load('temp1','temp1');
len=1:402;
temp1=temp1(len,:);
temp=temp1;

temp1=temp1(sum(temp1,2)>0,:);


suma=sum(temp1);

total=suma./0.6;

