clc;clear;
img  = imread('Chapter2_1.pgm');

% 最邻近 
img_15 = imrotate(img,-15,'nearest');
imshow(img_15);
img_ = imrotate(img_15,-345,'nearest');
[r,c] = size(img_);

cut_r=0;
cut_c=0;
flag=0;
for i =1:r
    if flag ==0
        for j=1:c
            if img_(i,j) == img(1,1)
               %  fprintf( " %d,%d",i,j);  
                % 找到第一个像素点在当前矩阵中的位置
                cut_r=i;
                cut_c=j;
                flag=1;
                break;
            end
        end
    else 
        break;
    end
end

% 对旋转回原位的图像进行裁剪 
img_ =img_(cut_r:166,cut_c:168);
imshow(img_);
subtract_img_img_ = img - img_;

subplot(131);
imshow(img);
title(' 原图 ','fontSize',18);

subplot(132);
imshow(img_15);
title(' 顺时针转15度 ','fontSize',18);

subplot(133);
imshow(img_);
title(' 顺时针转回原位 ','fontSize',18);
figure();
imshow(subtract_img_img_);
title(' 原图减去旋转后图像 ','fontSize',18);
mean ( mean(img_) )
mean ( mean(img)  )

figure();
imhist(img_);
title(' 旋转后 ','fontSize',18);

figure()
imhist(img);
title(' 原图 ','fontSize',18);


% % 最邻近 
% clc;clear;close all;
% img  = imread('Chapter2_1.pgm');
% 
% img_15 = imrotate(img,-15,'bilinear');
% imshow(img_15);
% img_ = imrotate(img_15,-345,'bilinear');
% [r,c] = size(img_);
% 
% cut_r=0;
% cut_c=0;
% flag=0;
% for i =1:r
%     if flag ==0
%         for j=1:c
%             if img_(i,j) == img(1,1)
%                %  fprintf( " %d,%d",i,j);  
%                 % 找到第一个像素点在当前矩阵中的位置
%                 cut_r=i;
%                 cut_c=j;
%                 flag=1;
%                 break;
%             end
%         end
%     else 
%         break;
%     end
% end
% % 对旋转回原位的图像进行裁剪 
% img_ =img_(36:167,34:168);
% imshow(img_);
% subtract_img_img_ = img - img_;
% 
% subplot(131);
% imshow(img);
% title(' 原图 ','fontSize',18);
% 
% subplot(132);
% imshow(img_15);
% title(' 顺时针转15度 ','fontSize',18);
% 
% subplot(133);
% imshow(img_);
% title(' 顺时针转回原位 ','fontSize',18);
% 
% mean ( mean(img_) )
% mean ( mean(img)  )
% 
% figure();
% imhist(img_);
% title(' 旋转后 ','fontSize',18);
% 
% figure()
% imhist(img);
% title(' 原图 ','fontSize',18);
% 
% figure();
% imshow(subtract_img_img_);
% title(' 原图减去旋转后图像 ','fontSize',18);
