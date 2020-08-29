function t = maxViewTimeStat(Ro, visible_ang)
% T = MAXVIEWTIMESTAT(RO,VISIBLE_ANG) calculates the maximum length of time
% a satellite in a circular orbit will be visible from the ground when
% passing directly overhead through the zenith of the observer, given a
% minimum viewing angle above the horizon.
%
%   Inputs:
%       RO          - orbital radius (m)
%       VISIBLE_ANG - the minimum viewing angle above the astronomical
%                     horizon that the observer can see above (degrees)
%
%   Output:
%       t - the maximum viewing time (s)
%
%   Notes:
%       This method does not consider the rotation of the Earth.
%       It is assumed the Earth is spherical and the satellite is in a
%       circular orbit, hence it does not require information about the
%       observer's location or further orbital parameters.

    % Angular Velocity of Satellite (degrees/sec)
    omega = sqrt(NatConst.GM/Ro^3)*180/(pi);
    
    % Calculating the angle covered while visible (degrees)
    alpha = 2*(180-95-asind(NatConst.Re*sind(90+visible_ang)/(Ro)));

    % Length of time the satellite is visible (seconds)
    t = alpha/omega;
end