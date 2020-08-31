function area = pathArea(obj)
% AREA = PATHAREA(OBJ) calculates the area of a given orbit.
%
% In Class: Orbit
%
%   Outputs:
%       area - the area of the orbit (m^2)

    area = obj.a*obj.b*pi;  % m^2
end