%   Clear workspace and close all figures before proceeding
clear all; clc; close all;

%   audioread will read audio data from file specified 
%   assumes file is in the same directory as the script (working directory)
%   y will be a matrix that stores the value of signal samples
%   fs will store the sampling frequency of the audio file being read
[ y, fs ] = audioread( 'wavTones.com.unregistred.warble_1000-2000Hz_-6dBFS_3s.wav' );

%   Are these the indices for sample values? They aren't used in program
n = 0 : 5000;

%   win size is the total number of samples from the signal that will be
%   used to perform the FFT operation - think of this as n_fft
win_size = 40e-3 * fs;

%   frame rate refers to the number of samples used in the buffer i.e. the
%   smallest unit of the window that will be used to evaluated FFT at a 
%   any given time. 
frame_rate = 20e-3 * fs;

%   The portion of the signal spanned by the window is broken up into
%   smaller chunks or buffers - store each buffer's data in a separate col
Y = buffer( y, win_size, frame_rate );

%   number of rows and colummns in buffer 
%   number of rows = m = number of fft data points being used
%   number of cols = n = nnumber of buffers generated for Y
[ m , n ] = size( Y );

%   create a windowing function that will be multiplied by signal values in
%   each buffer of the captured signal to eliminate endpoint discontinuites
win = window( @hamming, win_size );

%   empty matrix to store results of FFT operation for each buffer
YYF = [] ;

%   for every buffer that was created for the total window size
for i = 1 : n
    %   select all the rows of data in col corresponding to buffer
    %   i.e. all the signal samples for this buffer, and multiply
    %   the windowing function to normalize values
    YY = Y( :, i ) .* win;
    
    %   use FFT to find magn spectrum for this chunk of the window0
    YF = abs( fft( YY, fs ) );     % why pass fs as an argument?
    
    %   append the FFT results of this chunk to the total FFT results   
    YYF = [ YYF YF ];
end

%   plot the FFT results
figure;
for i = 1 : n
    clf;    % clear prev figure rendered on screen - blank canvas - refreshing
    plot( YYF( :, i ) );    %   add the FFT data for the ith column
    drawnow;                %   render 
end