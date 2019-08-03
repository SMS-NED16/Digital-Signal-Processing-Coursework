clear all;
clc;
close all;
Ts = 0.001; %sampling period - so small to approximate   cont time
Tp = 2; % Time Period of the signal
t = [0:Ts:Tp-Ts]; % Time Vector - again approx. continuous(one cycle)
x =sin(2*pi*1/Tp*t)+sin(2*pi*2/Tp*t)+ 5*cos(2*pi*8/Tp*t)+ 5; % Generating Square wave
figure,
plot(t,x);
xlabel('secs');
Fo = 1/Tp; % Fundamental Frequency
% Computing CTFS Coefficients 
for k = 1:20
B = exp(-j*2*pi*(k-1)*Fo.*t);
C(k) = sum(x.*B)/(length(x));
end
k = [0:k-1]; % Frequency Scale in Hz.
figure,
stem(k,abs(C));
title('CTFS Coefficients');
xlabel('K');