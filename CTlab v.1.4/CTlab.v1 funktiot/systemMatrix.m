function W = systemMatrix(minAngle,stepAngle,maxAngle,geom,imageVolume,detectorElementsize,detectorWidth)

%Scan angles
angles=minAngle:stepAngle:maxAngle;

%Define projection & volume geometry
if (strcmp(geom,'Parallel')==1)
    proj_geom = astra_create_proj_geom('parallel', detectorElementsize, detectorWidth, angles*pi/180); 
    vol_geom = astra_create_vol_geom(imageVolume,imageVolume);%256
    W = opTomo('strip',proj_geom,vol_geom);
elseif (strcmp(geom,'Fanflat')==1)
    proj_geom = astra_create_proj_geom('fanflat', detectorElementsize, detectorWidth, angles*pi/180, SOD, ODD);
    vol_geom = astra_create_vol_geom(imageVolume,imageVolume);
    W = opTomo('cuda',proj_geom,vol_geom);
end

end