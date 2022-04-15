function [output] = compare(img1,img2)

[h , w] = size(img1);
B=8;                %����һ�������ö��ٶ�����λ
MAX=2^B-1;          %ͼ���ж��ٻҶȼ�
MES=sum(sum((img1-img2).^2))/(h*w);     %������
PSNR=20*log10(MAX/sqrt(MES));

output = PSNR;

end

