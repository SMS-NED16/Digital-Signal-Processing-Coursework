%% EE-394 Digital Signal Processing: Lab 05 - Modelling Systems
%% Task 1 - Numerical Model of DC Powered RL Circuit Current Response 
%% EE-16163, Section D, TE-EE, Fall 2018

%% Clearing all workspace data and closing any existing figures
clear all; close all;

%% Variable Declarations
t = 1;                      % sampling duration in seconds
T_s = 0.02;                 % sampling period in seconds
max_n = t / T_s;            % total number of samples
n = 1: 1 : max_n ;          % array of sample indexes
R = 20;                     % resistance in Ohms
L = 2;                      % inductance in Henries
V_s = 1;                    % DC supply voltage in Volts
i_init = 0;                 % initial circuit current in Amps
i_n = zeros( max_n, 1 );    % vector to store current values at each sample

%% Reading Data from Simulink 
% load .mat file containing Simulink data for current response
load( 'sim_current_data.mat' );

% store simulink current response in vector - manually add 0 as first value
% fetch only the second row - current values - until second last col
% helps ensure both i_simulink and i_n have comparable values and dims
i_simulink = [ 0, simulink_current( 2, 1 : max_n - 1  ) ];

%% Calculating Current According to Model
% for every sample
for var = n
    % if first sample being calculated
    if ( var == 1 )
        i_n( var ) = i_init;    % first val is always initial current 
    
    % if not the first sample being calculated
    else
        % using formula derived in report
        i_next = i_prev + ( T_s / L ) * ( V_s - R * i_prev );
        
        % store new value in the samples array
        i_n( var ) = i_next;
    end
    
    % remember last calculated sample value for next iteration
    i_prev = i_n( var );
end 

% accounting for MATLAB's non-zero indexing
n = n - 1;

%% Plotting Model Data
figure(); stem( n, i_n ); grid on;
title( 'Current Response - Numerical Model' );
xlabel( 'Sample Index \it{(n/arbitrary units)}' );
ylabel( 'Current \it{(i(n)/A)}' );

%% Calculating RMS Error b/w Simulink and Model Data
error = i_simulink' - i_n;                      % transpose to match dims
rmse = sqrt( mean ( error ).^2 );               % RMS error

%% Plotting Error at Each Sample
% bar plot to display error between simulink and model at each sample
figure(); bar( abs( error ) ); grid on;         % to fix sign diffs
xlim( [0, 50] );                                % default limit includes -10
title( 'Error between Simulink and Model Currents' );
xlabel( 'Sample Index \it{(n/arbitrary units)}'); % \it{} = italicise
ylabel( 'Error \it{(e/mA)}' );

% calculating coordinates and content for RMS error label on graph
text_x = max ( n ) * 0.45;              % around x axis midpoint
text_y = max( abs( error ) ) * 0.95;    % around y axis top
error_label = sprintf( 'RMS Error = %.3f A', rmse );
text( text_x, text_y, error_label );    % display RMS error with bar graph