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
