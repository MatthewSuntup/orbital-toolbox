function launch_time = launchTime(RAAN, i, r, loc)
% LAUNCH_TIME = LAUNCHTIME(RAAN,I,LOC) calculates a possible launch time in
% order to launch directly into an orbit with a given inclination and RAAN
% from a given launch location. This assumes an appropriate launch azimuth
% is used (see launchAzimuth).
%
%   Inputs:
%       RAAN    - the longitude of the orbit's right ascension of the
%                 acsending node (degrees)
%       I       - the inclination of the orbit (degrees)
%       LOC     - a 1x2 array with the coordinates of the burnout location
%                 (LOC[1]=latitude, LOC[2]=longitude)
%
%   Outputs:
%       LAUNCH_TIME - a datetime object storing a date and time of day in
%                     Coordinated Universal  Time (UTC)
%
%   Notes:
%       LOC is the location of burnout, not launch. If a launch location is
%       provided, then it is assumed burnout happens instantaneously.

    % Burnout Location
    delta = loc(1); % latitude (degrees)
    lon = loc(2);	% longitude (degrees)
    
    % Inertial Launch azimuth
    beta = launchAzimuth(i, r, delta, true); 
    
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