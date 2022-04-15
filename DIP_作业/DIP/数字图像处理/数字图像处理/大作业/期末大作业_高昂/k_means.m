clear all;close all ;clc;
G=imread('MRA.pgm');
[mu, pred ] =kmeans(G,2);
figure()
subplot(121)
imshow(G);
subplot(122)
imshow(pred);
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

function [mu,mask]=kmeans(ima,k)
%���ܡ�������K-means�㷨��ͼ����зָ�
% ���� ima-����ĻҶ�ͼ�� K-������
%��� mu -��ֵ������  mask-������ͼ��
ima=double(ima);
copy=ima;
ima=ima(:); % ��������ƽ
mi=min(ima);%�ҵ�ͼ��Ҷ���Сֵ
ima=ima-mi+1;
s=length(ima);%�ж��ٻҶȼ�
%����ͼ��Ҷ�ֱ��ͼ
m=max(ima)+1;%ͼ�����Ҷ�ֵ
h=zeros(1,m);
hc=zeros(1,m);
for i=1:s
    if  (ima(i)>0)
        h(ima(i))=h(ima(i))+1;%�Ҷ�ֵi�ۼ�
    end
    
end
ind =find(h);
h1=length(ind);
%��ʼ������
mu=(1:k)*m/(k+1);
%start process
while(true)
    oldmu=mu;
    %���еķ��ࡤ
    for i=1:h1
        c=abs(ind(i)-mu);
        cc=find(c==min(c));
        hc(ind(i))=cc(1);
    end
    %���¼����ֵ
    for i=1:k
        a=find(hc==i);
        mu(i)=sum(a.*h(a))/sum(h(a));
    end
    if(mu==oldmu) 
        break;
    end
end
    %�������ɷ�����ͼ��
s=size(copy);
mask=zeros(s);
for i=1:s(1)
    for j=1:s(2)
        c=abs(copy(i,j)-mu);
        a=find(c==min(c));
        mask(i,j)=a(1);
    end
end
mu=mu+mi-1;mask = mask - 1; % ����Ϊ ��ֵͼ
end