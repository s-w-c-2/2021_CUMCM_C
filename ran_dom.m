clc
clear
load('tra1','tra1');
load('tra2','tra2')
tra1=tra1';
tra2=tra2';
all=427732;

load('lossrate','lossrate');

lossrate=lossrate;

test = rand(8,8);
test = (test./sum(test,2))*all;


tra =[tra1;tra2;test];

lossrate=lossrate';
loss = (tra.*lossrate);
loss = sum(loss,2)/24;





