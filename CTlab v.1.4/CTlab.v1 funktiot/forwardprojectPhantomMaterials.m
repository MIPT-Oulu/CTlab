function [projIodine,projWater,projAir,projBone]=forwardprojectPhantomMaterials(W,maskIodine,maskWater,maskAir,maskBone)

projWater = reshape(W*double(maskWater(:)),W.proj_size);        %Water forward projection
projAir = reshape(W*double(maskAir(:)), W.proj_size);           %Air forward projection
projIodine = reshape(W*double(maskIodine(:)), W.proj_size);               %Iodine forward projection
projBone = reshape(W*double(maskBone(:)), W.proj_size);               %Iodine forward projection

end