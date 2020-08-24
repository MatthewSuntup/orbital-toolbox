% Example Usage
% Author: Matthew Suntup

%% SETUP
clc;
clear;
clf;
% close all;

%% DECODING TLE DATA
tle_file = 'ESA_XMM.tle';
sat = Satellite('ESA XMM X-Ray Observatory', tle_file);

%% OUTPUT
sat.printInfo();
sat.plotOrbit();
