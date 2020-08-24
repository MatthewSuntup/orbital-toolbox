% AER2705 - Space Engineering
% Assignment 1 - Question 2
% Author: Matthew Suntup

% A gemoetric/analytical approach to Question 2b.
% This method does not take into account the rotation of the Earth.

% This script will calculate the length of time the given LEO satellite is
% visible 5 degrees above the ascending and descending horzion for a range
% of maximum elevation angles above the eastern or western horizon at the
% highest point of its trajectory.

%% SETUP
clc;
clear;
clf;


%% SATELLITE CONSTANTS
Alt = 590000;       % Altitude of Orbit (m)
Ro = NatConst.Re + Alt;      % Raidus of Orbit (m)

% Angular Velocity of Satellite (degrees/sec)
omega = sqrt(NatConst.GM/Ro^3)*180/(pi);

%% CALCULATIONS
% Elevation Angles (degrees)
theta = 5:90;

% Calculating the angle covered while visible (degrees)
% (Refer to diagrams and explanations in assignment 2b)

alpha = 85 - asind(NatConst.Re*sind(95)/Ro);
r = Ro*sind(alpha);
h = r*tand(5);
gamma = asind(NatConst.Re*sind(90+theta)/Ro);
beta = 90 - theta - gamma;
x = (h+NatConst.Re)*tand(beta);

% Note: The real() function fixes an error at boundary condition due to
% computational errors (likely in conversion between radians and degrees).
y = real(sqrt(r^2-x.^2));   
phi = acosd((2*Ro^2-(2*y).^2)/(2*Ro^2));

% Length of time the satellite is visible (seconds)
t = phi/omega;

%% PLOTTING
plot(theta,t);

title('Time vs. Elevation');
xlabel('Elevation (degrees)');
ylabel('Time Visible (seconds)');
grid minor
