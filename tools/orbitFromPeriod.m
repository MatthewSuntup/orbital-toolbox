function [v,r] = orbitFromPeriod(period)
% [V,R] = ORBITFROMPERIOD(PERIOD) calculates the orbital velocity and
% radius of a circular orbit with a given period.
%
%   Input:
%       PERIOD - orbital period (seconds)
%
%   Outputs:
%       V - orbital velocity (m/s)
%       R - orbital radius (m)

    % Using: T^2/R^3 = 4*pi^2/NatConst.GM;
    r = nthroot((NatConst.GM*period^2)/(4*pi^2),3);
    v = sqrt(NatConst.GM/r);
end