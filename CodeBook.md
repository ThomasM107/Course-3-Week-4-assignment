# Codebook for run_analysis.R

This codebook accompanies the script run_analysis.R which processes data from the UCI HAR dataset. The script extracts only the mean and standard deviation measurements from the dataset, and returns means of these data for each activity and subject.

## Initial Data

Initial variables in the UCI HAR dataset are (details of these variables can be found in features_info.txt):

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

Here, XYZ is an abbreviation of the three separate variables with suffix X, Y and Z. 

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The various posible combinatations yield 561 initial variables for this data set.


## Subsetting the data -extracting mean and standard deviation variables

The data were searched (with grep) for only those variables containing either mean or standard deviation data (while meanFreq was excluded as it is not comparable to the other means). This yielded 66 variables. The names of these variables where changed using routines in run_analysis.R (part 4) to make them more human readable. Due to the unavoidably long name of the variables, underscores where retained in this case for clarity. This process yielded 66 variables:

 [1] "time_body_acceleration_mean_x"                                   
 [2] "time_body_acceleration_mean_y"                                   
 [3] "time_body_acceleration_mean_z"                                   
 [4] "time_body_acceleration_standard_deviation_x"                     
 [5] "time_body_acceleration_standard_deviation_y"                     
 [6] "time_body_acceleration_standard_deviation_z"                     
 [7] "time_gravity_acceleration_mean_x"                                
 [8] "time_gravity_acceleration_mean_y"                                
 [9] "time_gravity_acceleration_mean_z"                                
[10] "time_gravity_acceleration_standard_deviation_x"                  
[11] "time_gravity_acceleration_standard_deviation_y"                  
[12] "time_gravity_acceleration_standard_deviation_z"                  
[13] "time_body_linear_acceleration_mean_x"                            
[14] "time_body_linear_acceleration_mean_y"                            
[15] "time_body_linear_acceleration_mean_z"                            
[16] "time_body_linear_acceleration_standard_deviation_x"              
[17] "time_body_linear_acceleration_standard_deviation_y"              
[18] "time_body_linear_acceleration_standard_deviation_z"              
[19] "time_body_gyroscope_mean_x"                                      
[20] "time_body_gyroscope_mean_y"                                      
[21] "time_body_gyroscope_mean_z"                                      
[22] "time_body_gyroscope_standard_deviation_x"                        
[23] "time_body_gyroscope_standard_deviation_y"                        
[24] "time_body_gyroscope_standard_deviation_z"                        
[25] "time_body_angular_acceleration_mean_x"                           
[26] "time_body_angular_acceleration_mean_y"                           
[27] "time_body_angular_acceleration_mean_z"                           
[28] "time_body_angular_acceleration_standard_deviation_x"             
[29] "time_body_angular_acceleration_standard_deviation_y"             
[30] "time_body_angular_acceleration_standard_deviation_z"             
[31] "time_body_acceleration_magnitude_mean"                           
[32] "time_body_acceleration_magnitude_standard_deviation"             
[33] "time_gravity_acceleration_magnitude_mean"                        
[34] "time_gravity_acceleration_magnitude_standard_deviation"          
[35] "time_body_linear_acceleration_magnitude_mean"                    
[36] "time_body_linear_acceleration_magnitude_standard_deviation"      
[37] "time_body_gyroscope_magnitude_mean"                              
[38] "time_body_gyroscope_magnitude_standard_deviation"                
[39] "time_body_angular_acceleration_magnitude_mean"                   
[40] "time_body_angular_acceleration_magnitude_standard_deviation"     
[41] "frequency_body_acceleration_mean_x"                              
[42] "frequency_body_acceleration_mean_y"                              
[43] "frequency_body_acceleration_mean_z"                              
[44] "frequency_body_acceleration_standard_deviation_x"                
[45] "frequency_body_acceleration_standard_deviation_y"                
[46] "frequency_body_acceleration_standard_deviation_z"                
[47] "frequency_body_linear_acceleration_mean_x"                       
[48] "frequency_body_linear_acceleration_mean_y"                       
[49] "frequency_body_linear_acceleration_mean_z"                       
[50] "frequency_body_linear_acceleration_standard_deviation_x"         
[51] "frequency_body_linear_acceleration_standard_deviation_y"         
[52] "frequency_body_linear_acceleration_standard_deviation_z"         
[53] "frequency_body_gyroscope_mean_x"                                 
[54] "frequency_body_gyroscope_mean_y"                                 
[55] "frequency_body_gyroscope_mean_z"                                 
[56] "frequency_body_gyroscope_standard_deviation_x"                   
[57] "frequency_body_gyroscope_standard_deviation_y"                   
[58] "frequency_body_gyroscope_standard_deviation_z"                   
[59] "frequency_body_acceleration_magnitude_mean"                      
[60] "frequency_body_acceleration_magnitude_standard_deviation"        
[61] "frequency_body_linear_acceleration_magnitude_mean"               
[62] "frequency_body_linear_acceleration_magnitude_standard_deviation" 
[63] "frequency_body_gyroscope_magnitude_mean"                         
[64] "frequency_body_gyroscope_magnitude_standard_deviation"           
[65] "frequency_body_angular_acceleration_magnitude_mean"              
[66] "frequency_body_angular_acceleration_magnitude_standard_deviation"

## Processing and tidying the data

The code run_analysis.R takes the dataframe containing the above variables and sorts the rows (observations) by activity and subject (this gives approximately 50 observations per activity-subject pair, but this is not fixed). The data are then split by both these variables.
A mean value of each varable is than calculated for each unique combination of activity and subject.
The mean values are recorded in a data frame, in which the first two columns specify the activity and subject, and the remaining 66 columns contain variables 1-66.




