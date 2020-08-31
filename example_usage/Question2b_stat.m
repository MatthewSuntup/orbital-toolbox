%% SETUP
clc;
clear;
clf;
close all;

%% Example usage of viewTimeStat()
% Let's say we have a satellite in a circular orbit at an altitude of
% 590km and we're interested in the relationship between its elevation to
% an observer on the ground and the length of time it is visible to that
% observer.

% Define a minimum angle, below which we aren't able to see the satellite
% due to landscape features such as trees or buildings.
visible_ang = 5;    % degrees

% Calculate the orbital radius from the provided altitude
alt = 590000;           % Altitude of Orbit (m)
Ro = NatConst.Re + alt; % Radius of Orbit (m)

% Calculate elevation angles and max viewing time
[theta, t] = viewTimeStat(Ro, visible_ang);

%% PLOTTING
plot(theta,t);
title('Time vs. Elevation');
xlabel('Elevation (degrees)');
ylabel('Time Visible (seconds)');
grid minor
