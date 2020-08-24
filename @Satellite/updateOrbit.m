%
% Function Syntax: Orbit.updateOrbit()
%
% Function Description: 
% 
% Inputs:
% % obj - the Orbit object
%
% In Class: Satellite
%

function updateOrbit(obj)


    % Calculating orbital period
    obj.orbit.period = 1/obj.orbit.mean_mot;
    obj.orbit.period_sec = obj.orbit.period*24*60*60;

    % Semi-Major Axis
    obj.orbit.a = nthroot((obj.orbit.period_sec/(2*pi))^2*NatConst.GM, 3);

    % Radius and Altitude of Perigee
    obj.orbit.R_Perigee = obj.orbit.a*(1-obj.orbit.ecc);
    obj.orbit.Alt_Perigee = obj.orbit.R_Perigee - NatConst.Re;

    % Radius of Apogee
    obj.orbit.R_Apogee = 2*obj.orbit.a - obj.orbit.R_Perigee;

    % Semi-Minor Axis
    obj.orbit.b = sqrt(obj.orbit.R_Perigee*obj.orbit.R_Apogee);
    
    obj.orbit.sim();
    
end