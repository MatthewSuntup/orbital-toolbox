

% This script will calculate the maximum length of time an object in a
% circular orbit will be visible from the ground when passing directly
% overhead through the zenith of the ground station, given a minimum
% viewing angle above the horizon.

% This method does consider the rotation of the Earth, assumes a spherical
% Earth, and a circular orbit. Hence it does not require information about
% the viewing location or further orbital details.

function t = maxViewTimeStat(Ro, visible_ang)

    % Angular Velocity of Satellite (degrees/sec)
    omega = sqrt(NatConst.GM/Ro^3)*180/(pi);
    
    % Calculating the angle covered while visible (degrees)
    alpha = 2*(180-95-asind(NatConst.Re*sind(90+visible_ang)/(Ro)));

    % Length of time the satellite is visible (seconds)
    t = alpha/omega;

end