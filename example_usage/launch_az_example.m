%% SETUP
clc;
clear;
clf;
close all;

%% Example usage of launchAzimuth()
% Let's say we want to launch into an orbit at 300km altitude, with
% an inclination of 52 degrees. And we want to launch from the Guiana
% Space Centre. We can calculate the launch azimuth as follows.

i = 56;
r = 300000 + NatConst.Re;
phi = 5; % Latitude of Guiana Space Centre
azimuth = launchAzimuth(i, r, phi);

%% Display
fprintf('Launch Azimuth: %.1f degrees\n', azimuth);