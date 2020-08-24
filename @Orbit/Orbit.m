
% Class Description:
%   Class used to store and calculate properties of a Satellite's orbit.
%
% Properties:
%   

classdef Orbit < handle
    properties
        Mean_Motion;
        Orbital_Period;
        Orbital_Period_Sec;
        e;
        a;
        R_Perigee;
        Alt_Perigee;
        R_Apogee;
        b;
        path;
        
        
    end
    
    methods
        % Orbit Class Constructor
        function obj = Orbit(tleMap)        
            % Get orbital parameters
            obj.updateOrbit(tleMap);
            
            % Generate cartesion coordinates
            obj.path = obj.sim();
        end
        
        
        area = pathArea(obj);
        length = pathLength(obj);
        
        
    end
end