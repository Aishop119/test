clc;clear;
img  = imread('Chapter2_1.pgm');

% ���ڽ� 
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
                % �ҵ���һ�����ص��ڵ�ǰ�����е�λ��
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

% ����ת��ԭλ��ͼ����вü� 
img_ =img_(cut_r:166,cut_c:168);
imshow(img_);
subtract_img_img_ = img - img_;

subplot(131);
imshow(img);
title(' ԭͼ ','fontSize',18);

subplot(132);
imshow(img_15);
title(' ˳ʱ��ת15�� ','fontSize',18);

subplot(133);
imshow(img_);
title(' ˳ʱ��ת��ԭλ ','fontSize',18);
figure();
imshow(subtract_img_img_);
title(' ԭͼ��ȥ��ת��ͼ�� ','fontSize',18);
mean ( mean(img_) )
mean ( mean(img)  )

figure();
imhist(img_);
title(' ��ת�� ','fontSize',18);

figure()
imhist(img);
title(' ԭͼ ','fontSize',18);


% % ���ڽ� 
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
%                 % �ҵ���һ�����ص��ڵ�ǰ�����е�λ��
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
% % ����ת��ԭλ��ͼ����вü� 
% img_ =img_(36:167,34:168);
% imshow(img_);
% subtract_img_img_ = img - img_;
% 
% subplot(131);
% imshow(img);
% title(' ԭͼ ','fontSize',18);
% 
% subplot(132);
% imshow(img_15);
% title(' ˳ʱ��ת15�� ','fontSize',18);
% 
% subplot(133);
% imshow(img_);
% title(' ˳ʱ��ת��ԭλ ','fontSize',18);
% 
% mean ( mean(img_) )
% mean ( mean(img)  )
% 
% figure();
% imhist(img_);
% title(' ��ת�� ','fontSize',18);
% 
% figure()
% imhist(img);
% title(' ԭͼ ','fontSize',18);
% 
% figure();
% imshow(subtract_img_img_);
% title(' ԭͼ��ȥ��ת��ͼ�� ','fontSize',18);
