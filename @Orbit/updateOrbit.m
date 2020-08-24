%
% Function Syntax: Orbit.updateOrbit()
%
% Function Description: 
% 
% Inputs:
% % obj - the Orbit object
%
% In Class: Orbit
%

function updateOrbit(obj, tleMap)
    % Mean motion from TLE
    obj.Mean_Motion = tleMap('Mean_Motion');

    % Calculating orbital period
    obj.Orbital_Period = 1/obj.Mean_Motion;
    obj.Orbital_Period_Sec = obj.Orbital_Period*24*60*60;

    % Eccentricity from TLE
    obj.e = tleMap('Eccentricity');

    % Semi-Major Axis
    obj.a = nthroot((obj.Orbital_Period_Sec/(2*pi))^2*NatConst.GM, 3);

    % Radius and Altitude of Perigee
    obj.R_Perigee = obj.a*(1-obj.e);
    obj.Alt_Perigee = obj.R_Perigee - NatConst.Re;

    % Radius of Apogee
    obj.R_Apogee = 2*obj.a - obj.R_Perigee;

    % Semi-Minor Axis
    obj.b = sqrt(obj.R_Perigee*obj.R_Apogee);

end