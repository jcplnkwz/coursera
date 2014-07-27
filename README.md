Files in this repository:

README.md : list of files in repo and brief description of their content.

codebook.md : contains informations on tidy data set variables, as well as informations about raw data and the transformations performed.

run\_analysis.R : the actual R script to perform the analysis (it will also download and unzip the project raw data. If you already have them, just change directory names in read.table functions and remove the first few lines of the script).

tidy\_dataset.txt: the tidy dataset required for the project (in Coursera submission form uploaded as "tidy-lenkowicz.txt"



N.B: to read tidy_dataset.txt into R use read.table(".../tidy_dataset.txt", header=TRUE), so that [1,1]=1 and [1,2]=WALKING
