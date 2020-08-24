
% Class Description:
%   Class used to store Satellite details.
%
% Properties:
%   

classdef Satellite < handle
    properties
        name;
        tle_data;
        orbit;
        Launch_Year;
    end
    
    methods
        % Orbit Class Constructor
        function obj = Satellite(name, tle_file)
            
            
            % Set satellite name
            obj.name = name;
            
            % Extract properties and simulate orbit
            obj.updateProperties(tle_file);
            obj.orbit = Orbit(obj.tle_data);
        end
        
        % Takes TLE data and updates satellite properties
        updateProperties(obj, tle_file);
        plotOrbit(obj);
        printInfo(obj);
        
        
    end
end
