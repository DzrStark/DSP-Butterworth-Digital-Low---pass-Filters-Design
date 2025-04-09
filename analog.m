clear;clc;
fp = 4e3;  % 通带频率
fs = 20e3; % 阻带频率
Ap = 0.5;  % 通带最大衰减
As = 45;   % 阻带最小衰减
Fs = 80e3; % 采样频率
T=1/Fs;

% 设计模拟巴特沃斯低通滤波器
Wp = 2*pi*fp; % 通带频率转换为弧度频率
Ws = 2*pi*fs; % 阻带频率转换为弧度频率

% 计算模拟滤波器的阶数和截止频率
[N, Wc] = buttord(Wp, Ws, Ap, As, 's'); 

% 使用 butter 设计模拟低通滤波器
[b, a] = butter(N, Wc, 's');

disp('模拟低通滤波器的系统函数 H(s) 的系数：');
disp('b = '); disp(b);
disp('a = '); disp(a);

k=0:1023;
fk=0:40000/1024:40000;
wk=2*pi*fk;

% 计算模拟滤波器的频率响应
H = freqs(b, a, wk); 
magnitude = 20 * log10(abs(H));

% 绘制幅频特性
figure;
grid on;
plot(fk/1000,magnitude);grid on
title('模拟低通滤波器的幅频特性');
xlabel('频率 (kHz)');
ylabel('幅度 (dB)');

69.0483-63.4986
