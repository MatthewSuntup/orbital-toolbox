% Class Description:
%   The NatConst class is used to store natural constants. All scripts in
%   the orbital-toolbox refer to these constants when required.
%
% Properties:
%   GM - Standard Gravitational Parameter (m^3/sec^2)
%   Re - Radius of the Earth (m)
%   sidereal_day - Length of Sideral Day (s)
%   mar_equinox.time - datetime object for the 2020 March Equinox (UTC)
%   mar_equinox.lon - the longitude where the equinox occured (degrees)

classdef NatConst
    properties (Constant)
        % Standard Gravitational Parameter (m^3/sec^2)
        GM = 3.986e14; 
    
        % Radius of the Earth (m)
        Re = 6375000;   

        % Length of Sideral Day (s)
        sidereal_day = 23*60*60 + 56*60 + 4.0916;    
    
        % The March Equinox 2020 (UTC)
        mar_equinox = struct('time', datetime('20-Mar-2020 03:48'),...
                             'lon', dms2degrees([124 52 0]));
    end
end