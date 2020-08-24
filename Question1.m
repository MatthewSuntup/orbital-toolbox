% AER2705 - Space Engineering
% Assignment 1 - Question 1
% Author: Matthew Suntup

%% SETUP
clc;
clear;
clf;

%% NATURAL CONSTANTS
GM = 3.986e14;  % Standard Gravitational Parameter (m^3/sec^2)
Re = 6375000;       % Radius of the Earth (m)

%% DECODING TLE DATA

% TLE Data from Question 1
Line_1 = '1 25989U 99066A 17205.57517995 -.00000503 +00000-0 +00000-0 0 9995';
Line_2 = '2 25989 069.1905 002.0846 8188073 095.9356 000.3676 00.50142259021077';

% tle function  returns a map with a key and value for each element in the
% two line element set.
tleMap = tle(Line_1, Line_2);

%% CALCULATING PARAMETERS - Q1a
% Mean motion from TLE
Mean_Motion = tleMap('Mean_Motion');

% Calculating orbital period
Orbital_Period = 1/Mean_Motion;
Orbital_Period_Sec = Orbital_Period*24*60*60;

% Eccentricity from TLE
e = tleMap('Eccentricity');

% Semi-Major Axis
a = nthroot((Orbital_Period_Sec/(2*pi))^2*GM, 3);

% Radius and Altitude of Perigee
R_Perigee = a*(1-e);
Alt_Perigee = R_Perigee - Re;

% Radius of Apogee
R_Apogee = 2*a - R_Perigee;

% Semi-Minor Axis
b = sqrt(R_Perigee*R_Apogee);


%% SIMULATING THE ORBIT - Q1b
% Generating an array of mean anomaly values
M = linspace(0, 2*pi, 360);

% Converting these values to true anomaly values
nu = mean2true(M, e);

% Radial Distance
r = a*(1-e^2)./(1+e*cos(nu));

x = r.*cos(nu);
y = r.*sin(nu);

%% VERIFICATION OF PARAMETERS - Q1b

% Getting the minimum and maximum values of the r array
min = min(r);
max = max(r);

% Substituting these back into earlier formulas to check result is equal
% Semi-Minor Axis
a_verify = (min + max)/2;
b_verify = sqrt(min*max);

a_percent_error = (a-a_verify)/a*100;
b_percent_error = (b-b_verify)/b*100;

%% CALCULATING SURFACE AREA - Q1c

Orbital_Area = (a/1000)*(b/1000)*pi;  % kilometres^2

%% CALCULATING PATH LENGTH - Q1c
syms n t k  % Symbolic Variables

sum = 0;    % Variable to hold sum
ni = 1;     % Variable to store next value in sequence
n = 1;      % Iteration count

% The series will continue to iterate until the next value adds less than
% 100m to the final result. 
while 2*pi*a*ni > 100
    ni = 2*pi*a*(symprod(2*k-1,k,1,n)/symprod(2*t,t,1,n))^2*e^(2*n)/(2*n-1);
    sum = sum + ni;
    n = n + 1;
    
end

% The formula for perimeter
p_m = 2*pi*a-sum;

% Converting to kilometres
p_km = p_m/1000;

%% DISPLAY - Q1

ID_Year = tleMap('ID_Year');
if ID_Year > 20
    Launch_Year = 1900 + ID_Year;
else
    Launch_Year = 2000 + ID_Year;
end

% Title
fprintf('----------------------------------------\n');
fprintf(' ESA XMM X-Ray Observatory\n');
fprintf('----------------------------------------\n');
fprintf('Satellite Number: %d (%s)\n',tleMap('Satellite_Number'), tleMap('Classification'));
fprintf('Launched in %d\n', Launch_Year);
fprintf('----------------------------------------\n\n');

% Part A
fprintf('Part A:\n');
fprintf('Argument of Perigee: %.4f degrees\n', tleMap('Pedigree_Argument'));
fprintf('Altitude of Perigee: %f km\n', Alt_Perigee/1000);
fprintf('Inclination: %.4f degrees\n',tleMap('Inclination'));
fprintf('Orbital Period: %.8f days per orbit\n',Orbital_Period);
fprintf('Semi-Major Axis: %.2f metres\n', a);
fprintf('Semi-Minor Axis: %.2f metres\n\n', b);

% Part B
fprintf('Part B:\n');
fprintf('Verification of Simulation\n');
fprintf('Checking Semi-Major Axis: %.2f metres\n', a_verify);
fprintf('Checking Semi-Minor Axis: %.2f metres\n', b_verify);
fprintf('Semi-Major Axis %% Error: %f%%\n',a_percent_error);
fprintf('Semi-Minor Axis %% Error: %f%%\n\n',b_percent_error);

% Part C
fprintf('Part C:\n');
fprintf('Orbital Area: %d km^2\n', Orbital_Area);
fprintf('Total Path Length: %d kilometres\n\n',p_km);


%% PLOTTING

% Cartesian Plot
plot(x,y,'r');
hold on
plot(Re*cos(linspace(0, 2*pi, 360)),Re*sin(linspace(0, 2*pi, 360)),'k');
daspect([1 1 1]);

title('ESA XMM X-Ray Observatory Orbit');
xlabel('X Displacement from Earth (m)');
ylabel('Y Displacement from Earth (m)');
text(0,0,'Earth', 'HorizontalAlignment', 'center', 'FontSize', 8, 'FontUnits', 'normalized');

