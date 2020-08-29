function [theta, t] = viewTimeStat(Ro, visible_ang)
% [THETA,T] = VIEWTIMESTAT(RO,VISIBLE_ANG) will calculate the length of
% time a satellite in a circular orbit with a given radius is visible for a
% given viewing angle above the ascending and descending horizon for a
% range of maximum elevation angles associated with the highest point of it
% trajectory. Using an analytical approach.
%
%   Inputs:
%       RO          - orbital radius (m)
%       VISIBLE_ANG - the minimum viewing angle above the astronomical
%                     horizon that the observer can see above (degrees)
%
%   Outputs:
%       THETA	- an array of maximum elevation angles
%     	T       - an array of viewing times associated with each angle (s)
%
%   Notes:
%       The rotation of the earth is not considered.
%       Assumes a spherical earth.
%       Assumes a circular orbit.
%       Does not require information about the observer's location or
%       further orbital details (such as inclination).

    % Angular Velocity of Satellite (degrees/sec)
    omega = sqrt(NatConst.GM/Ro^3)*180/(pi);

    % Elevation Angles (degrees)
    theta = 0:90;

    % Calculating the angle covered while visible (degrees)
    alpha = (90-visible_ang) - asind(NatConst.Re*sind(90+visible_ang)/Ro);
    r = Ro*sind(alpha);
    h = r*tand(visible_ang);
    gamma = asind(NatConst.Re*sind(90+theta)/Ro);
    beta = 90 - theta - gamma;
    x = (h+NatConst.Re)*tand(beta);

    % Note: The real() function handles a boundary condition caused by a
    % computational error in conversion between radians and degrees.
    y = real(sqrt(r^2-x.^2));   
    phi = acosd((2*Ro^2-(2*y).^2)/(2*Ro^2));

    % Length of time the satellite is visible (seconds)
    t = phi/omega;
end