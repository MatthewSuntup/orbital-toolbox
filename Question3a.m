% AER2705 - Space Engineering
% Assignment 1 - Question 3
% Author: Matthew Suntup

%% SETUP
clc;
clear;
clf;

%% NATURAL CONSTANTS
GM = 3.986e14;  % Standard Gravitational Parameter (m^3/sec^2)
Re = 6375000;   % Radius of the Earth (m)

%% DECODING TLE DATA

% TLE Data
Line_1 = '1 26958U 01049B 17203.88000472 +.00000611 +00000-0 +58221-4 0 9996';
Line_2 = '2 26958 097.5663 169.6727 0072397 207.7642 151.9697 14.95062095856853';

% tle function  returns a map with a key and value for each element in the
% two line element set.
tleMap = tle(Line_1, Line_2);

%% CALCULATING PARAMETERS
% Mean motion from TLE
Mean_Motion = tleMap('Mean_Motion');

% Calculating orbital period
Orbital_Period = 1/Mean_Motion;
Orbital_Period_Sec = Orbital_Period*24*60*60;

% Eccentricity from TLE
e = tleMap('Eccentricity');

% Semi-Major Axis
a = nthroot((Orbital_Period_Sec/(2*pi))^2*GM, 3);
R_Perigee = 2*a/(1+(e+1)/(1-e));
Alt_Perigee = R_Perigee - Re;

R_Apogee = 2*a/(1+(1-e)/(1+e));
b = sqrt(R_Perigee*R_Apogee);

ID_Year = tleMap('ID_Year');
if ID_Year > 20
    Launch_Year = 1900 + ID_Year;
else
    Launch_Year = 2000 + ID_Year;
end

%% DISPLAY
fprintf('----------------------------------------\n');
fprintf('Satellite Number: %d (%s)\n',tleMap('Satellite_Number'), tleMap('Classification'));
fprintf('Launched in %f\n', Launch_Year);
fprintf('----------------------------------------\n\n');
fprintf('Altitude of Perigee: %f metres\n', Alt_Perigee);
fprintf('Argument of Perigee: %.4f degrees\n', tleMap('Pedigree_Argument'));
fprintf('Inclination: %.4f degrees\n',tleMap('Inclination'));
fprintf('Orbital Period: %.8f days per orbit\n',Orbital_Period);
fprintf('Semi-Major Axis: %.2f metres\n', a);
fprintf('Semi-Minor Axis: %.2f metres\n\n', b);

%% SIMULATING THE ORBIT
% Generating an array of mean anomaly values
M = linspace(0, 2*pi, 360);

% Converting these values to true anomaly values
nu = mean2true(M, e);

% Radial Distance
r = a*(1-e^2)./(1+e*cos(nu));

%% PLOTTING
polarplot(nu,r,'r');
hold on
grid minor
polarplot(linspace(0,2*pi,360),Re+zeros(1,360),'k');
ax = gca;
ax.RGrid = 'off';
ax.RTick = [];
title('PROBA1 Orbit');
ax.ThetaAxis.Label.String = 'Angle (\nu) = True Anomally (degrees)';
ax.GridAlpha = 0.075;
text(0,0,'Earth', 'HorizontalAlignment', 'center', 'FontSize', 18); %'FontUnits', 'normalized');
legend('Orbit','Earth','Location','southoutside','Orientation','horizontal');


