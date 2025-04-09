clear;clc;close all;
% 参数设置
fp = 4e3;  % 通带频率（Hz）
fs = 20e3; % 阻带频率（Hz）
Ap = 0.5;  % 通带最大衰减（dB）
As = 45;   % 阻带最小衰减（dB）
Fs = 80e3; % 采样频率（Hz）
T=1/Fs;

% 设计模拟巴特沃斯低通滤波器
Wp = 2*pi*fp; % 通带频率转换为弧度频率
Ws = 2*pi*fs; % 阻带频率转换为弧度频率

% 计算模拟滤波器的阶数和截止频率
[N, Wc] = buttord(Wp, Ws, Ap, As, 's'); 

% 使用 butter 设计模拟低通滤波器
[b, a] = butter(N, Wc, 's');

% 使用双线性变换法将模拟滤波器转换为数字滤波器
[bz, az] = bilinear(b, a, Fs);  % 通过双线性变换法进行数字化转换

% 显示模拟和数字滤波器的系统函数系数

format long g; 
disp('模拟滤波器的系统函数系数：');
disp('b:'); disp(b);
disp('a:'); disp(a);

disp('双线性变换法数字滤波器的系统函数系数：');
disp('bz:'); disp(bz);
disp('az:'); disp(az);



% 绘制图形
figure;

% 数字频率响应
[H_digi, f_digi] = freqz(bz, az, 1024, Fs); 

% 数字滤波器幅频响应
subplot(2, 1, 1);
plot(f_digi / (Fs / 2), 20*log10(abs(H_digi))); 
axis([0, 1, -80, 10]); 
title('双线性变换法数字低通滤波器幅频响应');
xlabel('频率（单位：\pi）');
ylabel('增益 (dB)');
axis([0, 1, -80, 10]);
grid on;

% 数字滤波器相频响应
subplot(2, 1, 2);
plot(f_digi / (Fs / 2), angle(H_digi) / pi);  % 将相位归一化为π的单位
title('双线性变换法数字低通滤波器相频响应');
xlabel('频率（单位：\pi）');
ylabel('相位 / \pi (单位：\pi)');  % 设置纵坐标单位为 π
axis([0, 1, -1, 1]);  % 设置纵坐标范围为 -1 到 1
grid on;

