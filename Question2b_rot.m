% AER2705 - Space Engineering
% Assignment 1 - Question 2
% Author: Matthew Suntup

% Here we account for the rotation of the Earth by using co-ordinate
% transformations.

% This script will calculate the length of time the given LEO satellite is
% visible 5 degrees above the ascending and descending horzion for a range
% of maximum elevation angles above the eastern or western horizon at the
% highest point of its trajectory.

%% SETUP
close all;
clc;
clear;
clf;

%% NATURAL CONSTANTS
GM = 3.986 *10^14;          % m^3/sec^2
R_Earth = 6375000;          % metres
Alt = 590000;               % metres
R_Orbit = R_Earth + Alt;    % metres

%% ORBITAL CONSTANTS
omega_sat = sqrt(GM/(R_Orbit)^3);   % radians/second
omegad_sat = omega_sat*180/pi;      % degrees/second
omegad_earth = 7.292115e-5*180/pi;  % degrees/second
i = 97; % degrees

%% GROUND STATION CONSTANTS (Sydney Observatory)
lat = -33.86;    % degrees
lon = 151.20;    % degrees

% Column Vector of the Ground Station's Location in ECEF Co-ordinates
gnd_station = R_Earth*[cosd(lat)*cosd(lon);cosd(lat)*sind(lon);sind(lat)];

%% CONDITIONS FOR VISIBILITY
% Finding the maximum range
alpha = asind(R_Earth*sind(95)/(R_Orbit));      % degrees
Rmax = R_Earth*sind(180-95-alpha)/sind(alpha);  % Rmax = 2304330; % metres

%% ITERATING THROUGH ALL POSSIBLE ORBITS
% Time Step
dt = 1;

% Vectors to store values for each iteration of OMEGA values
Ascension = [];         % Right Ascension (OMEGA)
Time = [];              % Time
Rmins = [];             % Minimum Range from Ground Station
Elevation = [];         % Elevations

% Counter variable used for storing values in the above arrays
k = 1;

mindist = 1000000000;

% Iterating over all possible values for the right ascension
for OMEGA = 270:1:450
    % Time since Vernal Equinox Alignment
    vernal_time = -dt;
    
    % Total visible time for this right ascension value
    total_time = 0;
    
    % Variable to store the minimum range for the given RAAN
    rmin = 10000000;

    % Iterating over angles in orbital co-ordinates
    for theta = 0:omegad_sat*dt:360
        
        vernal_time = vernal_time + dt;
        orbit = R_Orbit*[cosd(theta),sind(theta),0]';
        
        % Transformation matrix to convert orbital co-ords to ECI
        ECI = [cosd(OMEGA),-sind(OMEGA)*cosd(i),0;sind(OMEGA),cosd(OMEGA)*cosd(i),0;0,sind(i),0]*orbit;
        
        % Transformation matrix to convert ECI to ECEF
        ECEF = [cosd(omegad_earth*vernal_time),sind(omegad_earth*vernal_time),0;-sind(omegad_earth*vernal_time),cosd(omegad_earth*vernal_time),0;0,0,1]*ECI;
      
        % Range from ground station to point (both in ECF co-ordinates)
        R = sqrt(sum((ECEF-gnd_station).^2));
        
        % If the range is less than Rmax then it's visible
        if R < Rmax
            % If it's visible then increment the total time visible
            total_time = total_time + dt;
            
            % For each OMEGA we keep track of Rmin (of visible positions)
            if R < rmin
                rmin =  R;
            end
        end
    end
    
    % This if statement is to make sure we're only including the values
    % corresponding to visible points
    if total_time > 0
        
        % Means of storing the minimum range for each RAAN
        % This is used to calculate maximum elevation
        if  rmin < mindist
            mindist = rmin;
            zenithtime = total_time;
            zenithraan = OMEGA;
        end 
    end
    
    % Calculating the maximum elevation for the given RAAN
    elev = acosd((R_Earth^2 + rmin^2 - R_Orbit^2)/(2*R_Earth*rmin))-90;
    
    % Storing our values into arrays
    Elevation(k) = elev;
    Ascension(k) = OMEGA;
    Time(k) = total_time;
    Rmins(k) = rmin;
    
    % Incrementing a counter variable 
    k = k + 1;
end

%% DISPLAY

% Title
fprintf('----------------------------------------\n');
fprintf(' Question 2\n');
fprintf('----------------------------------------\n\n');
fprintf('Time of Visibility (Zenith Pass): %.1f seconds\n\n', zenithtime);
fprintf('Corresponding range: %.1f metres\n', min(Rmins));
fprintf('Expected range for this pass: %.1f metres\n', Alt);

%% PLOTTING

% Optional plot to compare time with RAAN
% figure(1)
% plot(Ascension, Time);
% title('Time vs. RAAN');
% xlabel('Right Ascention of the Ascending Node (degrees)');
% ylabel('Time Visible (seconds)');
% grid minor
% xlim([min(Ascension),max(Ascension)]);

% Compare time with elevation
figure(2)
plot(Elevation(Time>0),Time(Time>0));
hold on
plot([5, 5], [0, 700],'r--');
title('Time vs. Elevation');
xlabel('Elevation (degrees)');
ylabel('Time Visible (seconds)');
grid minor

