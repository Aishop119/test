
I = imread('MRA.pgm');
ref = imread('MRA_Reference.pgm');
img= I;
[m,n]=size(img);

BW1=edge(img,'sobel'); %��Sobel���ӽ��б�Ե���

BW2=edge(img,'roberts');%��Roberts���ӽ��б�Ե���

BW3=edge(img,'prewitt'); %��Prewitt���ӽ��б�Ե���

BW4=edge(img,'log'); %��Log���ӽ��б�Ե��� 

BW5=edge(img,'canny'); %��Canny���ӽ��б�Ե���

h=fspecial('gaussian',5);%?��˹�˲�

BW6=edge(img,'canny');%��˹�˲���ʹ��Canny���ӽ��б�Ե���

subplot(2,3,1), imshow(BW1);
title('sobel ����','fontSize',18);
subplot(2,3,2), imshow(BW2);
title('roberts ����','fontSize',18);
subplot(2,3,3), imshow(BW3);
title('prewitt ����','fontSize',18);
subplot(2,3,4), imshow(BW4);
title('log ����','fontSize',18);
subplot(2,3,5), imshow(BW5);
title('canny����','fontSize',18);
subplot(2,3,6), imshow(BW6);
title('��˹�˲���ʹ��canny����','fontSize',18);

filter = ones(2,2);
BW3=imdilate(BW3,filter);
BW3=imfill(BW3,'holes');
figure();
imshow(BW3);
d= dice(ref,BW3)
% dice����
function [d] = dice(label,pred)
label = logical(label);
 X_Y = 2*label.*pred;
 XaddY= label+pred;C:\Users\yxsiat\Desktop\��һ����ҵ���¼\�����źŴ���\��ĩ����ҵ\edfread
 d = sumall(X_Y)/sumall(XaddY) ;
end
% ��������Ԫ�����
function [res]  =sumall(x)
    res= sum(sum(x));
end


