% AER2705 - Space Engineering
% Assignment 1 - Question 3
% Author: Matthew Suntup

%% SETUP
clc;
clear;
clf;

%% SATELLITE PARAMETERS
% Radius of SSO Orbit
%r1 = 6960000; % metres
r1 = (6960314.449135 + 6960132.040373)/2;  % metres

% Period of GEO Orbit (seconds)
T_geo = NatConst.sidereal_day;

% Radius of GEO Orbit (metres)
r2 = nthroot((NatConst.GM*T_geo^2)/(4*pi^2),3);

% Incline Change
theta = 097.5663;

% Calculating the magnitude of delta v maneuvres
[dv1, dv2] = hohmann(r1,r2,theta);

% Semi-Major Axis of the transfer orbit
a_transfer = (r1 + r2)/2;

%% DISPLAY
fprintf('----------------------------\n');
fprintf('PROBA1 Orbital Transfer\n');
fprintf('----------------------------\n\n');
fprintf('Delta V at Perigee: %.2f m/s\n',dv1);
fprintf('Delta V at Apogee:  %.2f m/s\n',dv2);

%% SIMULATING ORBITAL TRANSFER
M = linspace(0, 2*pi, 360);
e = (r2 - r1)/(r2 + r1);

% True Anomaly (radians)
nu = mean2true(M,e);

% Position Vector
rt = a_transfer*(1-e^2)./(1+e*cos(nu));

%% PLOTTING
figure(1)
% Earth
earth = polarplot(NatConst.Re+zeros(1,360),'k');
hold on
% Starting Orbit
orbit_1 = polarplot(r1+zeros(1,360),'r');
% Destination Orbit
orbit_2 = polarplot(r2+zeros(1,360),'b');

orbit_transfer = polarplot(nu,rt,'m');
hold on
grid minor
NatConst.Re = 6375000;  % metres
polarplot(linspace(0,2*pi,360),NatConst.Re+zeros(1,360),'k');

title('PROBA1 Hohmann Transfer Orbit');
ax = gca;
ax.RGrid = 'off';
ax.RTick = [];
ax.ThetaAxis.Label.String = 'Angle (\nu) = True Anomally (degrees)';
ax.GridAlpha = 0.075;
% text(0,0,'Earth', 'HorizontalAlignment', 'center', 'FontSize', 10, 'FontUnits', 'normalized');
legend('Earth', 'SSO', 'Transfer Orbit', 'GEO','Location','southoutside','Orientation','horizontal');

figure(2)
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

orbit1 = plot3m(zeros(1,361),0:360,(r1-NatConst.Re)/1000 + zeros(1,361),'Color','red','LineWidth',2);
rotate(orbit1, [0 0], 97.5663);

orbit2 = plot3m(zeros(1,361),0:360,(r2-NatConst.Re)/1000 + zeros(1,361),'Color','blue','LineWidth',2);

orbit_transfer = plot3m(zeros(1,length(rt(1:180))), nu(1:180)*180/pi ,(rt(1:180)-NatConst.Re)/1000,'Color','m','LineWidth',2);
rotate(orbit_transfer, [0 0], 97.5663);

legend([orbit1, orbit_transfer, orbit2],'SSO', 'Transfer Orbit', 'GEO','Location','south','Orientation','horizontal');
