%% SETUP
clc;
clear;
clf;
close all;

%% Example Usage of Satellite.updateFromTLE()
tle_file = 'ESA_PROBA1.tle';
sat = Satellite('ESA PROBA1');
sat.updateFromTLE(tle_file);

%% Display (Polar Plot)
sat.printInfo();
sat.orbit.plotOrbit(true);
title(sprintf('%s Orbit',sat.name));
