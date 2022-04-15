clear all;close all ;clc;
G=imread('MRA.pgm');
figure();
subplot(2,2,1);
imshow(G);
subplot(2,2,2);
imhist(G);
subplot(2,2,3);
[h,x]=imhist(G);
h=smooth(h,7);
plot(x,h)
%�����ֵT
df1=diff(h);%һ�ײ��
df2=diff(df1);%���ײ��

% figure(1);
% subplot(121);
% plot(1:255,df1);
% subplot(122);
% plot(1:254,df2);

[m,n]=size(df2);
T=0;
for i=1:m
if(abs(df1(i+1))<=0.2 && df2(i)>0 )
    T=x(i+2);  %ȷ����ֵ
    break;
end
end
% G=im2bw(G,T/255);%תΪ��ֵͼ��
pred = imbinarize(G,T/255);
subplot(2,2,4);
imshow(pred);

ref = imread('MRA_Reference.pgm');
d = dice(ref,pred)


%  �ۼ�Ƶ�ʼ��㺯��
function [sum] = H(level,count)
    sum=0;
    for i=1:1:level
        sum = sum +count(i);
    end
end
% dice����
function [d] = dice(label,pred)
label = logical(label);
 X_Y = 2*label.*pred;
 XaddY= label+pred;
 d = sumall(X_Y)/sumall(XaddY) ;
end
% ��������Ԫ�����
function [res]  =sumall(x)
    res= sum(sum(x));
end