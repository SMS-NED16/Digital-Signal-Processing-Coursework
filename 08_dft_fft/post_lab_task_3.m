%% EE-394 Digital Signal Processing - Post Lab Task 08
%  Saad Siddiqui, EE-16163, Section D, TE-EE, Fall '18

Fs = 10e3;                  % Sampling frequency - 10 kHz
Ts = 1 / Fs;                % Sampling interval in seconds
N = 10;                     % Number of frequency components in DFT spectrum
n = 0 : 1 : N - 1;          % Index values for DT signal
X_K = zeros( 1, N );        % Array to store DFT results
K = 0 : 1 : N - 1;          % Index values for DFT Frequency spectrum

% Creating a sampled signal
x_n = sin( 2 * pi * 1000 * n * Ts ) + sin( 2 * pi * 3000 * n * Ts ) + ...
    cos( 2 * pi * 0 * n * Ts ) + cos( 2 * pi * 2000 * n * Ts );

% Plotting the sampled version of the x
figure; stem( n, x_n, 'black' ); grid; 
xlabel( '\it{Sample Index (n/arbitary units})') ;
ylabel( 'Signal value (\it{x(n)/arbitrary units})' );
title( { 'Graph of sampled signal x(n)' });

% for every possible value of k 
for var = K
    % multiply each possible value of x(n) with the corresponding value 
    % of e^(-j.2.pi.k.n/N) and sum the result. 
    X_K( var + 1 ) = sum ( x_n .* exp( -1j * 2 * pi * var  * n / N ) );
end

% Plotting the magnitude spectrum
figure; stem( K * Fs / N, abs( X_K ), 'black' ); grid;
title( 'DFT Magnitude Spectrum of x(n)' ); 
xlabel( 'k^{th} frequency - (\it{kf_d/Hz})' );
ylabel( 'Component Magnitude - (\it{|X(k)|/arbitrary units})' );

% Plotting the phase spectrum
figure; stem( K * Fs / N, angle( X_K ), 'black' ); grid;
title( 'DFT Phase Spectrum of x(n)' ); 
xlabel( 'k^{th} frequency - (\it{kf_d/Hz})' );
ylabel( 'Component Phase - (\it{\angleX(k)/radians})' );
