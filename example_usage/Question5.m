%% SETUP
clc;
clear;
clf;
close all;

%% Example usage of orbitFromPeriod()
% If we're designing a satellite to be in a circular orbit with a  period
% of 14 hours, we can calculate the corresponding velocity and altitude.
T_hours = 14.00;
period = T_hours*60*60;
[v, r] = orbitFromPeriod(period);
alt = r-NatConst.Re; 

%% Display
fprintf('Velocity: %.2f m/s \n',v);
fprintf('Altitude: %.2f km \n',alt/1000);

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
