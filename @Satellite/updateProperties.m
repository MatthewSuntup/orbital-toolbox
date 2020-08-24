
function updateProperties(obj, tle_file)
    

    fid = fopen(tle_file,'r');
    Line_1 = fgetl(fid);
    Line_2 = fgetl(fid);
    fclose(fid);
    
    % tle function  returns a map with a key and value for each element in the
    % two line element set.
    obj.tle_data = tle(Line_1, Line_2);
    
    % Check launch year
    if obj.tle_data('ID_Year') > 20
        obj.Launch_Year = 1900 + obj.tle_data('ID_Year');
    else
        obj.Launch_Year = 2000 + obj.tle_data('ID_Year');
    end
end