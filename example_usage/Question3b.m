
%% SETUP
clc;
clear;
clf;
close all;

%% Example Usage of hohman()
% Let's say we're interested in a specific satellite that we have TLE data
% for, the ESA's PROBA1 satellite. We already know that the orbit for this
% satellite is approximately circular (e=0.0072) and we're trying to plan a
% hohmann transfer to a geostationary orbit. 

% We can use a Satellite object to extract the TLE data
tle_file = 'ESA_PROBA1.tle';
sat = Satellite('ESA PROBA1');
sat.updateFromTLE(tle_file);

% We'll calculate the average orbital radius from the semi-major and
% semi-minor axes as we're assuming it's circular
r1 = (sat.orbit.a + sat.orbit.b)/2;

% A geostationary orbit has a period equal to a sidereal day so we can
% calculate its radius
period_geo = NatConst.sidereal_day;
[v2,r2] = orbitFromPeriod(period_geo);

% A geostationary orbit has an inclination of 0, so as part of the homann
% transfer we want to undergo an inclination change
theta = sat.orbit.inc;

% Calculate the magnitude of delta v maneuvres using the hohmann() function
[dv1, dv2] = hohmann(r1,r2,theta);


%% DISPLAY
fprintf('----------------------------\n');
fprintf('%s Orbital Transfer\n',sat.name);
fprintf('----------------------------\n\n');
fprintf('Delta V at Perigee: %.2f m/s\n',dv1);
fprintf('Delta V at Apogee:  %.2f m/s\n',dv2);



%%
% Semi-Major Axis of the transfer orbit
a_transfer = (r1 + r2)/2;

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

title(sprintf('%s Hohmann Transfer Orbit',sat.name));
ax = gca;
ax.RGrid = 'off';
ax.RTick = [];
ax.ThetaAxis.Label.String = 'Angle (\nu) = True Anomally (degrees)';
ax.GridAlpha = 0.075;
% text(0,0,'Earth', 'HorizontalAlignment', 'center', 'FontSize', 10, 'FontUnits', 'normalized');
legend('Earth', 'SSO', 'Transfer Orbit', 'GEO','Location','southoutside','Orientation','horizontal');


figure(2)
plotEarth3D();
hold on

orbit1 = plot3m(zeros(1,361),0:360,(r1-NatConst.Re)/1000 + zeros(1,361),'Color','red','LineWidth',2);
rotate(orbit1, [0 0], 97.5663);

orbit2 = plot3m(zeros(1,361),0:360,(r2-NatConst.Re)/1000 + zeros(1,361),'Color','blue','LineWidth',2);

orbit_transfer = plot3m(zeros(1,length(rt(1:180))), nu(1:180)*180/pi ,(rt(1:180)-NatConst.Re)/1000,'Color','m','LineWidth',2);
rotate(orbit_transfer, [0 0], 97.5663);

legend([orbit1, orbit_transfer, orbit2],'SSO', 'Transfer Orbit', 'GEO','Location','south','Orientation','horizontal');
