% AER2705 - Space Engineering
% Assignment 1 - Question 2
% Author: Matthew Suntup

% Here we account for the rotation of the Earth by using co-ordinate
% transformations.

% This script will calculate the length of time the given LEO satellite is
% visible 5 degrees above the ascending and descending horzion for a range
% of maximum elevation angles above the eastern or western horizon at the
% highest point of its trajectory.

%% SETUP
clc;
clear;
clf;
% close all;

%% ORBITAL CONSTANTS
alt = 590000;              % Altitude (metres)
Ro = NatConst.Re + alt;    % Orbital Radius (metres)

%% GROUND STATION CONSTANTS (Sydney Observatory)
lat = -33.86;    % degrees
lon = 151.20;    % degrees
    
loc = [lat, lon];
visible_angle = 5;
[ascension, elevation, t, min_range] = viewTimeRot(Ro, visible_angle, loc);



%% DISPLAY

% Title
fprintf('----------------------------------------\n');
fprintf(' Question 2\n');
fprintf('----------------------------------------\n\n');
fprintf('Time of Visibility (Zenith Pass): %.1f seconds\n\n', max(t));
fprintf('Corresponding range: %.1f metres\n', min(min_range));
fprintf('Expected range for this pass: %.1f metres\n', alt);

%% PLOTTING

% Optional plot to compare time with RAAN
figure(1)
plot(ascension, t);
title('Time vs. RAAN');
xlabel('Right Ascention of the Ascending Node (degrees)');
ylabel('Time Visible (seconds)');
grid minor
xlim([min(ascension),max(ascension)]);

% Compare time with elevation
figure(2)
plot(elevation(t>0),t(t>0));
hold on
plot([visible_angle, visible_angle], [0, 700],'r--');
title('Time vs. Elevation');
xlabel('Elevation (degrees)');
ylabel('Time Visible (seconds)');
grid minor

