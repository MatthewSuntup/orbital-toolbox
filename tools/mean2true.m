function true_anomaly = mean2true(M, e)
% TRUE_ANOMALY = MEAN2TRUE(M, E) returns an array of true anomaly values
% corresponding to a given array of mean anomaly values for a given
% eccentricity. It uses the Newton-Raphson method to approximate this.
%
%   Inputs:
%       M - an array of mean anomally values (radians)
%       e - eccentricity [0-1]
%
%   Outputs:
%       TRUE_ANOMALY - an array of true anomaly values (radians)

    % Newton - Raphson method to solve for Eccentric Anomaly
    x_1 = 1;
    x_2 = M;
    while abs(x_2 - x_1) > 0.00001
        x_1 = x_2;
        x_2 = x_1 - (M - x_1 + e*sin(x_1))/(-1 + e*cos(x_1));
    end

    % Eccentric Anomaly (radians)
    E = x_2;

    % True Anomaly (radians)
    true_anomaly = 2*atan(sqrt((1+e)/(1-e))*tan(E/2));
end
