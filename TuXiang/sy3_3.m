% 读取图像并转为灰度图
image = imread('C:\Users\Ava\Desktop\TuXiang\rice.png');
if ndims(image) == 3
    image = rgb2gray(image);
end
image = im2double(image);

% 添加噪声
noisy_image = imnoise(image, 'gaussian', 0, 0.01);

% 定义Laplacian算子
laplacian_filter = [0 -1 0; -1 4 -1; 0 -1 0];

% 对原始图像和噪声图像进行Laplacian锐化
sharpened_image = image + imfilter(image, laplacian_filter, 'replicate');
sharpened_noisy_image = noisy_image + imfilter(noisy_image, laplacian_filter, 'replicate');

% 显示结果
figure;
subplot(2,2,1); imshow(image); title('Original Image');
subplot(2,2,2); imshow(sharpened_image); title('Sharpened Original');
subplot(2,2,3); imshow(noisy_image); title('Noisy Image');
subplot(2,2,4); imshow(sharpened_noisy_image); title('Sharpened Noisy Image');

%--------------------------------------------------------------------------------------------------%

% 使用高斯滤波去噪
denoised_image = imgaussfilt(noisy_image, 1);

% 对去噪后的图像进行Laplacian锐化
sharpened_denoised_image = denoised_image + imfilter(denoised_image, laplacian_filter, 'replicate');

% 显示去噪后的锐化结果
figure;
subplot(1,3,1); imshow(noisy_image); title('Noisy Image');
subplot(1,3,2); imshow(sharpened_noisy_image); title('Sharpened Noisy Image');
subplot(1,3,3); imshow(sharpened_denoised_image); title('Denoised and Sharpened Image');
