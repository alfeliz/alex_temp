# alex_temp
Temperature evaluation from spectral data in CSV format.
Used specifically for ALEX Pd and Ni 2023 data.
There are two important files in this project:
1. temp.m  An Octave function that form an input filename finds a wavelength of maximum intensity and from there calculates the temperature of a black body.
2. alex_temp.m  A script to use the previous function recursively.

## temp.m
This function needs a filename as input, and produces as main output a string line with this information:
- filename, that should be indicative of the experimantal conditions (Material, voltage, adquisition time,...9
- Calculated temperatue, in eV
- temperature, but in Kelvin degrees.

For example, this line:
*Ni-20kV-1_0us , Temp(eV): 0.61739, Temp(K): 7161.7317*

Also, this function saves in the folder were it is executed a *.JPG file with the spectrum that has read, the 2nd degree polynomium that approaches and the wavelength of maximum intensity, that shloud indicate the temperature.

Be careful with reading the *.CSV files, it is probably the most delicate part of the program.

## alex_temp.m
With this short script, the previous function can be used recursively over a bunch of files with spectra within. 
Easy to understand, just see the file itself.

## Important note:
Although **Github** says otherwise, all this code is Octave...
