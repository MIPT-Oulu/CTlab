function [rec, recoText, minI, maxI] = reconstructionSelection(fig, valAlg, I_logsum,mask_I,mask_water,mask_air,mask_luu,W,imageVolume,alpha,lambda,iterations,ax,ax2)

if (strcmp(valAlg,'Filtered backprojection (FBP)')==1)
    alg='Filtered backprojection (FBP) reconstruction';
    ax.Title.String = sprintf('Filtered backprojection (FBP) reconstruction');
    recoText = 'Filtered backprojection (FBP)';
    recotext='Filtered backprojection (FBP) calculated';
    [rec,minI,maxI,h] = filteredBackprojection2(fig,recotext,I_logsum,mask_I,mask_water,mask_air,mask_luu,W,ax,ax2);
    
    
elseif (strcmp(valAlg,'Least squares')==1)
    ax.Title.String = sprintf('Least squares reconstruction');
    recoText = 'Least Squares';
    [rec,minI,maxI,h] = least_squares(fig,W, I_logsum, mask_I,mask_water,mask_air,mask_luu, iterations, ax, ax2);

    
elseif (strcmp(valAlg,'Tikhonov Regularization')==1)
    ax.Title.String = sprintf('Tikhonov Regularization reconstruction');
    recoText = 'Tikhonov Regularization';
    [rec,minI,maxI,h] = tikhonovReg(fig,W,imageVolume,I_logsum,mask_I,mask_water,mask_air,mask_luu,alpha,ax,ax2);

    
else isequal(valAlg,0)
    disp('Ready');
    recoText = 'Reconstruction algorithm selection cancelled';

end