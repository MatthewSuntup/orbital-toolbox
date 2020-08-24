
function printInfo(obj)
    % Title
    fprintf('----------------------------------------\n');
    fprintf(' %s\n',obj.name);
    fprintf('----------------------------------------\n');
    fprintf('Satellite Number: %d (%s)\n',obj.sat_number, obj.classification);
    fprintf('Launched in %d\n', obj.launch_year);
    fprintf('----------------------------------------\n\n');

    fprintf('Argument of Perigee: %.4f degrees\n', obj.orbit.ped_arg);
    fprintf('Altitude of Perigee: %f km\n', obj.orbit.Alt_Perigee/1000);
    fprintf('Inclination: %.4f degrees\n',obj.orbit.inc);
    fprintf('Orbital Period: %.8f days per orbit\n',obj.orbit.period);
    fprintf('Semi-Major Axis: %.2f metres\n', obj.orbit.a);
    fprintf('Semi-Minor Axis: %.2f metres\n\n', obj.orbit.b);

    fprintf('Verification of Simulation\n');
    % fprintf('Checking Semi-Major Axis: %.2f metres\n', a_verify);
    % fprintf('Checking Semi-Minor Axis: %.2f metres\n', b_verify);
    fprintf('Semi-Major Axis %% Error: %f%%\n',obj.orbit.path.err_a);
    fprintf('Semi-Minor Axis %% Error: %f%%\n\n',obj.orbit.path.err_b);

    area = obj.orbit.pathArea();
    length = obj.orbit.pathLength();
    fprintf('Orbital Area: %d km^2\n', area);
    fprintf('Total Path Length: %d kilometres\n\n',length);
end