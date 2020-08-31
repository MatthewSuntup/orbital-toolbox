%% SETUP
clc;
clear;
clf;
close all;

%% Example Usage of orbitFromPeriod() and hohmann()
% Let's say we have a satellite in a circular parking orbit at an altitude
% of 300km, and want it to complete a Hohmann transfer which would increase
% its period to 14 hours.

% Parking Orbit Radius
r_park = 300000+NatConst.Re;

% Calculate details of the destination orbit
T_hours = 14.00;
period = T_hours*60*60;
[v, r] = orbitFromPeriod(period);

% Delta V values for Hohmann Transfer
[dv1, dv2] = hohmann(r_park, r, 0);

%% Display
fprintf('Delta V at Perigee: %.2f m/s\n',dv1);
fprintf('Delta V at Apogee:  %.2f m/s\n\n',dv2);
