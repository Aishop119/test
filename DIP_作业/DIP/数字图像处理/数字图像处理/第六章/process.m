clc;
clear;
close all force;
img = imread('img1.jpg');
img = rgb2gray(img);
 figure();
imshow(img);
[l,h]=size(img);

%�����Ҷ�ֵ���ظ�����xout�����ĵ�Ŀ̶�
[n,xout]=hist(img(:),0:255);  
count = n' ; 
bar(count);
p = count /  (l*h); %��һ�����ݣ�ÿ���Ҷ�level�ĸ���
max_sig = 0;
c_k = 0;
for k =1:256
    % ͳ������ָ���
    w0 = sum(p(1:k));
    w1 = 1-w0;
    
    % ͳ����ƽ���Ҷ�
    av0 = 0;
    av1 = 0;
    for i=1:k
        av0 = av0 + i*p(i);
    end
    u0 = av0 /w0;
    
    for i =k+1:256
        av1= av1 + i*p(i);
    end
    u1 = av1/w1;
    
    sig = w0*w1*(u1-u0)^2;  %������䷽��
    if sig>max_sig
        max_sig = sig;   %ʹsig���
        c_k = k;  %��¼��ʱ����ֵ
    end
end 

T = graythresh(img);
 c_k = (c_k-1)/255; 
 % ����������ֵ��ֵ�� 
 res1 = imbinarize(img,c_k);
 res2 = imbinarize(img,T);
 figure();

 subplot(131);
 imshow(res1);
 title('�ֶ�ʵ�� ');
 subplot(132);
 imshow(res2);
 title(' �ٷ�ʵ�� ');
 figure();
 imshow(img)
 
