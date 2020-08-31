function updateFromTLE(obj, tle_file)
% UPDATEFROMTLE(OBJ) extracts two-line element (TLE) set data from a text
% file and stores the information in the relevant fields of the Satellite
% object.
%
% In Class: Satellite
%
%   Inputs:
%       tle_file - the file name of the text file containing the TLE data

    %% TLE Data Extraction
    % Open TLE file and read lines
    fid = fopen(tle_file,'r');
    Line_1 = fgetl(fid);
    Line_2 = fgetl(fid);
    fclose(fid);
    
    % tle function  returns a map with a key and value for each element in
    % the TLE set.
    tle_data = tle(Line_1, Line_2);
    obj.tle_data = tle_data;
    
    %% Updating Satellite Properties
    % Identifying Properties
    obj.sat_number = tle_data('Satellite_Number');
    obj.classification = tle_data('Classification');
    
    if obj.tle_data('ID_Year') > 20
        obj.launch_year = 1900 + obj.tle_data('ID_Year');
    else
        obj.launch_year = 2000 + obj.tle_data('ID_Year');
    end
    
    obj.launch_num = tle_data('ID_Launch_Number');
    obj.piece = tle_data('ID_Piece');
    
    % Element Set Number
    obj.elem_num = tle_data('Element_Set_Number');
    
    % Epoch/Motion Properties
    obj.epoch_year = tle_data('Epoch_Year');
    obj.epoch_day = tle_data('Epoch_Day');
    obj.der_mot_1 = tle_data('Derivative_Motion_1');
    obj.der_mot_2 = tle_data('Derivative_Motion_2');
    obj.drag_term = tle_data('Drag_Term');
    obj.orbit.mean_anom = tle_data('Mean_Anomaly');
    obj.orbit.epoch_revs = tle_data('Epoch_Revolutions');
    
    % Orbital Properties
    obj.orbit.inc = tle_data('Inclination');
    obj.orbit.right_asc = tle_data('Right_Ascension');
    obj.orbit.ecc = tle_data('Eccentricity');
    obj.orbit.ped_arg = tle_data('Pedigree_Argument');
    obj.orbit.mean_mot = tle_data('Mean_Motion');
    
    % Calculate additional orbital properties
    obj.updateOrbit();
end