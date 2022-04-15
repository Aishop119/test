clc;
clear;
close all force;
o_img = rgb2gray(imread('Chapter5_1.bmp')); %原始图像\
maxsize = 100; % 设置最大值 100
step  = 6; %步长
value= [];

for i=step:step:maxsize 
    %生成结构元
     filter1 = strel('square',i);
     filter2 = strel('square',i-step);
     %开操作
     img1 = imopen(o_img,filter1);
     img2 = imopen(o_img,filter2);
     %  n*step~（n-1）*step  原始图像减去开元算后的图像
     sub1 =  o_img - img1;
     sub2 = o_img - img2 ;
     sub  = sub1/255 - sub2/255 ; %归一化计算面积
      v_t  = sum( sub(:) )/(i*i) ;  % 面积除以结构元面积计算介于
      if v_t<0.1
          v_t=0;  %排除掉特别小的细节
      end
    value = [value , v_t];
    
       if i <40
        figure(i);
        title(['size=' ,i,' ~ ' ,i-1])
        
       subplot(231);
       imshow(img1);
       title(['开操作，结构元:'  ,num2str(i) ]  )
       
       subplot(232);
       imshow(img2);
       title(['开操作，结构元',num2str(i-step)])
       
       subplot(234)
       imshow(sub1);
       title(['白顶帽，结构元',num2str(i)])
       
       subplot(235)
       imshow(sub2);
       title(['白顶帽，结构元' ,num2str(i-step)])       
       
       
       subplot(236);
       imshow(sub1-sub2);
       title('作差')
       
       end
   
  
end
 
size = step:step:maxsize;
figure(2);
bar(size,value);


