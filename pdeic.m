function u0 = pdeic(x,icMesh,icData) % Initial Conditions
u0 = interp1(icMesh,icData',x,'pchip')';% interpolate after creating a matrix icData', whose COLUMNS are vectors v1..vn, size(u0): n*1
end

