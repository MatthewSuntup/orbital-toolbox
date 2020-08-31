%% SETUP
clc;
clear;
clf;
close all;

%% Example usage of maxViewTimeStat()
% Let's say we have a satellite in a circular orbit at an altitude of
% 590km and we're interested in the maximum poossible time it will be
% visible to an observer on the ground given it passes directly overhead
% through the zenith of the observer. 

% Define a minimum angle, below which we aren't able to see the satellite
% due to landscape features such as trees or buildings.
visible_ang = 5;    % degrees

% Calculate the orbital radius from the provided altitude
alt = 590000;               % Altitude of Orbit (m)
Ro = NatConst.Re + alt;     % Radius of Orbit (m)

% Calculate the maximum viewing time
t = maxViewTimeStat(Ro, visible_ang); % (seconds)
fprintf('\nTime of Visibility: %.2f seconds\n',t);
