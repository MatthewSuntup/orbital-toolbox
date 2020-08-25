
%% SETUP
clc;
clear;
clf;


%% SATELLITE CONSTANTS
Alt = 590000;       % Altitude of Orbit (m)
Ro = NatConst.Re + Alt;      % Raidus of Orbit (m)

[theta, t] = viewTimeStat(Ro, 5);


%% PLOTTING
plot(theta,t);

title('Time vs. Elevation');
xlabel('Elevation (degrees)');
ylabel('Time Visible (seconds)');
grid minor
