clear;clc;close all;
% 参数设置
Fs = 80e3;  % 采样频率
fp = 4e3;   % 通带边界频率
fs = 20e3;  % 阻带边界频率 
Ap = 0.5;   % 通带最大衰减
As = 45;    % 阻带最小衰减 

Wp = fp / (Fs / 2);  % 通带归一化频率
Ws = fs / (Fs / 2);  % 阻带归一化频率

% 使用 buttord 计算最小阶数和截止频率
[n, Wn] = buttord(Wp, Ws, Ap, As);

% 使用 butter 设计巴特沃斯滤波器
[b, a] = butter(n, Wn);

% 显示数字滤波器的系统函数 H(z) 的系数
disp('直接生成数字滤波器的系统函数 H(z) 的系数：');
disp('b = '); disp(b);
disp('a = '); disp(a);


% 计算频率响应
[H, w] = freqz(b, a, 512);

% 损耗函数（幅频响应）
db = 20 * log10(abs(H));  % 将幅度转换为 dB

% 相位响应 
pha = (angle(H));   % 相位以弧度表示

figure;
% 绘制幅度频率响应
subplot(2, 1, 1); 
plot(w / pi, db);  
axis([0, 1, -80, 10]);  
title('直接生成滤波器的幅度频率响应'); 
xlabel('频率（单位：\pi）');  
ylabel('H(e^{j\omega}) (dB)');  
set(gca, 'XTickMode', 'manual', 'XTick', [0, Wp, Ws, 1]);  
set(gca, 'YTickMode', 'manual', 'YTick', [-60, -20, -3, 0]); 
grid on;  

% 绘制相位频率响应
subplot(2, 1, 2); 
plot(w / pi, pha / pi);  % 将相位频率响应除以π，使其单位为π
axis([0, 1, -1, 1]);  % 设置纵坐标范围为 -1 到 1
title('直接生成滤波器的相位频率响应');  
xlabel('频率（单位：\pi）');  
ylabel('\phi(\omega) / \pi (单位：\pi)');  % 纵坐标单位设置为 \pi
grid on;
