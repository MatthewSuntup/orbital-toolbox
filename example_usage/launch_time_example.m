%% SETUP
clc;
clear;
clf;
close all;

%% Example Usage of launchTime()
% Let's say we want to know the ideal time to launch into an orbit with a
% right ascension of ascending node of 317 degrees and an inclination of 56
% degrees.

% Desired Orbit
RAAN = 317;
i = 56;

% Calculate the orbital radius from the provided altitude
alt = 300000;           % Altitude of Orbit (m)
r = NatConst.Re + alt;  % Radius of Orbit (m)

% Launch site location (Guiana Space Centre)
lat = 5.305;      
lon = 360 - 52.834;
loc = [lat, lon];

% Launch time (Coordinated Universal Time)
launch_time = launchTime(RAAN, i, r, loc);

%% Display
fprintf('Launch Time: %s (UTC)\n', launch_time);
