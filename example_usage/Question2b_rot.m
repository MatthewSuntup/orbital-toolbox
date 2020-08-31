%% SETUP
clc;
clear;
clf;
close all;

%% Example usage of viewTimeRot()
% Let's say we have a satellite in a circular orbit at an altitude of
% 590km and we're interested in the relationship between its elevation to
% an observer on the ground and the length of time it is visible to that
% observer. We also want to account for the rotation of the Earth.

% Define a minimum angle, below which we aren't able to see the satellite
% due to landscape features such as trees or buildings.
visible_ang = 5;    % degrees

% Calculate the orbital radius from the provided altitude
alt = 590000;           % Altitude of Orbit (m)
Ro = NatConst.Re + alt; % Radius of Orbit (m)

% The inclination is also necessary
i = 97;

% We must define the ground station coordinates as well, let's choose
% Sydney Observatory.
lat = -33.86;    % degrees
lon = 151.20;    % degrees
loc = [lat, lon];

[ascension, elevation, t, min_range] = viewTimeRot(Ro, i, visible_ang, loc);

%% DISPLAY
fprintf('Time of Visibility (Zenith Pass): %.1f seconds\n\n', max(t));
fprintf('Corresponding range: %.1f metres\n', min(min_range));
fprintf('Expected range for this pass: %.1f metres\n', alt);

%% PLOTTING
% Plot relationship between viwing time and elevation
figure();
plot(elevation(t>0),t(t>0));
hold on
plot([visible_ang, visible_ang], [0, 700],'r--');
title('Time vs. Elevation');
xlabel('Elevation (degrees)');
ylabel('Time Visible (seconds)');
grid minor
