function tleMap = tle(Line_1, Line_2)
% TLE Two line element decoder
%   MAP = TLE(LINE_1, LINE_2) returns a map with a key and value for each
%   element in the two line element set.
%
%   The keys and their return types:
%       --- LINE 1 ---
%       Satellite_Number        - double
%       Classification          - String
%       ID_Year                 - double
%       ID_Launch_Number        - double
%       ID_Piece                - String
%       Epoch_Year              - double
%       Epoch_Day               - double
%       Derivative_Motion_1     - String
%       Derivative_Motion_2     - String
%       Drag_Term               - String
%       Ephemeris_Type          - String
%       Element_Set_Number      - double
%       Check_Sum_1             - double
%       
%       --- LINE 2 ---
%       Inclination             - double
%       Right Ascension         - double
%       Eccentricity            - double
%       Pedigree_Argument       - double
%       Mean_Anomaly            - double
%       Mean_Motion             - double
%       Epoch_Revolutions       - double
%       Check_Sum_2             - double
%
    
    % Creating an empty map to store the elements
    tleMap = containers.Map;
    
    % Line 1
    tleMap('Satellite_Number') = str2double(Line_1(3:7));
    tleMap('Classification') = Line_1(8);
    tleMap('ID_Year') = str2double(Line_1(10:11));
    tleMap('ID_Launch_Number') = str2double(Line_1(12:14));
    tleMap('ID_Piece') = Line_1(15);
    tleMap('Epoch_Year') = str2double(Line_1(17:18));
    tleMap('Epoch_Day') = str2double(Line_1(19:30));
    tleMap('Derivative_Motion_1') = Line_1(32:41);
    tleMap('Derivative_Motion_2') = Line_1(43:50);
    tleMap('Drag_Term') = Line_1(52:59);
    tleMap('Ephemeris_Type') = Line_1(61);
    tleMap('Element_Set_Number') = str2double(Line_1(63:65));
    tleMap('Check_Sum_1') = str2double(Line_1(66));

    % Line 2
    tleMap('Inclination') = str2double(Line_2(9:16));
    tleMap('Right_Ascension') = str2double(Line_2(18:25));
    tleMap('Eccentricity') = str2double(Line_2(27:33))* 10^-7;
    tleMap('Pedigree_Argument') = str2double(Line_2(35:42));
    tleMap('Mean_Anomaly') = str2double(Line_2(44:51));
    tleMap('Mean_Motion') = str2double(Line_2(53:63));
    tleMap('Epoch_Revolutions') = str2double(Line_2(64:68));
    tleMap('Check_Sum_2') = str2double(Line_2(69));
end
