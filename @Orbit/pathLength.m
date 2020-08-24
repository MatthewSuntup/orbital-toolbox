
% TODO: use meters or indicate units somehow? (just use m)


function length = pathLength(obj)

    %% CALCULATING PATH LENGTH 
    syms n t k  % Symbolic Variables

    sum = 0;    % Variable to hold sum
    ni = 1;     % Variable to store next value in sequence
    n = 1;      % Iteration count

    % The series will continue to iterate until the next value adds less than
    % 100m to the final result. 
    while 2*pi*obj.a*ni > 100
        ni = 2*pi*obj.a*(symprod(2*k-1,k,1,n)/symprod(2*t,t,1,n))^2*obj.e^(2*n)/(2*n-1);
        sum = sum + ni;
        n = n + 1;

    end

    % The formula for perimeter
    p_m = 2*pi*obj.a-sum;

    % Converting to kilometres
    p_km = p_m/1000;
    
    length = p_km;

end