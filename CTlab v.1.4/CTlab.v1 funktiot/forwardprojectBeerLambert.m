function I=forwardprojectBeerLambert(minE0,maxE0,u_air_E,u_water_E,u_iodine_E,u_bone_E,projAir,...
                                                                   projWater,projIodine,projBone,imageNoise,mA,time,I0,d)

N1=size(projAir,1);
N2=size(projAir,2);
I_air = zeros(N1,N2,maxE0);
I_iodine = zeros(N1,N2,maxE0);
I_water = zeros(N1,N2,maxE0);
I_bone = zeros(N1,N2,maxE0);
I = zeros(N1,N2,maxE0);
noiseType='gaussian';                       %Noise type

for i=minE0:1:maxE0 %length(I0)
    %Beer-Lambert law for each energy of forward projection
    
    %Add noise for each forward projection
    I_air(:,:,i)=imnoise(exp(-u_air_E(i)*projAir*0.1),noiseType,0,imageNoise);
    I_water(:,:,i)=imnoise(exp(-u_water_E(i)*projWater*0.1),noiseType,0,imageNoise);
    I_iodine(:,:,i)=imnoise(exp(-u_iodine_E(i)*projIodine*0.1),noiseType,0,imageNoise);
    I_bone(:,:,i)=imnoise(exp(-u_bone_E(i)*projBone*0.1),noiseType,0,imageNoise);
    
    %Calculate forward projection which includes all materials, energies,
    %and exposure (mAs = mA*time)
    I(:,:,i) = mA*time*I0(i)*I_air(:,:,i).*I_iodine(:,:,i).*I_water(:,:,i).*I_bone(:,:,i);

    % Check for Cancel button press
    if d.CancelRequested
        break
    end
    
    %Update progress, report current estimate
    d.Value = i/length(I0);
    d.Message = sprintf('Projections for energy %d keV processed',i);
end



end