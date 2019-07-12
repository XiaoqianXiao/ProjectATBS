#!usr/bin/env Rscript
#blind study to open label: 202, 203, 204
## sub-019 1m resting dcm img could not be convert to nii
library(icesTAF)
sub_list <- c(1, 2, 3, 4, 11, 14, 16, 18, 19, 21, 24, 26, 28, 29, 31, 33, 34, 35, 36, 38, 39, 41, 42, 43, 44, 202, 203, 204)
#subs have baseline and 1w
sub_list_2sec <- c(1, 3, 11, 14, 16, 18, 19, 24, 33, 38, 41, 44)
#subs have baseline, 1w and 1m
#sub_list_3sec <- c(2, 4, 21, 26, 28, 29, 31, 34, 35, 36, 39, 42, 43, 202, 203, 204)
sub_list_3sec <- setdiff(sub_list, sub_list_2sec)
#subs use retreatment
sub_list_2nd <- c(21, 38)
#subs use the ori treatment
sub_list_1st <- setdiff(sub_list, sub_list_2nd)

#set up DIRs
basedir <- c("/Users/xiaoqian/Projects/aTBS/derivatives/study-open")
resultdir1 <- paste(basedir,"behav/confounds/basic",sep="/")
resultdir2 <- paste(basedir,"behav/confounds/Aroma",sep="/")
mkdir(resultdir1)
mkdir(resultdir2)

#set task
ta <- c('resting')
task <- paste("task-",ta, sep="")
#run according to wanted scans
for (sub in sub_list){
    #set subID
    if (sub < 10) {
        subID <- paste("sub-00",sub, sep="")
        } else if (sub < 100 & sub >= 10) {
        subID <- paste("sub-0",sub, sep="")
        } else {
        subID <- paste("sub-",sub, sep="")
    } #if
    if (sub %in% sub_list_3sec & sub %in% sub_list_1st) {
        for (sec in c("baseline", "1w", "1m")){
            section <- paste("ses-",sec, sep="")
            datadir <- paste(basedir,"fmriprep/treat-1st",subID,section,'func',sep="/")
            gen_counfouds(datadir,subID,sesectionc,task)
        }#fore
    } else if (sub %in% sub_list_3sec & sub %in% sub_list_2nd) {
        for (sec in c("baseline", "1w", "1m")){
            section <- paste("ses-",sec, sep=""
            datadir <- paste(basedir,"fmriprep/treat-2nd",subID,section,'func',sep="/")
            gen_counfouds(datadir,subID,sesectionc,task)
        }#for
    } else if (sub %in% sub_list_2sec & sub %in% sub_list_1st) {
        for (sec in c("baseline", "1w")){
            section <- paste("ses-",sec, sep="")
            datadir <- paste(basedir,"fmriprep/treat-1st",subID,section,'func',sep="/")
            gen_counfouds(datadir,subID,sesectionc,task)
        }#for
    } else if (sub %in% sub_list_2sec & sub %in% sub_list_2nd) {
        for (sec in c("baseline", "1w")){
            section <- paste("ses-",sec, sep="")
            datadir <- paste(basedir,"fmriprep/treat-2nd",subID,section,'func',sep="/")
            gen_counfouds(datadir,subID,sesectionc,task)
        } #for
    } #if
} # for all sub list
