% 算术编码和解码脚本

% 算术编码函数
function arcode = arenc(symbol, pr, seqin)
    % 计算每个符号的高、低区间
    high_range = [];
    for k = 1:length(pr)
        high_range = [high_range sum(pr(1:k))];
    end
    low_range = [0 high_range(1:length(pr)-1)];

    % 查找符号在符号集中的索引
    sbidx = zeros(size(seqin));
    for i = 1:length(seqin)
        sbidx(i) = find(symbol == seqin(i));
    end

    % 初始化编码区间
    low = 0; 
    high = 1;

    % 遍历输入消息字符进行编码
    for i = 1:length(seqin)
        range = high - low;
        high = low + range * high_range(sbidx(i));
        low = low + range * low_range(sbidx(i));
    end

    % 生成编码的二进制表示
    M = 20; % 二进制位数
    lable = zeros(1, M); 
    number = 0;

    for i = 1:M
        if number >= low && number < high
            break;
        else
            number1 = number + (0.5)^i;
            number2 = number + 0;
        end
        if number1 <= high
            number = number1; 
            lable(i) = 1;
        else
            number = number2; 
            lable(i) = 0;
        end
    end
    arcode = lable(1:i-1); % 最终编码值
end

% 算术解码函数
function symseq = ardec(symbol, pr, codestring, symlen)
    % 将二进制码串转为数字
    codeword = 0;
    for i = 1:length(codestring)
        codeword = codeword + codestring(i) * (2^(-i));
    end

    % 计算每个符号的高、低区间
    high_range = [];
    for k = 1:length(pr)
        high_range = [high_range sum(pr(1:k))];
    end
    low_range = [0 high_range(1:length(pr)-1)];
    
    % 最小概率用于停止判断
    prmin = min(pr);
    symseq = [];

    % 解码过程
    for i = 1:symlen
        idx = max(find(low_range <= codeword));
        codeword = codeword - low_range(idx);
        if abs(codeword - pr(idx)) < 0.01 * prmin
            idx = idx + 1;
            codeword = 0;
        end
        symseq = [symseq symbol(idx)];
        codeword = codeword / pr(idx);
        if abs(codeword) < 0.01 * prmin
            break;
        end
    end
end

% 主程序
% 定义符号集和概率
symbol = ['a', 'b', 'c', 'd'];
pr = [0.1, 0.4, 0.2, 0.3];

% 待编码的消息
seqin = 'badbdbc';

% 调用算术编码
arcode = arenc(symbol, pr, seqin);

% 输出编码结果
disp('编码结果:');
disp(arcode);

% 假设编码结果长度为20，调用解码函数
symlen = length(seqin);
symseq = ardec(symbol, pr, arcode, symlen);

% 输出解码结果
disp('解码结果:');
disp(symseq);
