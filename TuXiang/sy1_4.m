I = imread('C:\Users\Administrator\Desktop\lena512.jpg'); % 假设 lena512.jpg 是灰度图像
if size(I, 3) == 3
I = rgb2gray(I); % 如果图像是彩色的，则将其转换为灰度
end

% 创建图像显示窗口
figure;
subplot(2, 3, 1);
imshow(I);
title('原图像');

% 定义初始灰度级
levels = 256;

% 循环5次，每次灰度级减半并显示图像
for m = 1:5
% 计算新的灰度级（减半）
levels = levels / 2;

% 按照新的灰度级缩减图像
% 将图像的每个像素值映射到新的灰度级范围
reduced_image = floor(double(I) / 256 * levels) * (256 / levels);

% 显示灰度减半后的图像
subplot(2, 3, m + 1);
imshow(uint8(reduced_image));
title(['灰度级：', num2str(levels)]);
End