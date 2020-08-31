%% SETUP
clc;
clear;
clf;
close all;

%% Example Usage of Satellite.updateFromTLE()
tle_file = 'ESA_XMM.tle';
sat = Satellite('ESA XMM X-Ray Observatory');
sat.updateFromTLE(tle_file);

%% Display (Cartesian Plot)
sat.printInfo();
sat.orbit.plotOrbit(false);
title(sprintf('%s Orbit',sat.name));