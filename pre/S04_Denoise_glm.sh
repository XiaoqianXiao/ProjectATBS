#!/bin/bash
baseDir='/Users/xiaoqian/Projects/aTBS/derivatives/study-open'
dataDir=${baseDir}/trimmed/Aroma
confoundDir=${baseDir}/behav/confounds/Aroma
cd ${dataDir}
resultDir=${baseDir}/glmresulsAfterDenoised/Aroma
resDir=${baseDir}/denoised/Aroma
mkdir -p ${resultDir} ${resDir}
for i in *.nii.gz
do
    file_name=${i}
    sub=`echo $i|cut -d "_" -f1`
    ses=`echo $i|cut -d "_" -f2`
    task=`echo $i|cut -d "_" -f3`
    #regress out nuisance like WM
    confound_file=${confoundDir}/${sub}_${ses}_${task}_bold_confounds.tsv
    echo ${file_name}_glm
    fsl_glm -i ${file_name} -d ${confound_file} -o ${resultDir}/${file_name} --out_res=${resDir}/${file_name}
done
