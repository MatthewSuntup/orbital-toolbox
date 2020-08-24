
% Class Description:
%   Class used to store Satellite details.
%
% Properties:
%   

classdef Satellite < handle
    properties
        name;
        tle_data;
        
        % Orbit object
        orbit;
        
        % Identifying TLE Properties
        sat_number;
        classification;
        launch_year;
        launch_num;
        piece;
        
        % Element Set Number of TLE
        elem_num;
        
        % Epoch/Motion TLE Properties
        epoch_year;
        epoch_day;
        der_mot_1;
        der_mot_2;
        drag_term;
        
    end
    
    methods
        % Orbit Class Constructor
        function obj = Satellite(name)
            
            % Set satellite name
            obj.name = name;
            obj.orbit = Orbit();
            
        end
        
        % Takes TLE data and updates satellite properties
        updateFromTLE(obj, tle_file);
        plotOrbit(obj);
        printInfo(obj);
        updateOrbit(obj);
        
        
    end
end
