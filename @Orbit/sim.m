
function path = sim(obj)
    %% SIMULATING THE ORBIT - Q1b
    % Generating an array of mean anomaly values
    M = linspace(0, 2*pi, 360);

    % Converting these values to true anomaly values
    nu = mean2true(M, obj.e);

    % Radial Distance
    r = obj.a*(1-obj.e^2)./(1+obj.e*cos(nu));

    x = r.*cos(nu);
    y = r.*sin(nu);

    pos = [x;y]; 

    %% VERIFICATION OF PARAMETERS - Q1b

    % Getting the minimum and maximum values of the r array
    min_r = min(r);
    max_r = max(r);

    % Substituting these back into earlier formulas to check result is equal
    % Semi-Minor Axis
    a_verify = (min_r + max_r)/2;
    b_verify = sqrt(min_r*max_r);

    a_percent_error = (obj.a-a_verify)/obj.a*100;
    b_percent_error = (obj.b-b_verify)/obj.b*100;
    
    path.x = x;
    path.y = y;
    path.err_a = a_percent_error;
    path.err_b = b_percent_error;
end