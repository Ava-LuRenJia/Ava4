% 原始图像
img_gray = imread('C:\Users\Ava\Desktop\TuXiang\coins.png');
% 显示原始图像
figure; imshow(img_gray); title('原始图像');

% 进行傅里叶变换
F = fft2(img_gray);
F_shifted = fftshift(F);  % 将零频率分量移到频谱中心

% 计算频谱的幅度和对数尺度显示
magnitude_spectrum = log(1 + abs(F_shifted));

% 显示傅里叶变换的频谱
figure;
imshow(magnitude_spectrum, []);
title('傅里叶变换频谱');

% 滤波器设计：理想低通和巴特沃斯低通
[rows, cols] = size(img_gray);
u = 0:(rows-1);
v = 0:(cols-1);
idx = find(u > rows/2); u(idx) = u(idx) - rows;
idy = find(v > cols/2); v(idy) = v(idy) - cols;
[U, V] = meshgrid(v, u);

D0 = 30;  % 截止频率
H_ideal = double(sqrt(U.^2 + V.^2) <= D0);  % 理想低通
n = 2;  % 巴特沃斯低通的阶数
H_butterworth = 1 ./ (1 + (sqrt(U.^2 + V.^2) / D0).^(2 * n));

% 应用滤波器并进行逆傅里叶变换
F_ideal = F_shifted .* H_ideal;
f_ideal = ifft2(ifftshift(F_ideal));
f_ideal = abs(f_ideal);
figure; imshow(f_ideal, []); title('理想低通滤波后图像');

F_butterworth = F_shifted .* H_butterworth;
f_butterworth = ifft2(ifftshift(F_butterworth));
f_butterworth = abs(f_butterworth);
figure; imshow(f_butterworth, []); title('巴特沃斯低通滤波后图像');
