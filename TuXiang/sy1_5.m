 % 读取原始灰度图像
I = imread('C:\Users\Administrator\Desktop\orangutan.tif');
if size(I, 3) == 3
I = rgb2gray(I); % 如果图像是彩色的，则将其转换为灰度图像
end

[height, width] = size(I); % 获取原图像的高度和宽度

% 构造拉伸后的图像，目标高度为原图的两倍，宽度不变
new_height = 2 * height;
stretched_image = zeros(new_height, width, 'uint8');

% 填充奇数行：直接复制原图像各行
stretched_image(1:2:end, :) = I;

% 填充偶数行：相邻两行的灰度平均值
for i = 2:2:new_height-1
stretched_image(i, :) = uint8((double(I(i/2, :)) + double(I(i/2 + 1, :))) / 2);
end

% 使用 imresize 函数拉伸图像并调整大小
resized_image = imresize(I, [new_height, width]);

% 显示结果进行比较
figure;
subplot(1, 3, 1);
imshow(I);
title('原始图像');

subplot(1, 3, 2);
imshow(stretched_image);
title('拉伸后的图像 (插值)');

subplot(1, 3, 3);
imshow(resized_image);
title('使用 imresize 函数的结果');

% 将拉伸后的图像存储为文件
imwrite(stretched_image, 'stretched_orangutan.tif');