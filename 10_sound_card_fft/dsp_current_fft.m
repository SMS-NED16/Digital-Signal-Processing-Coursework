%%  DSP Open-Ended Lab 02 - Task 2: FFT Mangitude Analysis of Current
%   This program reads values of a current waveform that has been stored
%   in the form of an audio file. It uses the recording to perform 
%   frequency analysis of the current waveform using a windowed-FFT

%   Reading current data and sampling frequency from audio file
[ i_data, f_s ] = audioread( 'Current_2.wav' );

%   Calculating the number of current data samples read
n = size( i_data , 1 );      

%   Defining number of points to be used in FFT analysis
win_size = 40e-3 * f_s;         % arbitrary choice, must justify
frame_size = win_size / 2;      % for overlap

%   creating buffer which will divide the entire sample data into chunks,
%   each of which will form its own FFT window - frame size argument
%   determines the level of overlap between consecutive windows
i_buffer = buffer( i_data, win_size, frame_size );

%   Storing number of rows and columns in buffer as counter vars 
[ i_buf_row, i_buf_col ] = size( i_buffer );

%   Defining Hamming Function to be used for normalization b/w windows
%   Removes discontinuities by scaling samples near endpoints of windows to
%   0 while keeping midband values unchanged - minimizes spectral leakage
hamming_win = window( @hamming, win_size );

%   Array to store results of FFT for each window in buffer
i_mag_spectrum = [];

%   For every buffer in the buffered version of the signal
for i = 1 : i_buf_col
    %   Normalizing values for current FFT window
    buffer_data = i_buffer( :, i ) .* hamming_win;
    
    %   Magnitude spectrum for current FFT window
    %   Since n_fft = f_s, frequency resolution is 1?
    buffer_fft_mag = abs( fft( buffer_data, f_s ) );
    
    %	Appending this buffer's FFT results to rest
    i_mag_spectrum = [ i_mag_spectrum buffer_fft_mag ];
end

%   Create a figure window in which to render FFT magnitude plot
figure;

%   For every FFT window in the buffer
for i = 1 : i_buf_col
    %   clear drawing canvas before drawing new plot - prevents successive
    %   plots from overlapping
    clf;
    
    %   plot the magnitude spectrum for this FFT window
    plot( i_mag_spectrum( :, i ) );
    
    %   render the plot to the figure
    drawnow;
end

%   Adding details to graph
title( {'FFT Magnitude Spectrum - Current', ...
    '50 Hz Sinusoidal Current Spectrum over 44.1 kHz'} );
xlabel( 'Frequency (\it{f/Hz})' );
ylabel( 'Mangitude (\it{arbitrary units})' );
grid; 