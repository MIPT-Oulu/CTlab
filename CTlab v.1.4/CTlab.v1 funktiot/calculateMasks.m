function [maskIodine,maskWater,maskAir,maskBone]=calculateMasks(p)
maskIodine = p < 0.31 & p > 0.29;                   %Iodine mask
maskWater = p < 0.21 & p > 0.19;                  %Water mask
maskAir = p < 0.01 & p > -0.01;                   %Air mask
maskBone = p < 1.01 & p > 0.99;
end