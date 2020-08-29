function true_anomaly = mean2true(M, e)
% TRUE_ANOMALY = MEAN2TRUE(MEAN_ANOMALY, ECCENTRICITY) returns an array of true
% anomaly values corresponding to a given array of mean anomaly values for
% a given eccentricity.
%
% NOTE: MEAN_ANOMALY values should be in radians
%       TRUE_ANOMALY values will be returned in radians


    % Newton - Raphson method to solve for Eccentric Anomaly
    x_1 = 1;
    x_2 = M;
    while abs(x_2 - x_1) > 0.00001
        x_1 = x_2;
        x_2 = x_1 - (M - x_1 + e*sin(x_1))/(-1 + e*cos(x_1));
    end

    % Eccentric Anomaly (Radians)
    E = x_2;

    % True Anomaly (Radians)
    true_anomaly = 2*atan(sqrt((1+e)/(1-e))*tan(E/2));

end
