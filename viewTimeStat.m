
% Analytical approach

% This script will calculate the length of time the given LEO satellite is
% visible for a given viewing angle above the ascending and descending
% horzion for a range of maximum elevation angles above the eastern or
% western horizon at the highest point of its trajectory.

% This method does consider the rotation of the Earth, assumes a spherical
% Earth, and a circular orbit. Hence it does not require information about
% the viewing location or further orbital details.

function [theta, t] = viewTimeStat(Ro, visible_ang)
    % Angular Velocity of Satellite (degrees/sec)
    omega = sqrt(NatConst.GM/Ro^3)*180/(pi);

    % Elevation Angles (degrees)
    theta = 0:90;

    % Calculating the angle covered while visible (degrees)
    % (Refer to diagrams and explanations in assignment 2b)

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