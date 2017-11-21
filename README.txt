WIRE RESISTIVITY README

ABOUT:
This read me file provides information regarding the matlab files created by Malfy Das (malfrine@ualberta.ca) in Nov. 2017 to perform curve fitting on a wire resistivity dataset. The optimization scripts are a modification of the scripts developed by Vinay Bavdekar. Dr. Vinay Prasad and Dr. Patricio Mendez provided the dataset and consulted on the optimization algorithm used.

SCRIPT FILES (LISTED IN ORDER OF USE):
1) get_file_loc.cmd - gets a list of all the .xlsx files in current folder and subfolders. Prints results to "locs.txt"

2) data_pull.m - pulls the raw data from .xlsx files isted in "locs.txt" and saves it as a matlab structure "s.mat"

3) getTrimTime.m - a console application that allows the user to efficiently determine the start and end points of the raw data set. when you run the application, relevant graphs will be shown for each dataset. Based on the relevant graphs, the user will input various parameters to the console and the script will calculate the appropriate start and end times of the dataset. these values will then be saved to "graphRead.mat"

4) data_clean.m - using "s.mat" and "graphRead.mat" relevant variables are calculated and stored in "u.mat". Additionally, another strucutre named "t.mat" is saved.  This file contains the same data as "u.mat" except all the experimental runs of each data type (i.e. ER309LSi-Asdrawn,  ER70S-6-Asdrawn) are consolidate together. The resistivity interpolation is also calculated in this file. Please note that both "u.mat" and "s.mat" are ~1GB each. Please ensure you have approximately 2.5 GB of storage space before you run this script.

5) opt_u.m - curve fitting of "u.mat." The curve fitting itself is quite complicated. Please consult the corresponding publication by Dr. Mendez and Dr. Prasad for details. In essence, it is just a spline fitting. The script takes approximately 6 days to perform the curve fitting procedure for 55 * 10 datasets. The results of the curve fitting are saved in the Matlab structure "usol.mat".

6) usol_export.m - the "usol.mat" solution is analyzed and exported to and excel and a matlab table file "usol_Table.mat"

Note:
- There were additional matlab helper functions that were written to assist the script files. I have named them in such a way that they are self-explanatory. I hope that it makes sense to you.
- Please create the folders labelled "fig1", "fig2", and "fig3." If not the matlab figures will not be saved and an exception will be thrown.
