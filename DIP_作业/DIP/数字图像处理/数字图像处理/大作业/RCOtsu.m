clc;clear;
close all force;
img = imread('MRA.pgm');
 figure();
imshow(img);
[l,h]=size(img);

%各个灰度值像素个数，xout是中心点的刻度
[n,xout]=hist(img(:),0:255);  
count = n' ; 
% bar(count);
p = count /  (l*h); %归一化数据，每个灰度level的概率
max_sig = 0;
c_k = 0;


 all_grey_level  = H( length(count) ,count);
 Hlb =  0.972*all_grey_level;
 Hhb = 0.985*all_grey_level;
 r_low = 0;
 r_high = 0;
 
 flag = 0;
 
 % 根据 Hlb 和Hhb 计算 r_low 与 r_high
for k=1:256
    
    x=H(k,count);
    if  x>=Hlb &&flag ~=1
        r_low = k;
        flag = 1;
    end 
    
    if  x>=Hhb && flag ~=0
        r_high  = k ;
        flag = 0;
        break;
    end
end

cost_func = 0;
sig=[];
for k = r_low:r_high
     % 统计类出现概率
    w0 = sum(p(1:k));
    w1 = sum(p(k+1:256));
    
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
    
    %计算类内差异
    temp=0;
    for i=1:k
        temp = temp+p(i)*(i-u0)^2;
    end
    sig0  =temp/w0;
    
    temp=0;
    for i=k+1:256
       temp = temp+p(i)*(i-u1)^2;
    end
    sig1  =temp/w1;
    
    
    temp  = w0*sig0+w1*sig1;
    
    sig =  [sig,temp] ; 
    
end
 
 T = r_low+find(sig==max(sig)) - 1 ;
 T = T/255;
 
  pred = imbinarize(img,T);
  

% subplot(121);
% imshow(res);
% 
% subplot(122);
% imshow(img);

% 用dice系数来评估分割的好坏
ref = imread('MRA_Reference.pgm');
d = dice(ref,pred)



%  累计频率计算函数
function [sum] = H(level,count)
    sum=0;
    for i=1:1:level
        sum = sum +count(i);
    end
end
% dice函数
function [d] = dice(label,pred)
label = logical(label);
 X_Y = 2*label.*pred;
 XaddY= label+pred;
 d = sumall(X_Y)/sumall(XaddY) ;
end
% 矩阵所有元素相加
function [res]  =sumall(x)
    res= sum(sum(x));
end
