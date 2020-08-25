
% pol is boolean to indicate polar or cartesian plot
function plotOrbit(obj, pol)
    if(~pol)
        % Cartesian Plot
        plot(obj.orbit.path.x,obj.orbit.path.y,'r');
        hold on
        plot(NatConst.Re*cos(linspace(0, 2*pi, 360)),NatConst.Re*sin(linspace(0, 2*pi, 360)),'k');
        daspect([1 1 1]);
        xlabel('X Displacement from Earth (m)');
        ylabel('Y Displacement from Earth (m)');
        text(0,0,'Earth', 'HorizontalAlignment', 'center', 'FontSize', 8, 'FontUnits', 'normalized');
    else
        % Polar Plot
        polarplot(obj.orbit.path.nu,obj.orbit.path.r,'r');
        hold on
        grid minor
        polarplot(linspace(0,2*pi,360),NatConst.Re+zeros(1,360),'k');
        ax = gca;
        ax.RGrid = 'off';
        ax.RTick = []; 
        ax.ThetaAxis.Label.String = 'Angle (\nu) = True Anomally (degrees)';
        ax.GridAlpha = 0.075;
        text(0,0,'Earth', 'HorizontalAlignment', 'center', 'FontSize', 18); %'FontUnits', 'normalized');
        legend('Orbit','Earth','Location','southoutside','Orientation','horizontal');
    end
    
    title(sprintf('%s Orbit',obj.name));
    
end