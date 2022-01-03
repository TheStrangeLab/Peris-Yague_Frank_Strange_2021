# Peris-Yague, Frank, Strange, 2021

To preprocess the raw data and re-organize the data run:
- v1SOA_preprocessing_alldata
- v1SOA_preprocessing_CRP

This will create output matrices that will be saved in the code folder and later called for the analyses. 

You must also download this toolbox: http://memory.psych.upenn.edu/Behavioral_toolbox
Some of the analyses use functions from the toolbox, for which, the path in Matlab must be changed.

The following scripts allow you to obtain the results. The raw results will be .csv files which are saved in Raw_Results and will later be used in an R notebook to run the statistics and obtain the figures. 

- v1RelativeRecall.m
- v1_Score_Recall.m (overall normalized recall)
- v1_Score_Recall_SOA.m (calculates normalized recall by SOA, the SOA number needs to be changed manually at the beginning of the code)
- CRP_lag_analyses.m (to obtain the overall CRP i.e including all trials, to compare remembered v. forgotten oddball trials and to obtain the CRPs in transitions to and from the oddballs)

Once the above scripts have all been run, to obtain the statistical results and the figures run the following R markdown in the 'Results' folder.
- stats_figures.Rmd
