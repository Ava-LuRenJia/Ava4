% 读取图像
img = imread('C:\Users\Ava\Desktop\TuXiang\wire.bmp'); % 加载图像

% 显示原始图像
figure;
subplot(2, 3, 1);
imshow(img);
title('原始二值图像');

% 1. 使用 Roberts 边缘检测算子
roberts_h = [-1 0; 0 1]; % Roberts 水平算子
roberts_v = [0 -1; 1 0]; % Roberts 垂直算子

edge_roberts_h = imfilter(double(img), roberts_h);
edge_roberts_v = imfilter(double(img), roberts_v);

% 将结果合并为边缘检测的总结果
edge_roberts = sqrt(edge_roberts_h.^2 + edge_roberts_v.^2);
edge_roberts = edge_roberts > 0.1; % 二值化

subplot(2, 3, 2);
imshow(edge_roberts);
title('Roberts 边缘检测');

% 2. 使用 Prewitt 边缘检测算子
prewitt_h = [-1 0 1; -1 0 1; -1 0 1]; % Prewitt 水平算子
prewitt_v = [-1 -1 -1; 0 0 0; 1 1 1]; % Prewitt 垂直算子

edge_prewitt_h = imfilter(double(img), prewitt_h);
edge_prewitt_v = imfilter(double(img), prewitt_v);

% 将结果合并为边缘检测的总结果
edge_prewitt = sqrt(edge_prewitt_h.^2 + edge_prewitt_v.^2);
edge_prewitt = edge_prewitt > 0.1; % 二值化

subplot(2, 3, 3);
imshow(edge_prewitt);
title('Prewitt 边缘检测');

% 3. 使用 Sobel 边缘检测算子
sobel_h = [-1 0 1; -2 0 2; -1 0 1]; % Sobel 水平算子
sobel_v = [-1 -2 -1; 0 0 0; 1 2 1]; % Sobel 垂直算子

edge_sobel_h = imfilter(double(img), sobel_h);
edge_sobel_v = imfilter(double(img), sobel_v);

% 将结果合并为边缘检测的总结果
edge_sobel = sqrt(edge_sobel_h.^2 + edge_sobel_v.^2);
edge_sobel = edge_sobel > 0.1; % 二值化

subplot(2, 3, 4);
imshow(edge_sobel);
title('Sobel 边缘检测');

% 4. 添加噪声
img_noise = imnoise(img, 'salt & pepper', 0.02); % 添加椒盐噪声

% 显示带噪声的图像
subplot(2, 3, 5);
imshow(img_noise);
title('添加椒盐噪声');

% 5. 对噪声图像进行边缘检测
edge_roberts_noise_h = imfilter(double(img_noise), roberts_h);
edge_roberts_noise_v = imfilter(double(img_noise), roberts_v);
edge_roberts_noise = sqrt(edge_roberts_noise_h.^2 + edge_roberts_noise_v.^2);
edge_roberts_noise = edge_roberts_noise > 0.1; % 二值化

edge_prewitt_noise_h = imfilter(double(img_noise), prewitt_h);
edge_prewitt_noise_v = imfilter(double(img_noise), prewitt_v);
edge_prewitt_noise = sqrt(edge_prewitt_noise_h.^2 + edge_prewitt_noise_v.^2);
edge_prewitt_noise = edge_prewitt_noise > 0.1; % 二值化

edge_sobel_noise_h = imfilter(double(img_noise), sobel_h);
edge_sobel_noise_v = imfilter(double(img_noise), sobel_v);
edge_sobel_noise = sqrt(edge_sobel_noise_h.^2 + edge_sobel_noise_v.^2);
edge_sobel_noise = edge_sobel_noise > 0.1; % 二值化

% 显示噪声后的边缘检测结果
subplot(2, 3, 6);
imshow(edge_sobel_noise); % 展示 Sobel 对噪声的响应
title('Sobel 边缘检测 (噪声)');
