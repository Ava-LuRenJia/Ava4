clear;
org = imread('C:\Users\Administrator\Desktop\sunset.jpg');
subplot(1,3,1);
imshow(org);

gray = rgb2gray(org);
subplot(1,3,2);
imshow(gray);

bw = im2bw(org,0.5);
subplot(1,3,3);
imshow(bw);