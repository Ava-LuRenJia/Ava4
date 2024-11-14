clear all; % 清除所有变量
close all; % 关闭所有图形窗口

I = imread('d:\lena512.jpg'); % 读取图片 lena512.jpg，并存储到变量 I 中
[height, width] = size(I); % 获取图片的高度和宽度

figure; % 新建一个图形窗口
subplot(2, 3, 1); % 在图形窗口中创建 2 行 3 列的子图，选择第 1 个位置
imshow(I); % 显示原始图像
title('原图像'); % 为原始图像添加标题“原图像”

L = 1; % 初始化缩放比例 L
for m = 1:5 % 外层循环，进行 5 次缩放
    L = 2 * L; % 每次将 L 倍数增加一倍
    quartimage = zeros(ceil(height / L), ceil(width / L)); % 初始化缩小后的图像矩阵

    k = 1; % 初始化行计数器
    n = 1; % 初始化列计数器

    for i = 1:L:height % 以步长 L 遍历原图像的行
        for j = 1:L:width % 以步长 L 遍历原图像的列
            quartimage(k, n) = I(i, j); % 取原图像中 (i, j) 像素并赋值到新图像的 (k, n) 位置
            n = n + 1; % 列计数器递增
        end
        k = k + 1; % 行计数器递增
        n = 1; % 每次新行开始时，列计数器重置为 1
    end

    subplot(2, 3, m + 1); % 在子图位置 m+1 处显示缩小后的图像
    imshow(uint8(quartimage)); % 显示转换为 8 位无符号整数的 quartimage 图像
end
