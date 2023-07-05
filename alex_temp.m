###########################################################################################
#
#  OCTAVE SCRIPT TO OBTAIN THE TEMPERATURE FROM CONTINUOUS SPECTRA OF METALLIC GASSES
#    Made by Gonzalo Rodríguez Prieto
#              Version 1.0
#               It needs the function "temp.m" in the same folder, with the "*.csv" file with spectra data.
#
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



#####
# Script beginning:
#   Variables initialization and find files with data(Assumed to be "*.csv" files)
#####

tic;  %Control total computing time.

clear; %Empty memory from user created variables.

result = ''; %Initializing the final results text matrix

files = glob('*.csv'); %Find all the "*.csv" files in the execution folder



#####
# Loop to process each file separately and store the results.
#####

for i=1 : size(files)(1)%Number of files with spectra in the folder
    
    spectrum = char( files(i) ); %Spectrum file name. Displayed inthe next command order to see were it goes the script and if it stops, in which spectrum
    
    disp( spectrum(1:end-4) ); %Filename displayed.
    
    result = [result; temp(spectrum)]; %Calling the function (temp) that makes all the work. (IT assumes wl in nm, and Arbitrary units for intensity, in two columns)
    
endfor;



#####
# Data saving in a file
#####

fileid = fopen('temp_resultados.txt', 'w'); %Opening the file identifier to a text file to write final data in it
fdisp(fileid, result); %Writing the results
fclose(fileid); %Closing the file


    
#####
# Total processing time
#####

disp("Script alex_temp execution time:")
disp(toc/60)
disp(" minutes")

#That's...that's all, folks! 
