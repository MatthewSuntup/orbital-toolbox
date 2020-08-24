% AER2705 - Space Engineering
% Assignment 1 - Question 5
% Author: Matthew Suntup

%% SETUP
clc;
clear;

%% NATURAL CONSTANTS
GM = 3.986e14;  % Standard Gravitational Parameter (m^3/sec^2)
Re = 6375000;       % Radius of the Earth (m)
sidereal_day = 23*60*60 + 56*60 + 4.0916;    % Length of Sideral Day (s)

T_hours = 14.00;
T_seconds = T_hours*60*60;
omega = 2*pi/T_seconds;

% Destination Orbit Radius
% Using: T^2/R^3 = 4*pi^2/GM;
r = nthroot((GM*T_seconds^2)/(4*pi^2),3);
v = sqrt(GM/r); 
alt = r-Re; 

% Parking Orbit Radius
r_init = 300000+Re;

% RAANs of Destination Orbits (and Parking Orbits)
RAAN_1 = 317;
RAAN_2 = mod(RAAN_1 + 120, 360);
RAAN_3 = mod(RAAN_2 + 120, 360);

% Delta V values for Hohmann Transfer
[dv1, dv2] = hohmann(r_init, r, 0);

delta = 5.305;      % Latitude of French Guiana
beta = 34.147751981423127;     % Inertial Launch azimuth (from Part B)

% Calculating the longitude difference between launch site and RAAN
lambda = atand(sind(delta)*tand(beta));

% Longitude of March Equinox (1:14pm French Guiana Time)
equinox_long = 360-dms2degrees([61 38 0]);

% Longitude of French Guiana SpacePort
launch_long = 360 - 52.834;

% Longitude of RAAN
raan_long = launch_long - lambda;

% Longitude difference between location of RAAN and March Equinox Location
long_diff = raan_long - equinox_long;

% Calculating time since vernal equinox over spaceport (seconds)
t1 = (RAAN_1-long_diff)/360*sidereal_day;
t2 = (RAAN_2-long_diff)/360*sidereal_day;
t3 = (RAAN_3-long_diff)/360*sidereal_day;

equinox_time = datetime('20-Mar-2018 13:14');
d1 = equinox_time + seconds(t1);
d2 = equinox_time + seconds(t2);
d3 = equinox_time + seconds(t3);

% Display
fprintf('---------------------------------\n');
fprintf('Galileo Orbital Transfer\n');
fprintf('---------------------------------\n\n');
fprintf('Delta V at Perigee: %.2f m/s\n',dv1);
fprintf('Delta V at Apogee:  %.2f m/s\n\n',dv2);

fprintf('    Launch Time for Each RAAN\n');
fprintf('RAAN = %3d | %s\n',RAAN_1, d1);
fprintf('RAAN = %3d | %s\n',RAAN_2, d2);
fprintf('RAAN = %3d | %s\n',RAAN_3, d3);


% Set a reference ellipsoid the size of the earth
earth = referenceEllipsoid('earth','km');

% Axis settings to implement reference ellipsoid and aesthetics
set(gcf,'color','white');
ax = axesm('globe','Geoid',earth,'Grid','on', 'GLineWidth',0.1,'GLineStyle','-','Gcolor',[0.9 0.9 0.1]);
ax.Position = [0 0 1 1];
axis equal off

% Load the image of the earth and show on the axis defined above
load topo
geoshow(topo,topolegend,'DisplayType','texturemap')

% Outline the continents
land = shaperead('landareas','UseGeoCoords',true);
plotm([land.Lat],[land.Lon],'Color','black')
hold on

% Plotting the 3 orbits and rotating them appropriately
MEO1 = plot3m(zeros(1,361),0:360,(r-Re)/1000 + zeros(1,361),'Color','r','LineWidth',3);
rotate(MEO1, [1 0 0], 56);
rotate(MEO1, [0 0 1], RAAN_1);
MEO2 = plot3m(zeros(1,361),0:360,(r-Re)/1000 + zeros(1,361),'Color','b','LineWidth',3);
rotate(MEO2, [1 0 0], 56);
rotate(MEO2, [0 0 1], RAAN_2);
MEO3 = plot3m(zeros(1,361),0:360,(r-Re)/1000 + zeros(1,361),'Color','m','LineWidth',3);
rotate(MEO3, [1 0 0], 56);
rotate(MEO1, [0 0 1], RAAN_3);
