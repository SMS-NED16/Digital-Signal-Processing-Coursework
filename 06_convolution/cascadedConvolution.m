%% EE-394 Digital Signal Processing: Lab 06 - Convolution
%% Tasks 3: Convolution of Cascaded Systems
%% EE-16163, Section D, TE-EE, Fall 2018

% clearing workspace, closing figures
clear all; close all;

% Defining input signals and origins
x_1 = [ 1 2 3 5 4 6 ]; org_x_1 = 1; 
x_2 = [ 1 2 3 5 4 6 ]; org_x_2 = 1;

% Defining impulse responses and origins
h_1 = [ 1 1 1 ];    org_h_1 = 1;
h_2 = [ 0 0 1 ];    org_h_2 = 1;
h_3 = [ 1 2 0 1 ];  org_h_3 = 2;

% Convolution of x_1 and x_2 using modified form of myConvolution
output_1 = myConvolution( x_1, org_x_1, h_1, org_h_1 );
output_2 = myConvolution( x_2, org_x_2, h_2, org_h_2 );

% Creating third input signal as sum of previous outputs
x_3 = output_1 + output_2;

% Systems represented by h1 and h2 are both causal - 
% org_h_1 and org_h_2 are both 1 (0 accounting for MATLAB indexing)
% so sum of output 1 and 2 will start from 1 (0)
org_x_3 = org_x_1;

% Convolution of sum of previous outputs - cascaded
output_3 = myConvolution( x_3, org_x_3, h_3, org_h_3 );