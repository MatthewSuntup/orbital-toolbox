
%% SETUP
clc;
clear;
clf;
close all;

%% SATELLITE CONSTANTS

% TODO: Use Satellite object here (will need to make it possible to
% initalisie Satellite objects without TLE, consider removing tle_data and
% actually store all the appropriate values as properties)

Alt = 590000;       % Altitude of Orbit (m)
Ro = NatConst.Re + Alt;      % Raidus of Orbit (m)

t = maxViewTimeStat(Ro, 5);

t_mins = t/60;

%% DISPLAY
fprintf('----------------------------------------\n');
fprintf(' Question 2\n');
fprintf('----------------------------------------\n\n');
% fprintf('Satellite Angular Velocity = %.3f degrees/sec\n',omega);
% fprintf('Satellite Angle of Coverage = %.2f degrees\n',alpha);
fprintf('\nTime of Visibility: %.2f seconds\n',t);
fprintf('Time of Visibility: %.2f minutes\n',t_mins);



