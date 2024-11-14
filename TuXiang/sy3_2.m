function output_img = similarGrayKNeighborMean(input_img, K, window_size)
    % 确保图像为双精度类型
    input_img = im2double(input_img);
    [rows, cols] = size(input_img);
    half_window = floor(window_size / 2);
    output_img = zeros(size(input_img));

    % 对每个像素进行处理
    for i = 1:rows
        for j = 1:cols
            % 获取当前像素的邻域
            row_min = max(i - half_window, 1);
            row_max = min(i + half_window, rows);
            col_min = max(j - half_window, 1);
            col_max = min(j + half_window, cols);
            
            % 提取邻域
            window = input_img(row_min:row_max, col_min:col_max);
            center_pixel = input_img(i, j);
            
            % 计算邻域中每个像素与中心像素的灰度差
            diff = abs(window - center_pixel);
            [~, sorted_idx] = sort(diff(:)); % 按灰度差排序
            
            % 确保不超过邻域中的总像素数
            num_neighbors = min(K, numel(sorted_idx));
            nearest_values = window(sorted_idx(1:num_neighbors)); % 取前num_neighbors个灰度差最小的值
            
            % 计算最相近K个邻点的平均值
            output_img(i, j) = mean(nearest_values);
        end
    end
end


% 应用函数来处理图像
% 读取图像
image = imread('C:\Users\Ava\Desktop\TuXiang\rice.png');
% 如果图像是彩色图像，将其转换为灰度图像
if ndims(image) == 3 % 检查是否为彩色图像
    image = rgb2gray(image); % 转为灰度图像
end
image = im2double(image); % 将图像数据转换为double类型

% 添加高斯噪声和椒盐噪声
gaussian_noise_img = imnoise(image, 'gaussian', 0, 0.01);
salt_pepper_noise_img = imnoise(image, 'salt & pepper', 0.05);

% 定义灰度最相近K个邻点平均法的参数
K = 5; % 选择灰度最相近的5个邻点
window_size = 3; % 窗口大小为3×3

% 对噪声图像进行处理
output_gaussian = similarGrayKNeighborMean(gaussian_noise_img, K, window_size);
output_salt_pepper = similarGrayKNeighborMean(salt_pepper_noise_img, K, window_size);

% 显示处理前后的图像
figure;
subplot(2, 3, 1); imshow(gaussian_noise_img); title('Gaussian Noise Image');
subplot(2, 3, 2); imshow(output_gaussian); title('Filtered Gaussian Noise');
subplot(2, 3, 3); imshow(salt_pepper_noise_img); title('Salt & Pepper Noise Image');
subplot(2, 3, 4); imshow(output_salt_pepper); title('Filtered Salt & Pepper Noise');
subplot(2, 3, 5); imshow(image); title('Original Image');
