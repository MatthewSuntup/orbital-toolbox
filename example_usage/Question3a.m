% Example Usage
% Author: Matthew Suntup

%% SETUP
clc;
clear;
clf;
close all;

%% DECODING TLE DATA
tle_file = 'ESA_PROBA1.tle';
sat = Satellite('ESA PROBA1');
sat.updateFromTLE(tle_file);

%% OUTPUT
sat.printInfo();
figure();
sat.plotOrbit(true);
