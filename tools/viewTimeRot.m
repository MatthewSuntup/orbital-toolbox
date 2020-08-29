
function [ascension, elevation, t, min_range] = viewTimeRot(Ro, visible_angle, loc)

    omegad_earth = 7.292115e-5*180/pi;  % degrees/second
    i = 97; % degrees


    %% ORBITAL CONSTANTS
    omega_sat = sqrt(NatConst.GM/(Ro)^3);   % radians/second
    omegad_sat = omega_sat*180/pi;      % degrees/second


    %% GROUND STATION LOCATION
    lat = loc(1);    % degrees
    lon = loc(2);    % degrees

    % Column Vector of the Ground Station's Location in ECEF Co-ordinates
    gnd_station = NatConst.Re*[cosd(lat)*cosd(lon);cosd(lat)*sind(lon);sind(lat)];

    %% CONDITIONS FOR VISIBILITY
    % Finding the maximum range

    alpha = asind(NatConst.Re*sind(90+visible_angle)/(Ro));      % degrees
    Rmax = NatConst.Re*sind(180-(90+visible_angle)-alpha)/sind(alpha);  % Rmax = 2304330; % metres

    %% ITERATING THROUGH ALL POSSIBLE ORBITS
    % Time Step
    dt = 1;
    OMEGA_range = 270:1:450;

    % Vectors to store values for each iteration of OMEGA values
    ascension = zeros(1,length(OMEGA_range));	% Right Ascension (OMEGA)
    t = zeros(1,length(OMEGA_range));        % Time
    min_range = zeros(1,length(OMEGA_range));       % Minimum Range from Ground Station
    elevation = zeros(1,length(OMEGA_range));	% Elevations

    % Counter variable used for storing values in the above arrays
    k = 1;

    mindist = 1000000000;

    % Iterating over all possible values for the right ascension
    for OMEGA = 270:1:450
        % Time since Vernal Equinox Alignment
        vernal_time = -dt;

        % Total visible time for this right ascension value
        total_time = 0;

        % Variable to store the minimum range for the given RAAN
        rmin = 10000000;

        % Iterating over angles in orbital co-ordinates
        for theta = 0:omegad_sat*dt:360

            vernal_time = vernal_time + dt;
            orbit = Ro*[cosd(theta),sind(theta),0]';

            % Transformation matrix to convert orbital co-ords to ECI
            ECI = [cosd(OMEGA),-sind(OMEGA)*cosd(i),0;sind(OMEGA),cosd(OMEGA)*cosd(i),0;0,sind(i),0]*orbit;

            % Transformation matrix to convert ECI to ECEF
            ECEF = [cosd(omegad_earth*vernal_time),sind(omegad_earth*vernal_time),0;-sind(omegad_earth*vernal_time),cosd(omegad_earth*vernal_time),0;0,0,1]*ECI;

            % Range from ground station to point (both in ECF co-ordinates)
            R = sqrt(sum((ECEF-gnd_station).^2));

            % If the range is less than Rmax then it's visible
            if R < Rmax
                % If it's visible then increment the total time visible
                total_time = total_time + dt;

                % For each OMEGA we keep track of Rmin (of visible positions)
                if R < rmin
                    rmin =  R;
                end
            end
        end

        % This if statement is to make sure we're only including the values
        % corresponding to visible points
        if total_time > 0

            % Means of storing the minimum range for each RAAN
            % This is used to calculate maximum elevation
            if  rmin < mindist
                mindist = rmin;
                zenithtime = total_time;
                zenithraan = OMEGA;
            end 
        end

        % Calculating the maximum elevation for the given RAAN
        elev = acosd((NatConst.Re^2 + rmin^2 - Ro^2)/(2*NatConst.Re*rmin))-90;

        % Storing values into arrays
        elevation(k) = elev;
        ascension(k) = OMEGA;
        t(k) = total_time;
        min_range(k) = rmin;

        k = k + 1;
    end



end