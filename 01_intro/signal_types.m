%% EE-359 DSP Lab 01 - Introduction to DSP
%% Code 01 - Types of Signals

%% SETUP
% defining start and stop times for signal domain
t_start = 0; t_end = 1;

% creating linearly spaced, semi-continuous domain for ct signals
t = linspace( t_start, t_end, 1000 );
F = 5;                                 % frequency of ctcv signal
Fs = 20;                                % sampling frequency
acc = 0.1;                              % quantization accuracy
n = 0:1:Fs;
ctcv = sin( 2 * pi * F * t );           % Continuous time + value
dtcv = sin( 2 * pi * (F/Fs) * n );  % discrete time, continuous value
ctdv = round( ctcv / acc ) * acc;       % continuous time, discrete value
dtdv = round( dtcv / acc ) * acc;       % discrete time, discrete value

%% PLOTTING
subplot( 2, 2, 1 ); plot( t, ctcv );
subplot( 2, 2, 2 ); plot( t, ctdv );
subplot( 2, 2, 3 ); stem( n/Fs, dtcv );
subplot( 2, 2, 4 ); stem( n/Fs, dtdv );