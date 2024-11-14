function hist_values = my_imhist(img)
    % 初始化灰度值直方图数组，256 个灰度级
    hist_values = zeros(1, 256);
    
    % 统计每个灰度级的像素数量
    for i = 0:255
        hist_values(i + 1) = sum(img(:) == i);
    end
end
% 读取图像
img = imread('C:\Users\Ava\Desktop\TuXiang\bottle.tif');

% 调用自定义的直方图统计函数
my_hist = my_imhist(img);

% 使用 MATLAB 的内置 imhist 函数
matlab_hist = imhist(img);

% 绘制直方图进行比较
figure;
subplot(1, 2, 1);
bar(0:255, my_hist, 'k');
title('自定义函数 my\_imhist 结果');
xlabel('灰度值');
ylabel('像素数量');

subplot(1, 2, 2);
bar(0:255, matlab_hist, 'k');
title('MATLAB 函数 imhist 结果');
xlabel('灰度值');
ylabel('像素数量');
