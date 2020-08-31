function plotOrbit(obj, pol)
% PRINTINFO(OBJ) is a quick method to plot an orbit, assuming the
% Orbit.sim() method has been run already.
%
% In Class: Orbit
%
%   Inputs:
%       POL - a boolean value indicating if the orbit should be plotted on
%             a polar (True) or cartesian (False) axis.

    if(~pol)
        % Cartesian Plot
        plot(obj.path.x,obj.path.y,'r');
        hold on
        plot(NatConst.Re*cos(linspace(0, 2*pi, 360)),NatConst.Re*sin(linspace(0, 2*pi, 360)),'k');
        daspect([1 1 1]);
        xlabel('X Displacement from Earth (m)');
        ylabel('Y Displacement from Earth (m)');
        text(0,0,'Earth', 'HorizontalAlignment', 'center', 'FontSize', 8, 'FontUnits', 'normalized');
    else
        % Polar Plot
        polarplot(obj.path.nu,obj.path.r,'r');
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
end