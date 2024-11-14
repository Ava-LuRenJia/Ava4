function hist_values = my_imhist(img)
% 初始化灰度值直方图数组，256 个灰度级
hist_values = zeros(1, 256);
% 统计每个灰度级的像素数量
for i = 0:255
hist_values(i + 1) = sum(img(:) == i);
   end
end


% 读取图像
img = imread('C:\Users\Ava\Desktop\TuXiang\iris.tif');

% 显示原始图像
figure;
imshow(img);
title('原始图像');

% 使用 my_imhist 或 imhist 函数显示直方图
hist_values = my_imhist(img);  % 自定义函数
% 或使用 MATLAB 的内置 imhist 函数
% hist_values = imhist(img);

% 显示直方图
figure;
bar(0:255, hist_values, 'k');
title('灰度直方图');
xlabel('灰度值');
ylabel('像素数量');

% 手动选择一个阈值
threshold = 50; % 根据直方图手动选择一个合适的阈值（可调整）

% 阈值分割
binary_img = img < threshold;

% 显示二值化结果
figure;
imshow(binary_img);
title('阈值分割后的二值化图像');

% 提取瞳孔区域的属性
stats = regionprops(binary_img, 'Area', 'Centroid');
[~, max_idx] = max([stats.Area]);  % 找到面积最大的连通区域

% 获取瞳孔区域的面积
pupil_area = stats(max_idx).Area;

% 计算瞳孔半径（假设为圆形区域）
pupil_radius = sqrt(pupil_area / pi);

% 显示估算的半径
disp(['瞳孔半径（以像素为单位）: ', num2str(pupil_radius)]);

% 在二值化图像中显示瞳孔区域
figure;
imshow(binary_img);
hold on;
viscircles(stats(max_idx).Centroid, pupil_radius, 'EdgeColor', 'r');
title('瞳孔区域及估算的半径');
hold off;
