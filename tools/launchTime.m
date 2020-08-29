
function launch_time = launchTime(RAAN, i, loc)
% Assumes loc is location of burnout (if launch site location is provided
% then it is assumed burnout happens instantaneously)

    % Burnout Location
    delta = loc(1); % latitude (degrees)
    lon = loc(2);	% longitude (degrees)
    
    % Inertial Launch azimuth
    beta = launchAzimuth(i, delta, true); 
    
    % Longitude difference between launch site and ascending node
    lambda = atand(sind(delta)*tand(beta));

    % Longitude of RAAN
    raan_long = lon - lambda;

    % Longitude difference between location of RAAN and March Equinox Location
    long_diff = raan_long - NatConst.mar_equinox.lon;

    % Calculating time since vernal equinox over spaceport (seconds)
    t = (RAAN-long_diff)/360*NatConst.sidereal_day;
    
    launch_time = NatConst.mar_equinox.time + seconds(t);

end