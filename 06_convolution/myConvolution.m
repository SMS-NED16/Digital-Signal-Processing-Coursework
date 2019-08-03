%% EE-394 Digital Signal Processing: Lab 06 - Convolution
%% Tasks 1 - 2: Convolution of Discrete Time Signals
%% EE-16163, Section D, TE-EE, Fall 2018


function y = myConvolution( input, org_input, impulse, org_impulse )
% accepts arrays as input and impulse response of a DT system
% along with indexes of origin in each array
% computes output using convolution and plots result

% Defining system's unit impulse response + origin, length
h = impulse;
org_h = org_impulse;      % origin sample number in h
nh = [ 0 : length( h ) - 1 ] - org_h + 1;

% Defining system's input signal + origin, length
x = input;    
org_x = org_input;        % origin sample number in x
nx = [ 0 : length( x ) - 1 ] - org_x + 1;

% Output calculated with convolution
y = conv( h, x );
ny = [ nh(1) + nx(1) : nh(end) + nx(end) ] ;

% Each subplot in a new figure
figure;

% Subplot 1: Plotting Impulse Response
subplot( 3, 1, 1 ); stem( nh, h );
xlabel( 'Time index n' ); ylabel( 'Amplitude' );
xlim( [ nh(1) - 1, nh(end) + 1 ] );
title( 'Impulse Response \it{h(n)}' ); grid;

% Subplot 2: Plotting Input Signal
subplot( 3, 1, 2 ); stem( nx, x );
xlabel( 'Time Index n' ); ylabel( 'Amplitude' );
xlim( [ nx(1) - 1, nx( end ) + 1 ] );
title( 'Input Signal \it{x(n)}' ); grid;

% Subplot 3: Plotting Output Signal
subplot( 3, 1, 3 ); stem( ny, y );
xlabel( 'Time Index n' ); ylabel( 'Amplitude' );
xlim( [ ny(1) - 1, ny( end ) + 1 ] );
title( 'Output Obtained by Convolution \it{y(n)}' ); grid;