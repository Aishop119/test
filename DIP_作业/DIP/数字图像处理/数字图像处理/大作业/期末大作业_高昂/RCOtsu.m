clc;clear;
close all force;
img = imread('MRA.pgm');
 figure();
imshow(img);
[l,h]=size(img);

%�����Ҷ�ֵ���ظ�����xout�����ĵ�Ŀ̶�
[n,xout]=hist(img(:),0:255);  
count = n' ; 
% bar(count);
p = count /  (l*h); %��һ�����ݣ�ÿ���Ҷ�level�ĸ���
max_sig = 0;
c_k = 0;


 all_grey_level  = H( length(count) ,count);
 Hlb =  0.972*all_grey_level;
 Hhb = 0.985*all_grey_level;
 r_low = 0;
 r_high = 0;
 
 flag = 0;
 
 % ���� Hlb ��Hhb ���� r_low �� r_high
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
     % ͳ������ָ���
    w0 = sum(p(1:k));
    w1 = sum(p(k+1:256));
    
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
    
    %�������ڲ���
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

% ��diceϵ���������ָ�ĺû�
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
