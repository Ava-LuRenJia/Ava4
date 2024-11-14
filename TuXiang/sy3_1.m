% 读取图像
image = imread('C:\Users\Ava\Desktop\TuXiang\rice.png');
if size(image, 3) == 3
    image = rgb2gray(image); % 转为灰度图像
end
image = im2double(image); % 将图像数据转换为double类型，方便后续操作

% 添加高斯噪声和椒盐噪声
gaussian_noise_img = imnoise(image, 'gaussian', 0, 0.01);
salt_pepper_noise_img = imnoise(image, 'salt & pepper', 0.05);

% 定义滤波窗口大小
window_sizes = [3, 5];

% 初始化存储结果的结构
results = struct();

% 进行滤波
for i = 1:length(window_sizes)
    size = window_sizes(i);
    
    % 邻域平均法
    mean_filtered_gaussian = imfilter(gaussian_noise_img, fspecial('average', size), 'replicate');
    mean_filtered_salt_pepper = imfilter(salt_pepper_noise_img, fspecial('average', size), 'replicate');
    
    % 中值滤波法
    median_filtered_gaussian = medfilt2(gaussian_noise_img, [size size]);
    median_filtered_salt_pepper = medfilt2(salt_pepper_noise_img, [size size]);
    
    % 保存结果
    results.(sprintf('Mean_Gaussian_%dx%d', size, size)) = mean_filtered_gaussian;
    results.(sprintf('Mean_SaltPepper_%dx%d', size, size)) = mean_filtered_salt_pepper;
    results.(sprintf('Median_Gaussian_%dx%d', size, size)) = median_filtered_gaussian;
    results.(sprintf('Median_SaltPepper_%dx%d', size, size)) = median_filtered_salt_pepper;
end

% 图像展示
figure;
subplot(3, 5, 1); imshow(image); title('Original Image');
subplot(3, 5, 2); imshow(gaussian_noise_img); title('Gaussian Noise Image');
subplot(3, 5, 3); imshow(salt_pepper_noise_img); title('Salt & Pepper Noise Image');

% 显示各滤波结果
col = 4;
for noise_type = {'Gaussian', 'SaltPepper'}
    for size = window_sizes
        subplot(3, 5, col); 
        imshow(results.(sprintf('Mean_%s_%dx%d', noise_type{1}, size, size)));
        title(sprintf('Mean %dx%d %s', size, size, noise_type{1}));
        col = col + 1;

        subplot(3, 5, col); 
        imshow(results.(sprintf('Median_%s_%dx%d', noise_type{1}, size, size)));
        title(sprintf('Median %dx%d %s', size, size, noise_type{1}));
        col = col + 1;
    end
end
