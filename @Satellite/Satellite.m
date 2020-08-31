% Class Description:
%   The Satellite class is used to store details of a satellite, generally
%   from TLE data.
%
%   See reference page for properties and methods.

classdef Satellite < handle
    properties
        name;       % Name
        tle_data;   % TLE map
        
        orbit;      % Orbit object
        
        sat_number;   	% Satellite number
        classification;	% Classification
        launch_year;	% Launch year
        launch_num;     % Launch number
        piece;          % Piece designator

        elem_num;   % Element Set Number of TLE
        
        epoch_year; % Epoch year
        epoch_day;  % Epoch day
        der_mot_1;  % 1st derivative of mean motion
        der_mot_2;  % 2nd derivative of mean motion
        drag_term;  % Drag term
    end
    
    methods
        % Satellite Class Constructor
        function obj = Satellite(name)
            obj.name = name;
            obj.orbit = Orbit();
        end
        
        % Simple print function for basic Satellite info
        printInfo(obj);

        % Takes TLE data and updates satellite properties
        updateFromTLE(obj, tle_file);

        % Generate orbital parameters and simulate from TLE data
        updateOrbit(obj);
    end
end
