path = 'Chapter3_1.pgm';
im = imread(path);
sigma=2.8;
N=5;
%matlab卷积核
stemplate = fspecial('log',N,sigma);
%自行实现的卷积核
template=zeros(N,N);

for i=1:N
    for j=1:N
        x=i-(N+1)/2;
        y=j-(N+1)/2;
        template(i,j)=((x^2+y^2-2*sigma^2)/(sigma^4))*exp(-(x^2+y^2)/(2*sigma^2));
    end
end
template = template - sum(template(:))/numel(template);



figure();

Im=double(im);
size(Im,1);
%加边缘
Im0=zeros(size(Im,1)+N-1,size(Im,2)+N-1);
frame=(N-1)/2;
for i=1+frame:size(Im,1)+frame
    for j=1+frame:size(Im,2)+frame
        Im0(i,j)=Im(i-frame,j-frame);
    end
end
%卷积过程
Im1=zeros(size(Im0,1),size(Im0,2));
for i=1+frame:size(Im0,1)-frame
    for j=1+frame:size(Im0,2)-frame
        temp=0;
        for k=1:N
            for l=1:N
                temp=temp+template(k,l)*Im0(i+k-frame-1,j+l-frame-1);
            end
        end
        Im1(i,j)=temp;
    end
end
% Im1=Im1>40;
Im2=zeros(size(Im0,1),size(Im0,2));
for i=1+frame:size(Im0,1)-frame
    for j=1+frame:size(Im0,2)-frame
        if (abs(Im1(i,j))<abs(Im1(i+1,j))&&abs(Im1(i,j))<abs(Im1(i-1,j))&&Im1(i-1,j)*Im1(i+1,j)<=0 )
            Im2(i,j)=255;
             continue
        end
        if (abs(Im1(i,j))<abs(Im1(1,j+1))&&abs(Im1(i,j))<abs(Im1(i,j-1))&&Im1(i,j-1)*Im1(i,j+1)<=0 )
            Im2(i,j)=255;
            continue
        end
        if (abs(Im1(i,j))<abs(Im1(i+1,j+1))&&abs(Im1(i,j))<abs(Im1(i-1,j-1))&&Im1(i-1,j-1)*Im1(i+1,j+1)<=0 )
            Im2(i,j)=255;
             continue
        end
        if (abs(Im1(i,j))<abs(Im1(i+1,j-1))&&abs(Im1(i,j))<abs(Im1(i-1,j+1))&&Im1(i-1,j+1)*Im1(i+1,j-1)<=0 )
            Im2(i,j)=255;
             continue
        end       
    end
end
imshow(Im2);








% sigma=1;
% syms x y
% z=((x^2+y^2-2*sigma^2)/(sigma^4))*exp(-(x^2+y^2)/(2*sigma^2));
% ezsurf(z,[-4 4 -4 4],101)
% log_1 = edge(im,'log',0,1.2); 
% log_2 = edge(im,'log',0,2.8); 
% figure()
% subplot(221)
% imshow(im);
% title('原图像')
% subplot(222)
% imshow(log_1);
% title('方差为1.2')
% subplot(223)
% imshow(log_2);
% title('方差为2.8')
% open edge
% figure();
% imshow(im)
