% Author: Matthew Suntup

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

% Display
fprintf('---------------------------------\n');
fprintf('Orbital Transfer\n');
fprintf('---------------------------------\n\n');
fprintf('Delta V at Perigee: %.2f m/s\n',dv1);
fprintf('Delta V at Apogee:  %.2f m/s\n\n',dv2);


%% Example Usage of launchTime()
% Let's say we want to know the ideal time to launch into an orbit with a
% right ascension of ascending node of 317 degrees and an inclination of 56
% degrees.

% Desired Orbit
RAAN = 317;
i = 56;

% Launch site location (French Guiana Space Centre)
lat = 5.305;      
lon = 360 - 52.834;
loc = [lat, lon];

% Launch time (Coordinated Universal Time)
launch_time = launchTime(RAAN, i, loc);

% Display
fprintf('Launch Time: %s (UTC)\n', launch_time);


