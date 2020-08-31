function updateOrbit(obj)
% UPDATEORBIT(OBJ) uses the data stored to the Satellite object from a
% previous call to updateFromTLE() and calculates additional orbital
% parameters. Results are stored in an Orbit object within the Satellite
% object.
%
% In Class: Satellite

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
    
    % Run simulation generating orbit path
    obj.orbit.sim();
end