function launch_az = launchAzimuth(i, r, lat, inertial)
% LAUNCH_AZ = LAUNCHAZIMUTH(I,LAT,INERTIAL) calculates an appropriate
% launch azimuth for a rocket to reach an orbit with a given inclination
% and radius, from a launch site at a given latitude.
%
%   Inputs:
%       I           - inclination of the orbit (degrees)
%       R           - radius of the orbit (m)
%       LAT         - latitude of the launch site (degrees)
%       INERTIAL	- a boolean flag indicating if the rotation of the
%                     earth should be ignored (true) or accounted for
%
%   Outputs:
%       LAUNCH_AZ - the launch azimuth (degrees)
%
%   Notes:
%       Assumes the launch is directed eastwards (in the same direction as
%       the Earth's rotation to conserve energy).
    
    % Calculate the launch azimuth for a non-rotating earth
    inert_azimuth = asind(cosd(i)/cosd(lat));   
    
    if nargin == 4 && inertial == true
        launch_az = inert_azimuth;
        return;
    end
    
    v_orbit = sqrt(NatConst.GM/r);
    
    % The velocity of the Earth's surface due to the rotation of the Earth
    v_eqrot = 2*pi*NatConst.Re/NatConst.sidereal_day;

    vx_rot = v_orbit*sind(inert_azimuth)-v_eqrot*cosd(lat);
    vy_rot = v_orbit*cosd(inert_azimuth);

    launch_az = atand(vx_rot/vy_rot);
end