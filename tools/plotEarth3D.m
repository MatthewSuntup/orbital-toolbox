function plotEarth3D()
% PLOTEARTH3D() plots a 3D representation of the earth on the current
% figure

    % Set a reference ellipsoid the size of the earth
    earth = referenceEllipsoid('earth','km');

    % Axis settings to implement reference ellipsoid and aesthetics
    set(gcf,'color','white');
    ax = axesm('globe','Geoid',earth,'Grid','on', 'GLineWidth',0.1,'GLineStyle','-','Gcolor',[0.9 0.9 0.1]);
    ax.Position = [0 0 1 1];
    axis equal off

    % Load the image of the earth and show on the axis defined above
    load topo
    geoshow(topo,topolegend,'DisplayType','texturemap')

    % Outline the continents
    land = shaperead('landareas','UseGeoCoords',true);
    plotm([land.Lat],[land.Lon],'Color','black')
end