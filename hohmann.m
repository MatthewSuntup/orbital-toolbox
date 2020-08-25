function [dv1, dv2] = hohmann(r1, r2, theta)
       
    % Starting Velocity of the Inner Orbit
    v1 = sqrt(NatConst.GM/r1);

    % Final Velocity of the Outer Orbit
    v2 = sqrt(NatConst.GM/r2);

    % Semi-Major Axis of the transfer orbit
    a = (r1 + r2)/2;

    % Velocity on Transfer Orbit at Perigee
    vt1 = sqrt(NatConst.GM*(2/r1 - 1/a));

    % Velocity on Transfer Orbit at Apogee
    vt2 = sqrt(NatConst.GM*(2/r2 - 1/a));

    % Delta V at Perigee (First burn)
    dv1 = vt1-v1;

    % Delta V At Apogee (Second burn) WITH INCLINE CHANGE
    dv2 = sqrt(v2^2 + vt2^2 - 2*v2*vt2*cosd(theta));

end