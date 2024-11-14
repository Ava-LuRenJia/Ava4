% 读取图像
img = imread('C:\Users\Ava\Desktop\TuXiang\pout.tif');

% 将图像转换为 double 类型以便数学处理
img_double = double(img);

% 自定义直方图均衡化函数
function eq_img = my_histeq(img)
    % 获取图像的大小
    [rows, cols] = size(img);
    
    % 计算图像的直方图
    histogram = zeros(1, 256);
    for i = 1:rows
        for j = 1:cols
            pixel_value = img(i, j) + 1; % 灰度值从1到256
            histogram(pixel_value) = histogram(pixel_value) + 1;
        end
    end
    
    % 计算累积分布函数 (CDF)
    cdf = cumsum(histogram) / (rows * cols);
    
    % 根据累积分布函数映射新的灰度值
    eq_img = uint8(255 * cdf(img + 1)); % CDF映射后的图像
end

% 使用自定义函数进行直方图均衡化
eq_img_custom = my_histeq(img);

% 使用 MATLAB 的内置函数 histeq 进行直方图均衡化
eq_img_matlab = histeq(img);

% 显示结果
figure;

% 原始图像
subplot(2, 3, 1);
imshow(img);
title('原始图像');

% 使用自定义函数均衡化的图像
subplot(2, 3, 2);
imshow(eq_img_custom);
title('自定义均衡化图像');

% 使用 MATLAB 函数均衡化的图像
subplot(2, 3, 3);
imshow(eq_img_matlab);
title('MATLAB histeq 图像');

% 原始图像的灰度直方图
subplot(2, 3, 4);
imhist(img);
title('原始图像直方图');

% 自定义均衡化后图像的灰度直方图
subplot(2, 3, 5);
imhist(eq_img_custom);
title('自定义均衡化直方图');

% MATLAB 函数均衡化后图像的灰度直方图
subplot(2, 3, 6);
imhist(eq_img_matlab);
title('MATLAB histeq 直方图');
