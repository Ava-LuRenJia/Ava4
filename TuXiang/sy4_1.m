function [h,l] = huffman(p)
    % p: 输入的概率向量，表示每个符号的出现概率

    % 检查输入概率向量是否合法
    if (length(find(p<0)) ~= 0)
        error('Not a probability, negative component');
    end
    if (abs(sum(p) - 1) > 10e-10)
        error('Not a probability vector, components do not add to 1');
    end
    
    % n: 符号的数量
    n = length(p);
    q = p; % 初始化q为输入概率向量
    m = zeros(n-1, n); % 用来记录合并的符号的索引
    for i = 1:n-1
        [q, l] = sort(q); % 将概率向量从小到大排序
        m(i, :) = [l(1:n-i+1), zeros(1, i-1)]; % 记录合并顺序
        q = [q(1) + q(2), q(3:n), 1]; % 将最小两个符号合并
    end
    
    % 初始化编码矩阵
    for i = 1:n-1
        c(i, :) = blanks(n * n);
    end
    c(n-1, n) = '0'; % 左子树编码
    c(n-1, 2 * n) = '1'; % 右子树编码
    
    % 构建霍夫曼编码
    for i = 2:n-1
        c(n-i, 1:n-1) = c(n-i+1, n * (find(m(n-i+1, :) == 1)) - (n-2):n * (find(m(n-i+1, :) == 1)));
        c(n-i, n) = '0';
        c(n-i, n+1:2*n-1) = c(n-i, 1:n-1);
        c(n-i, 2 * n) = '1';
        
        for j = 1:i-1
            c(n-i, (j+1) * n+1:(j+2) * n) = c(n-i+1, n * (find(m(n-i+1, :) == j+1)-1)+1:n * find(m(n-i+1, :) == j+1));
        end
    end
    
    % 为每个符号生成霍夫曼编码
    for i = 1:n
        h(i, 1:n) = c(1, n * (find(m(1, :) == i) - 1) + 1:find(m(1, :) == i) * n);
        ll(i) = length(find(h(i, :) ~= ' ')); % 计算编码的长度
    end
    
    % 计算编码效率（加权平均编码长度）
    l = sum(p .* ll);
end



