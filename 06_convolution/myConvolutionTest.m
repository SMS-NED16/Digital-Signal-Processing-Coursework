%% EE-394 Digital Signal Processing: Lab 06 - Convolution
%% Tasks 1 - 2: Convolution of Discrete Time Signals
%% EE-16163, Section D, TE-EE, Fall 2018

% Clearing workspace, closing all figures
clear all; close all;

% input signal for tasks 1 and 2 is the same
input = [ 1, 2, 3, 5, 4, 6 ];
org_input = 1;      % origin index

% defining impulse response + origins for tasks 1 and 2
% Task 1
impulse_1 = [ 3, 2, 1, 2, 1, 0, 4, 0, 3 ]; 
org_impulse_1 = 1;  % origin index

% Task 2 
impulse_2 = [ -3, 1, 2, 4, 1, 0, 4, 0, 3 ]; 
org_impulse_2 = 5;  % origin index

% Using myConvolution function to generate subplots for each
% function arguments - input, input origin, impulse, impulse origin
% displays input, impulse, and result of convultion in figure
myConvolution( input, org_input, impulse_1, org_impulse_1 ); 
myConvolution( input, org_input, impulse_2, org_impulse_2 );