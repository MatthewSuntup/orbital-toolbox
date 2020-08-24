% AER2705 - Space Engineering
% Assignment 1 - Question 5
% Author: Matthew Suntup

%% SETUP
clc;
clear;


%% SATELLITE PARAMETERS - Q5a
T_hours = 14.00;
T_seconds = T_hours*60*60;
omega = 2*pi/T_seconds;

% Using: T^2/R^3 = 4*pi^2/NatConst.GM;
r = nthroot((NatConst.GM*T_seconds^2)/(4*pi^2),3);
v = sqrt(NatConst.GM/r); 

alt = r-NatConst.Re; 

%% CALCULATING LAUNCH AZIMUTH - Q5b
% Part 2 
i = 56;
phi = 5;
inert_azimuth = asind(cosd(i)/cosd(phi));   % (answer for non-rotating earth)

v_orbit = 7730;
T_rot = 86164.09;
v_eqrot = 2*pi*NatConst.Re/T_rot;

vx_rot = v_orbit*sind(inert_azimuth)-v_eqrot*cosd(phi);
vy_rot = v_orbit*cosd(inert_azimuth);

azimuth = atand(vx_rot/vy_rot);

%% DESTINATION RAANs - Q5c
% Part 3
RAAN_1 = 317;
RAAN_2 = mod(RAAN_1 + 120, 360);
RAAN_3 = mod(RAAN_2 + 120, 360);


%% CALCULATING ORBITAL ENERGIES - Q5de
% Part 4
r_sso = 500000 + 6375000;
alt_sso = r_sso - NatConst.Re;
v_sso = sqrt(NatConst.GM/r_sso);
% Using: T^2/R^3 = 4*pi^2/NatConst.GM;
T_sso = sqrt(4*pi^2*r_sso^3/NatConst.GM);

e_gal = -NatConst.GM/(2*r);
e_sso = -NatConst.GM/(2*r_sso);

%percent_difference_sso = abs((e_gal - e_sso)/((e_gal + e_sso)/2));
percent_change_sso = abs((e_sso - e_gal)/e_gal);


% Part 5
r_geo = nthroot(NatConst.GM*(NatConst.sidereal_day)^2/(4*pi^2),3);
alt_geo = r_geo - NatConst.Re;
v_geo = sqrt(NatConst.GM/r_geo);

e_geo = -NatConst.GM/(2*r_geo);

percent_change_geo = abs((e_geo - e_gal)/e_gal);


%% Display
% Header
fprintf('----------------------------\n');
fprintf('GALILEO (European-GNSS)\n');
fprintf('----------------------------\n\n');

% Part 1
fprintf('Part 1:\n');
fprintf('Velocity: %.2f m/s \n',v);
fprintf('Altitude: %.2f km \n',alt/1000);

% Part 2
fprintf('\nPart 2:\n');
fprintf('Launch Azimuth: %.1f degrees\n', azimuth);

% Part 3
fprintf('\nPart 3:\n');
fprintf('...   See Question_5_c.m   ...\n');

% Part 4
fprintf('\nPart 4:\n');
fprintf('Velocity of SSO: %.2f m/s \n',v_sso);
% fprintf('Altitude of SSO: %.2f km \n',alt_sso/1000);
fprintf('Period of SSO: %.2f seconds \n', T_sso);
fprintf('Period of SSO: %.2f hours \n', T_sso/60/60);
fprintf('Percent Change: %.2f%% \n', percent_change_sso*100);

% Part 5
fprintf('\nPart 5:\n');
fprintf('Velocity of GEO: %.2f m/s \n',v_geo);
fprintf('Altitude of GEO: %.2f km \n',alt_geo/1000);
fprintf('Percent Change: %.2f%% \n\n', percent_change_geo*100);



