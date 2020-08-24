% AER2705 - Space Engineering
% Assignment 1 - Question 2
% Author: Matthew Suntup

% A gemoetric/analytical approach to Question 2a.
% This method does not take into account the rotation of the Earth.

% This script will calculate the lenght of time the given satellite is
% visible to a ground statio nantenna in Sydney from a point 5 degrees
% above the northern horizon to a point 5 degrees above the southern
% horzion when the satellite passes directly overhead through the zenith of
% the ground station.

%% SETUP
clc;
clear;
clf;

%% NATURAL CONSTANTS
GM = 3.986e14;  % Standard Gravitational Parameter (m^3/sec^2)
Re = 6375000;       % Radius of the Earth (m)

%% SATELLITE CONSTANTS
Alt = 590000;       % Altitude of Orbit (m)
Ro = Re + Alt;      % Raidus of Orbit (m)

% Angular Velocity of Satellite (degrees/sec)
omega = sqrt(GM/Ro^3)*180/(pi);

%% CALCULATIONS
% Calculating the angle covered while visible (degrees)
alpha = 2*(180-95-asind(Re*sind(95)/(Ro)));

% Length of time the satellite is visible (seconds)
t = alpha/omega;
t_mins = t/60;

%% DISPLAY
fprintf('----------------------------------------\n');
fprintf(' Question 2\n');
fprintf('----------------------------------------\n\n');
fprintf('Satellite Angular Velocity = %.3f degrees/sec\n',omega);
fprintf('Satellite Angle of Coverage = %.2f degrees\n',alpha);
fprintf('\nTime of Visibility: %.2f seconds\n',t);
fprintf('Time of Visibility: %.2f minutes\n',t_mins);



