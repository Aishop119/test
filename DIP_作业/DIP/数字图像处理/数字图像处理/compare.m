function [output] = compare(img1,img2)

[h , w] = size(img1);
B=8;                %编码一个像素用多少二进制位
MAX=2^B-1;          %图像有多少灰度级
MES=sum(sum((img1-img2).^2))/(h*w);     %均方差
PSNR=20*log10(MAX/sqrt(MES));

output = PSNR;

end

