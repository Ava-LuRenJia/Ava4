% 读取彩色图像
img = imread('C:\Users\Ava\Desktop\TuXiang\pears.png');

% 将图像转换为灰度图
grayImg = rgb2gray(img);

% 使用 Canny 边缘检测获取边缘图像
edges = edge(grayImg, 'Canny');

% 将边缘图像反相，使其成为白底黑线条
invertedEdges = imcomplement(edges);

% 将边缘图像与原始灰度图像结合，模拟素描效果
sketchEffect = uint8(double(grayImg) .* double(invertedEdges));

% 显示结果
imshow(sketchEffect);
title('Sketch-like Effect');
