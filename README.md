![CTlab ´logo1](https://user-images.githubusercontent.com/110446843/183570885-af213bfb-5be0-4297-a8bf-00bf1a5eb818.png)


# A Numerical Computed Tomography Simulator

## Overview
The CTlab is virtually implemented medical imaging device, which can be widely used in computed tomography training for all professionals who use radiation in their work. The simulator provides fast, comprehensive, and efficient solutions for numerical CT simulations with low hardware requirements. The simulator has been developed to introduce the basic operations and workflow behind the CT imaging modality and to illustrate how the polychromatic x-ray spectrum, various imaging parameters, scan geometry and CT reconstruction algorithm affect the quality of the detected CT images.

## Features

The CTlab offers its user the opportunity 

- [x] to create the desired X-ray spectrum 
- [x] to adjust CT imaging parameters (image volume, scan angles, detector element size and detector width, noise, algorithm/geometry specific parameters) 
- [x] to select specific scan geometry, to observe projection data from selected imaging target with polychromatic x-ray spectrum
- [x] to select the specific algorithm for image reconstruction (FBP, least squares, Tikhonov regularization) 

## Versions

- Windows (version 1.4)
- Mac (version 1.0)

Since the use of Astra toolbox is not possible on Mac computers, a slightly separate version of the program has been developed for this purpose. The Mac version does not support iterative reconstruction algorithms or fanflat beam geometry in X-ray projection detection.

## Key User Groups

Key user groups for the simulator include medical physics, engineering, and radiographer students.

## Dependencies

- MATLAB R2020b
- [Astra Toolbox](https://www.astra-toolbox.com/downloads/index.html) (Windows version)
- [Spektr 3.0](https://github.com/I-STAR/SPEKTR)

CTlab uses two external open source Matlab toolkits. Spektr 3.0 is used to create a polychromatic X-ray spectrum for simulations and Astra toolbox to calculate reconstructions from polychromatic projection data (Not in the Mac version). The user must download both of the aforementioned Toolboxes and place them in Matlab's path in order for CTlab to work correctly. 

## Platform Overview

The main “Console window” of the CTlab behaves roughly analogous to a clinical CT scanner for graphically adjusting imaging setup and conducting simulation control, providing immediate feedback to the corresponding information panels during the simulation process, and visualizing reconstructed images in the console image windows.


![CT_lab_fig](https://user-images.githubusercontent.com/110446843/183819505-52c6244f-7684-43b9-95d0-7feff60b0779.png)

## Documentation

Further documentation and examples will be made available over time.


## Noteworthy

Since CTlab is being widely distributed for the first time, it may contain unforeseen bugs. If you wish, you can report these to the Issues channel. 

Thank you!


## Future version

The future version will include 

- a new imaging target 
- a technical image quality analysis tool

