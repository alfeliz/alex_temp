###########################################################################################
###########################################################################################
## Copyright (C) 2016 Gonzalo Rodríguez Prieto <gonzalo.rprieto@uclm.es>
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.
###########################################################################################
#
#  OCTAVE FUNCTION TO OBTAIN THE TEMPERATURE FROM CONTINUOUS SPECTRA OF METALLIC GASSES STORED IN CSV
# FILES WITH ',' AS SEPARATOR.
#    Made by Gonzalo Rodríguez Prieto
#              Version 1.0
#
###########################################################################################
###########################################################################################

function result = temp(file)
%TEMP Obtains the temperature follwing the Wien formula from a continuous spectrum.
%        RESULT = TEMP( FILE ) gives the temperature calculated from FILE,  which has the spectrum, in a string line.
%        First, the file name and later the estimated temperature in eV and Kelvin.
%
%        To estimate the temperature, the wavelength of the maximum intensity value is found, and later to this wavelength the Wien formula is applied.


#####
# Reading the file. 
#   First, a list with the filnames is made and later, iteratively worked on it.
#####

%~ file = "Ni-20kV-1_0us.csv"; %Testing purposes. Real will be from a list.


[dfile, msg] = fopen(file, "r");
if (dfile == -1) %If the files does not exists:
   error ("temp script: Unable to open data file name: %s, %s",file, msg); 
endif;

counts = dlmread(dfile, " , ", 1, 0); %Reading a CSV file the pro way...in a matrix of two columns and 1024 rows. (Ignoring the first text line)

fclose(dfile); %Close file after reading



#####
# Adjusting data to a 2nd degree polynomia and finding the position of maximum intensity, which gives temperature:
#####

polinomio = polyfit( counts(:,1), counts(:,2), 2 ); %Polynomial valus of the 2nd degree approxomation for the counts-wl data

counts_data = polyval(polinomio, counts(:,1) ); %Make the polynomium obtained before

[~, index] = max(counts_data); %Index position of the maximum value for the polynomial approximation, which indicates the wl of the Wien law.

wl_temp = counts(index,1) %Wl for the temperature calculations.



#####
# Calculation of Wien law temperature.
#   From Naval Research Laboratory formulas book
#   Page 72 of Logbook #02.
#####

Temp = 2.5e-5 / (wl_temp * 1e-7); %eV

T_kelvin = 11600 * Temp; %Kelvin degrees



#####
# Printing in a graph the temperature values with the polynomium and original spectrum lines. To later test that everything went Ok.
#####

temp_graph = figure("visible","off"); %Figure to print.
plot( counts(:,1), counts(:,2), '-k',  wl_temp, max(counts_data), '.r', 'MarkerSize', 40,  counts(:,1), counts_data, '-r' ); %Printing original spectrum, wl of maximum intensity point, and polynomium.
grid('on'); %Acivate grid
title ( file(1:end-4), 'fontsize', 13 ); %Title of the graph is the name of the data file without the extension
annotation( 'textbox', [0.35 .85 0.25 0.25], 'string', horzcat('Temp.(eV): ',num2str(Temp),', Temp(K): ',num2str(T_kelvin) ),  'linewidth', 0.5, 'edgecolor', 'w', 'fitboxtotext', 'on' , 'fontsize', 15, 'backgroundcolor' , 'w'); 
%Put in a box 8upper part of the graph, slightly centered, the values of Temperature in eV and Kelvin degrees

print(temp_graph, horzcat(file(1:end-4), "-radius.jpg")); %JPG format much faster than PDF in making a file and enough to check data.



#####
# Storing the info into a string:
#####
result = [ file(1:end-4), ' , Temp(eV): ', num2str(Temp), ', Temp(K): ',num2str(T_kelvin) ];



endfunction

#That's...that's all, folks! 
