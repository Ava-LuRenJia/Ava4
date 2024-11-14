% 读取图像
gray_image = imread('C:\Users\Ava\Desktop\TuXiang\coins.png'); % 假设图像名为 coins.png

% 转换为浮动型
gray_image = double(gray_image);

% 计算图像的二维傅里叶变换
F = fft2(gray_image);
F_shifted = fftshift(F); % 将低频移到频谱中心
magnitude_spectrum = log(1 + abs(F_shifted)); % 计算幅度谱

% 显示原始图像和其频谱
figure;
subplot(2,2,1);
imshow(gray_image, []);
title('Original Image');

subplot(2,2,2);
imshow(magnitude_spectrum, []);
title('Magnitude Spectrum');

% 创建高通滤波器函数
% 理想高通滤波器
function H_ideal = ideal_high_pass_filter(M, N, cutoff)
    [U, V] = meshgrid(1:N, 1:M);
    D = sqrt((U - N/2).^2 + (V - M/2).^2);
    H_ideal = double(D > cutoff); % 低于cutoff的频率设置为0
end

% 巴特沃斯高通滤波器
function H_butter = butterworth_high_pass_filter(M, N, cutoff, n)
    [U, V] = meshgrid(1:N, 1:M);
    D = sqrt((U - N/2).^2 + (V - M/2).^2);
    H_butter = 1 ./ (1 + (cutoff ./ D).^(2 * n)); % 2次巴特沃斯滤波器
    H_butter(D == 0) = 0; % 防止除以零
end

% 指数高通滤波器
function H_exp = exponential_high_pass_filter(M, N, cutoff)
    [U, V] = meshgrid(1:N, 1:M);
    D = sqrt((U - N/2).^2 + (V - M/2).^2);
    H_exp = exp(-(D.^2) / (2 * (cutoff^2))); % 指数滤波器
    H_exp = 1 - H_exp; % 高通滤波器是1减去低通部分
end

% 设置滤波器参数
[M, N] = size(gray_image); % 获取图像尺寸
cutoff = 30; % 截止频率
n = 2; % 巴特沃斯滤波器的阶数

% 生成不同类型的高通滤波器
H_ideal = ideal_high_pass_filter(M, N, cutoff);
H_butter = butterworth_high_pass_filter(M, N, cutoff, n);
H_exp = exponential_high_pass_filter(M, N, cutoff);

% 频域处理：应用高通滤波器
F_ideal = F_shifted .* H_ideal;
F_butter = F_shifted .* H_butter;
F_exp = F_shifted .* H_exp;

% 逆傅里叶变换得到锐化后的图像
image_ideal = ifft2(ifftshift(F_ideal));
image_butter = ifft2(ifftshift(F_butter));
image_exp = ifft2(ifftshift(F_exp));

% 显示处理后的图像
subplot(2,2,3);
imshow(abs(image_ideal), []);
title('Ideal High Pass Filtered Image');

subplot(2,2,4);
imshow(abs(image_butter), []);
title('Butterworth High Pass Filtered Image');

% 对比不同滤波器的效果
figure;
subplot(1,3,1);
imshow(abs(image_ideal), []);
title('Ideal Filter Result');

subplot(1,3,2);
imshow(abs(image_butter), []);
title('Butterworth Filter Result');

subplot(1,3,3);
imshow(abs(image_exp), []);
title('Exponential Filter Result');
