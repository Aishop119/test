
I = imread('MRA.pgm');
ref = imread('MRA_Reference.pgm');
img= I;
[m,n]=size(img);

BW1=edge(img,'sobel'); %用Sobel算子进行边缘检测

BW2=edge(img,'roberts');%用Roberts算子进行边缘检测

BW3=edge(img,'prewitt'); %用Prewitt算子进行边缘检测

BW4=edge(img,'log'); %用Log算子进行边缘检测 

BW5=edge(img,'canny'); %用Canny算子进行边缘检测

h=fspecial('gaussian',5);%?高斯滤波

BW6=edge(img,'canny');%高斯滤波后使用Canny算子进行边缘检测

subplot(2,3,1), imshow(BW1);
title('sobel 算子','fontSize',18);
subplot(2,3,2), imshow(BW2);
title('roberts 算子','fontSize',18);
subplot(2,3,3), imshow(BW3);
title('prewitt 算子','fontSize',18);
subplot(2,3,4), imshow(BW4);
title('log 算子','fontSize',18);
subplot(2,3,5), imshow(BW5);
title('canny算子','fontSize',18);
subplot(2,3,6), imshow(BW6);
title('高斯滤波后使用canny算子','fontSize',18);

filter = ones(2,2);
BW3=imdilate(BW3,filter);
BW3=imfill(BW3,'holes');
figure();
imshow(BW3);
d= dice(ref,BW3)
% dice函数
function [d] = dice(label,pred)
label = logical(label);
 X_Y = 2*label.*pred;
 XaddY= label+pred;C:\Users\yxsiat\Desktop\研一下作业与记录\数字信号处理\期末大作业\edfread
 d = sumall(X_Y)/sumall(XaddY) ;
end
% 矩阵所有元素相加
function [res]  =sumall(x)
    res= sum(sum(x));
end


