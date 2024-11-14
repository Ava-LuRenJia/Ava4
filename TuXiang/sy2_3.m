% 读取图像
img = imread('C:\Users\Ava\Desktop\TuXiang\bottle.tif');

% 将图像转换为 double 类型，便于数学计算
img_double = double(img);

% 分段线性灰度变换参数
a = 50;    % 区间1的上限
b = 150;   % 区间2的上限
c = 30;    % 区间1的输出灰度上限
d = 200;   % 区间2的输出灰度上限
Mf = 255;  % 输入图像的最大灰度值
Mg = 255;  % 输出图像的最大灰度值

% 初始化分段线性变换的输出图像
linear_transformed_img = zeros(size(img_double));

% 分段线性灰度变换公式实现
for i = 1:size(img_double, 1)
    for j = 1:size(img_double, 2)
        f = img_double(i, j);
        if f >= 0 && f < a
            linear_transformed_img(i, j) = (c / a) * f;
        elseif f >= a && f < b
            linear_transformed_img(i, j) = ((d - c) / (b - a)) * (f - a) + c;
        elseif f >= b && f <= Mf
            linear_transformed_img(i, j) = ((Mg - d) / (Mf - b)) * (f - b) + d;
        end
    end
end

% 转换为 uint8 格式
linear_transformed_img = uint8(linear_transformed_img);

% 非线性灰度变换参数
gamma = 0.5; % gamma 值小于 1 增强暗部细节
c_nonlinear = 1; % 常数系数

% 非线性灰度变换公式
nonlinear_transformed_img = uint8(c_nonlinear * (img_double / 255) .^ gamma * 255);

% 使用 MATLAB 内置的 imadjust 函数进行灰度调整
imadjust_img = imadjust(img);

% 显示结果
figure;

% 显示原始图像
subplot(2, 4, 1);
imshow(img);
title('原始图像');

% 显示分段线性灰度变换后的图像
subplot(2, 4, 2);
imshow(linear_transformed_img);
title('分段线性灰度变换');

% 显示非线性灰度变换后的图像
subplot(2, 4, 3);
imshow(nonlinear_transformed_img);
title('非线性灰度变换');

% 显示 imadjust 函数处理的图像
subplot(2, 4, 4);
imshow(imadjust_img);
title('imadjust 结果');

% 显示原始图像的灰度直方图
subplot(2, 4, 5);
imhist(img);
title('原始图像直方图');

% 显示分段线性灰度变换后的直方图
subplot(2, 4, 6);
imhist(linear_transformed_img);
title('分段线性变换直方图');

% 显示非线性灰度变换后的直方图
subplot(2, 4, 7);
imhist(nonlinear_transformed_img);
title('非线性变换直方图');

% 显示 imadjust 处理后的直方图
subplot(2, 4, 8);
imhist(imadjust_img);
title('imadjust 直方图');
