function edge_image = my_edge(method, T)
    % 读取灰度图像并转换为双精度类型
    I = imread('C:\Users\Ava\Desktop\TuXiang\wire.bmp'); % 根据需要加载图像文件
    
    % 根据选择的算子，进行梯度运算
    switch method
        case 'Roberts'
            % Roberts 算子
            Gx = [1 0; 0 -1]; 
            Gy = [0 1; -1 0];
            
        case 'Prewitt'
            % Prewitt 算子
            Gx = [-1 0 1; -1 0 1; -1 0 1]; 
            Gy = [-1 -1 -1; 0 0 0; 1 1 1];
            
        case 'Sobel'
            % Sobel 算子
            Gx = [-1 0 1; -2 0 2; -1 0 1];
            Gy = [-1 -2 -1; 0 0 0; 1 2 1];
            
        otherwise
            error('Unknown method: %s', method);
    end
    
    % 计算梯度图像
    Ix = conv2(I, Gx, 'same');  % 水平梯度
    Iy = conv2(I, Gy, 'same');  % 垂直梯度
    
    % 计算梯度幅值
    grad_mag = sqrt(Ix.^2 + Iy.^2);
    
    % 获取梯度幅值的最大值和最小值
    grad_min = min(grad_mag(:));
    grad_max = max(grad_mag(:));
    fprintf('Gradient Min: %.2f, Gradient Max: %.2f\n', grad_min, grad_max);

    % 将梯度幅值归一化到 [0, 1] 范围
    grad_norm = (grad_mag - grad_min) / (grad_max - grad_min);

    % 将归一化后的梯度幅值与阈值进行比较，生成二值图像
    edge_image = grad_norm >= T;

    % 显示结果
    figure;
    imshow(edge_image);
    title(['Edge Detection using ', method, ' with T = ', num2str(T)]);
end

% 主程序
% 选择阈值（可以调节）
T = 0.2;  % 设置阈值在 [0, 1] 范围内

% 测试 Roberts 边缘检测
my_edge('Roberts', T);

% 测试 Prewitt 边缘检测
my_edge('Prewitt', T);

% 测试 Sobel 边缘检测
my_edge('Sobel', T);
