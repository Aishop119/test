clc;
clear;
close all force;
img = imread('img1.jpg');
img = rgb2gray(img);
 figure();
imshow(img);
[l,h]=size(img);

%各个灰度值像素个数，xout是中心点的刻度
[n,xout]=hist(img(:),0:255);  
count = n' ; 
bar(count);
p = count /  (l*h); %归一化数据，每个灰度level的概率
max_sig = 0;
c_k = 0;
for k =1:256
    % 统计类出现概率
    w0 = sum(p(1:k));
    w1 = 1-w0;
    
    % 统计类平均灰度
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
    
    sig = w0*w1*(u1-u0)^2;  %计算类间方差
    if sig>max_sig
        max_sig = sig;   %使sig最大
        c_k = k;  %记录此时的阈值
    end
end 

T = graythresh(img);
 c_k = (c_k-1)/255; 
 % 根据所得阈值二值化 
 res1 = imbinarize(img,c_k);
 res2 = imbinarize(img,T);
 figure();

 subplot(131);
 imshow(res1);
 title('手动实现 ');
 subplot(132);
 imshow(res2);
 title(' 官方实现 ');
 figure();
 imshow(img)
 
