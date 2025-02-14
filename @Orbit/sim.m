function sim(obj)
% SIM(OBJ) generates an array of mean anomalies, true anomalies, radial
% distances, and cartesian coordinates, for the Orbit. Also generates error
% values based on comparison against the known semi-major and semi-minor
% axes. Resulting values are stored in the Orbit object.
%
% In Class: Orbit

    %% SIMULATING THE ORBIT
    % Generating an array of mean anomaly values
    M = linspace(0, 2*pi, 360);

    % Converting these values to true anomaly values
    nu = mean2true(M, obj.ecc);

    % Radial Distance
    r = obj.a*(1-obj.ecc^2)./(1+obj.ecc*cos(nu));

    x = r.*cos(nu);
    y = r.*sin(nu);

    %% VERIFICATION OF PARAMETERS
    % Getting the minimum and maximum values of the r array
    min_r = min(r);
    max_r = max(r);

    % Substituting these back into earlier formulas to check result is equal
    % Semi-Minor Axis
    a_verify = (min_r + max_r)/2;
    b_verify = sqrt(min_r*max_r);

    a_percent_error = (obj.a-a_verify)/obj.a*100;
    b_percent_error = (obj.b-b_verify)/obj.b*100;
    
    %% Assigning Values to Orbit objecct
    % Cartesian Coordinates
    path.x = x;
    path.y = y;
    
    % Polar Coordinates
    path.nu = nu;
    path.r = r;
    
    % Semimajor and semiminor errors
    path.err_a = a_percent_error;
    path.err_b = b_percent_error;
    
    obj.path = path;
end