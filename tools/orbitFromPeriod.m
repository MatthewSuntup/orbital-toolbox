
function [v,r] = orbitFromPeriod(period)

    % Using: T^2/R^3 = 4*pi^2/NatConst.GM;
    r = nthroot((NatConst.GM*period^2)/(4*pi^2),3);
    v = sqrt(NatConst.GM/r); 
    
end