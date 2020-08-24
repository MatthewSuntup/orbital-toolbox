
function plotOrbit(obj)
    % Cartesian Plot
    plot(obj.orbit.path.x,obj.orbit.path.y,'r');
    hold on
    plot(NatConst.Re*cos(linspace(0, 2*pi, 360)),NatConst.Re*sin(linspace(0, 2*pi, 360)),'k');
    daspect([1 1 1]);

    title(sprintf('%s Orbit',obj.name));
    xlabel('X Displacement from Earth (m)');
    ylabel('Y Displacement from Earth (m)');
    text(0,0,'Earth', 'HorizontalAlignment', 'center', 'FontSize', 8, 'FontUnits', 'normalized');

end