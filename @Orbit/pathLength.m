function length = pathLength(obj)
% LENGTH = PATHLENGTH(OBJ) calculates the length of a given orbit by
% approximating the line integral of an ellipse.
%
% In Class: Orbit
%
%   Outputs:
%       LENGTH - the length of the orbit (km)

    syms n t k  % Symbolic Variables

    sum = 0;    % Variable to hold sum
    ni = 1;     % Variable to store next value in sequence
    n = 1;      % Iteration count

    % The series will continue to iterate until the next value adds less than
    % 100m to the final result. (see ../README.md)
    while 2*pi*obj.a*ni > 100
        ni = 2*pi*obj.a*(symprod(2*k-1,k,1,n)/symprod(2*t,t,1,n))^2*obj.ecc^(2*n)/(2*n-1);
        sum = sum + ni;
        n = n + 1;
    end

    % The formula for perimeter
    length = 2*pi*obj.a-sum;
end