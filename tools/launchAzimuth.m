
function launch_az = launchAzimuth(i, lat, inertial)
    
    
    
    inert_azimuth = asind(cosd(i)/cosd(lat));   % (answer for non-rotating earth)
    
    if nargin == 3 && inertial == true
        launch_az = inert_azimuth;
        return;
    end
    
    v_orbit = 7730;
    T_rot = 86164.09;
    v_eqrot = 2*pi*NatConst.Re/T_rot;

    vx_rot = v_orbit*sind(inert_azimuth)-v_eqrot*cosd(lat);
    vy_rot = v_orbit*cosd(inert_azimuth);

    launch_az = atand(vx_rot/vy_rot);


end