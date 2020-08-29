
% Class Description:
%   Class used to store natural constants.
%
% Properties:
%   

classdef NatConst
    properties (Constant)
        GM = 3.986e14;  % Standard Gravitational Parameter (m^3/sec^2)
        Re = 6375000;   % Radius of the Earth (m)
        sidereal_day = 23*60*60 + 56*60 + 4.0916;    % Length of Sideral Day (s)
        mar_equinox = struct('time', datetime('20-Mar-2020 03:48'), 'lon', dms2degrees([124 52 0]));
    end
end