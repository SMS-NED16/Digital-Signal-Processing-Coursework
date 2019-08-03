clear all;
clc;
close all;
Ts = 0.0001; %sampling period - so small to approximate   cont time
t = [-10:Ts:9.999 ]; % Time Vector - again approx. continuous
Tp = 0.2; % Time Period of the signal
tau = 0.5; % Pulse Width - Duty Cycle
x = (2 * square(t*2*pi/Tp,tau*100)); % Generating Square wave
figure,
plot(t,x);
xlabel('secs');
% ylim([-1.2 1.2]);
pause; % Press any key
Fo = 1/Tp; % Fundamental Frequency
% Extracting a portion of the signal equal to its period.
I_period = find(round(t*1000)/1000 == 0) :find(round(t*1000)/1000 == Tp);
xport = x( I_period );
figure,
plot(t(I_period),xport);
xlabel('secs')
% ylim([-1.2 1.2])
pause % Press any key   
% Computing CTFS Coefficients
for k = 1:20
B = exp(-j*2*pi*(k-1)*Fo.*[-Tp/2:Ts:Tp/2]);
C(k) = sum(xport.*B)/(length(xport));
end
k = [0:k-1]; % Frequency Scale in Hz.
figure,
stem(k,abs(C));
title('CTFT Coefficients');
xlabel('K');