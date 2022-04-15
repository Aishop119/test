clc;
clear;
close all force;
o_img = rgb2gray(imread('Chapter5_1.bmp')); %ԭʼͼ��\
maxsize = 100; % �������ֵ 100
step  = 6; %����
value= [];

for i=step:step:maxsize 
    %���ɽṹԪ
     filter1 = strel('square',i);
     filter2 = strel('square',i-step);
     %������
     img1 = imopen(o_img,filter1);
     img2 = imopen(o_img,filter2);
     %  n*step~��n-1��*step  ԭʼͼ���ȥ��Ԫ����ͼ��
     sub1 =  o_img - img1;
     sub2 = o_img - img2 ;
     sub  = sub1/255 - sub2/255 ; %��һ���������
      v_t  = sum( sub(:) )/(i*i) ;  % ������ԽṹԪ����������
      if v_t<0.1
          v_t=0;  %�ų����ر�С��ϸ��
      end
    value = [value , v_t];
    
       if i <40
        figure(i);
        title(['size=' ,i,' ~ ' ,i-1])
        
       subplot(231);
       imshow(img1);
       title(['���������ṹԪ:'  ,num2str(i) ]  )
       
       subplot(232);
       imshow(img2);
       title(['���������ṹԪ',num2str(i-step)])
       
       subplot(234)
       imshow(sub1);
       title(['�׶�ñ���ṹԪ',num2str(i)])
       
       subplot(235)
       imshow(sub2);
       title(['�׶�ñ���ṹԪ' ,num2str(i-step)])       
       
       
       subplot(236);
       imshow(sub1-sub2);
       title('����')
       
       end
   
  
end
 
size = step:step:maxsize;
figure(2);
bar(size,value);


