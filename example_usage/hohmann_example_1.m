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

%% Display
fprintf('----------------------------\n');
fprintf('%s Orbital Transfer\n',sat.name);
fprintf('----------------------------\n\n');
fprintf('Delta V at Perigee: %.2f m/s\n',dv1);
fprintf('Delta V at Apogee:  %.2f m/s\n',dv2);

%% Simulate Transfer Orbit for Plotting
% We want to generate points for the transfer orbit to plot, so we can
% setup an Orbit object without needing TLE data or an associated Satellite
% and just give it the semi-major axis and eccentricity which is necessary
% for the Orbit.sim() method to generate the path.
transfer_orbit = Orbit();
transfer_orbit.a = (r1+r2)/2;
transfer_orbit.ecc = (r2 - r1)/(r2 + r1);
transfer_orbit.sim();

%% Plotting 2D Orbits
figure(1)

% Earth
polarplot(NatConst.Re+zeros(1,360),'k');
hold on

% Starting Orbit
orbit_1 = polarplot(r1+zeros(1,360),'r');

% Destination Orbit
orbit_2 = polarplot(r2+zeros(1,360),'b');

% Transfer Orbit
polarplot(transfer_orbit.path.nu,transfer_orbit.path.r,'m');
hold on
grid minor
polarplot(linspace(0,2*pi,360),NatConst.Re+zeros(1,360),'k');

title(sprintf('%s Hohmann Transfer Orbit',sat.name));
ax = gca;
ax.RGrid = 'off';
ax.RTick = [];
ax.ThetaAxis.Label.String = 'Angle (\nu) = True Anomally (degrees)';
ax.GridAlpha = 0.075;
legend('Earth', 'SSO', 'Transfer Orbit', 'GEO','Location','southoutside','Orientation','horizontal');

%% Plotting 3D Orbits
figure(2)
plotEarth3D();
hold on

% Initial Orbit
orbit1 = plot3m(zeros(1,361),0:360,(r1-NatConst.Re)/1000 + zeros(1,361),'Color','red','LineWidth',2);
rotate(orbit1, [0 0], sat.orbit.inc);

% Destination Orbit
orbit2 = plot3m(zeros(1,361),0:360,(r2-NatConst.Re)/1000 + zeros(1,361),'Color','blue','LineWidth',2);

% Transfer Orbit
orbit_transfer = plot3m(zeros(1,length(transfer_orbit.path.r(1:180))), rad2deg(transfer_orbit.path.nu(1:180)) ,(transfer_orbit.path.r(1:180)-NatConst.Re)/1000,'Color','m','LineWidth',2);
rotate(orbit_transfer, [0 0], sat.orbit.inc);

legend([orbit1, orbit_transfer, orbit2],'SSO', 'Transfer Orbit', 'GEO','Location','south','Orientation','horizontal');
