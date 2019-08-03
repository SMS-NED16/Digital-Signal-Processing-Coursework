%% EE-394 Digital Signal Processing: Lab 07 - Continous Time Fourier Series
%% Task 1: Spectral Analysis of Square Wave
%% EE-16163, Section D, TE-EE, Fall 2018
%% PART 0 - Closing all figures, clearing workspace, clearing log command
clear all; close all; clc;

%% PART 1A - Defining parameters for square wave
T_s    = 0.001;        % sampling time in seconds
T_p    = 0.2;          % square wave period in seconds
duty   = 0.5;          % duty cycle as fraction - 50 %
f      = 1 / T_p;      % frequency of signal
ampl   = 2;            % amplitude of square wave
F0     = f;            % fundamental frequency for spectral analysis

% Defining time domain
t_start = 0; t_end = 1;
t = t_start : T_s : t_end;

% Defining square wave
sq_wave = ampl * square( 2 * pi * f .* t );
%% PART 1B - Plotting the square wave
figure; plot( t, sq_wave ); grid; 
ylim( [ -3, 3] ); xlabel( 'Time (\it{t/seconds})');
ylabel( 'Signal(\it{x(t)})' );title( 'Task 1 - Square Wave' );

%% PART 2A - Extracting information for one period of signal
period_start = find( round ( t * 1000 ) / 1000 == 0 ) ;   
period_end = find( round ( t * 1000 ) / 1000 == T_p );
period_indices = period_start : period_end;
sq_wave_period = sq_wave( period_indices );
single_period = t( period_indices );

%% PART 2B - Plotting extracted signal
figure; plot( single_period, sq_wave_period );
xlabel( 'Time (\it{t/seconds})' );
ylabel( 'Signal(\it{x(t)})' );
title( 'Task 2a- Single Period of Square Wave' );
margin_x = 0.01; margin_y = 0.1;
xlim( [ single_period( 1 ) - margin_x, single_period( end ) + margin_x ] ); 
ylim( [ min( sq_wave_period ) - margin_y, ...
    max( sq_wave_period ) + margin_y ] ); grid;

%% PART 3A - Computing the Continuous Time Fourier Series Coefficients
fs_time = ( -T_p / 2): T_s : ( T_p / 2 );
num_of_coeffs = 6;

for k = 1 : num_of_coeffs
    % Computing for complex fourier coefficient
    B = exp( -1i * 2 * pi * ( k - 1 ) * F0 .* fs_time );
    
    % Finding specific coefficient through discretised integral
    % Bn = 1/T int( x(t) * e^(-jnwt) ) between -T0/2, T0/2
    % wo = 2piF0t, [-T0/2, T0/2] is just fs_time 
    % Because discrete, fs_time values separated by T_s
    % And integration replaced by summation
    % B is still the complex Fourier coefficient
    % length ( sq_wave_period ) = [-T0/2, T0/2]'s number of elements
    coeff( k ) = ( sum ( sq_wave_period .* B ) ) / ...
        ( length( sq_wave_period ) );
end

%% PART 3B - Plotting Amplitude Spectrum
k =  F0 * ( 0 : num_of_coeffs - 1 );     % Frequency in Hz
coeff_mags = abs( coeff );               % Magnitudes of each component

% Creating text labels for each stem plot to show magnitude
Bn_labels = sprintfc('%.4f', coeff_mags );

% generating plot
figure; stem( k, coeff_mags ); grid;
xlabel( 'Harmonic(\it{kF_0/Hz})' ); ylabel ( 'Component Magnitude -\it{|B_{n}|}' ); 
title ( 'Task 2b - CT Exponential FS Magnitude Spectrum for Square Wave' ) ;
text( k, coeff_mags, Bn_labels, 'HorizontalAlignment', 'Left',...
    'VerticalAlignment', 'Bottom' );