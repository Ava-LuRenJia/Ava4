clear all;close all;
I=imread('C:\Users\Ava\Desktop\TuXiang\lena512.jpg');
[height,width]=size(I);
figure;
subplot(2,3,1);
imshow(I);
title('原图像');
L=1;
for m=1:5
L=2*L;
quartimage=I(1:L:height,1:L:width);
subplot(2,3,m+1);
imshow(uint8(quartimage));
end