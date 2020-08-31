
% Class Description:
%   Class used to store and calculate properties of a Satellite's orbit.
%
% Properties:
%   

classdef Orbit < handle
    properties
        % Extractable from TLE
        inc;
        right_asc;
        ecc;
        ped_arg;
        mean_anom;
        mean_mot;
        epoch_revs;

        % Calculable from TLE
        period;
        period_sec;
        
        a;
        R_Perigee;
        Alt_Perigee;
        R_Apogee;
        b;
        
        
        path;
        
        
    end
    
    methods
        % Orbit Class Constructor
%         function obj = Orbit()        
            % Get orbital parameters
%             obj.updateOrbit(tleMap);
            
            % Generate cartesion coordinates
%             obj.path = obj.sim();
%         end
        
        
        area = pathArea(obj);
        length = pathLength(obj);
        sim(obj);
        plotOrbit(obj, pol);
        
        
    end
end