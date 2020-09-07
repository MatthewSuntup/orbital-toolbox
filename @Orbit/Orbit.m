% Class Description:
%   The Orbit class is used to store and calculate properties of a
%   Satellite's orbit. An Orbit object can also be instansiated without an
%   associated Satellite object and parameters filled in manually.
%
%   See reference page for properties and methods.

classdef Orbit < handle
    properties
        inc;        % Inclination (degrees)
        right_asc;  % Right ascension (degrees)
        ecc;        % Eccentricity
        ped_arg;    % Argument of pedigree (degrees)
        mean_anom;  % Mean anomally (degrees)
        mean_mot;   % Mean motion (orbits per day)
        epoch_revs; % Epoch revolutions

        period;     % Period (days)
        period_sec; % Period (seconds)
        
        a;              % Semi-major axis (m)
        b;              % Semi-minor axis (m)
        r_perigee;      % Radius of perigee (m)
        r_apogee;       % Radius of apogee (m)
        
        %R_Perigee;      % Radius of perigee (m)
        %Alt_Perigee;    % Altitude of perigee (m)
        %R_Apogee;       % Radius of apogee (m)
        
        
        path;   % Path struct

        % Path struct contains fields:
        %   x, y - an array of cartesian coords
        %   nu, r - an array of polar coordinates
        %   err_a, err_b - percentage error in the semi-major and
        %                  semi-minor axes of the path from Orbit.sim()

    end
    
    methods
        % Returns the area of the orbit (m^2)
        area = pathArea(obj);

        % Returns the approximate perimeter of the orbit (m)
        length = pathLength(obj);
        
        % A simple plotting function for cartesian or polar axes
        plotOrbit(obj, pol);  

        % Simulates the orbit and stores results in Orbit.path
        sim(obj);
    end
end