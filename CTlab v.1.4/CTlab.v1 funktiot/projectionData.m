function projReshaped=projectionData(p,imageTarget,imageVolume,W)

%Forward projection
proj = W*p(:);
%Reshape projection data
projReshaped = reshape(proj,W.proj_size);


end