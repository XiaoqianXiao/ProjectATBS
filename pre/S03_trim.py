#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import os.path as op
from glob import glob
import re
import pandas as pd
import numpy as np
import nibabel as ni
import nilearn

ProjDir = '/Users/xiaoqian/Projects/aTBS/derivatives/study-open'
#dataDir = os.path.join(ProjDir, 'fmriprep')
#dataDir = os.path.join(ProjDir, 'derivatives/fmriprep-NoAmoraICA')
confoundsDir = os.path.join(ProjDir, 'behav/confounds')
trimmedDir1 = os.path.join(ProjDir, 'trimmed/basic')
trimmedDir2 = os.path.join(ProjDir, 'trimmed/Aroma')

sub_list = np.array([1, 2, 3, 4, 11, 14, 16, 18, 19, 21, 24, 26, 28, 29, 31, 33, 34, 35, 36, 38, 39, 41, 42, 43, 44, 202, 203, 204])
sub_list_2nd = np.array([21, 38])
#sub_list_1st=np.array(list(set(sub_list)-set(sub_list_2nd)))

confounds_files = glob(op.join(confoundsDir,'basic/*_confounds.tsv'))
for confounds_filename in confounds_files:
    projectName = re.split(r'[/]', confounds_filename)[6]
    subID = re.split(r'[_]',re.split(r'[/]', confounds_filename)[-1])[0]
    ses = re.split(r'[_]',re.split(r'[/]', confounds_filename)[-1])[1]
    task = re.split(r'[_]',re.split(r'[/]', confounds_filename)[-1])[2]
    sub = int(re.split(r'[-]',subID)[1])
    if sub in sub_list_2nd:
        dataDir = os.path.join(ProjDir, 'fmriprep/treat-2nd')
    else:
        dataDir = os.path.join(ProjDir, 'fmriprep/treat-1st')  
    trim_surviver = op.join(confoundsDir,'trim-surviver_'+subID+'_'+ses+'_'+task+'.tsv')
    #fmri_filename1 = op.join(dataDir,subID,ses,'func',subID+'_'+ses+'_'+task+'_'+'bold_space-MNI152NLin2009cAsym_preproc.nii.gz')
    #fmri_filename2 = op.join(dataDir,subID,ses,'func',subID+'_'+ses+'_'+task+'_'+'bold_space-MNI152NLin2009cAsym_variant-smoothAROMAnonaggr_preproc.nii.gz')
    fmri_filename1 = op.join(dataDir,subID,ses,'func',subID+'_'+ses+'_'+task+'_'+'space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz')
    fmri_filename2 = op.join(dataDir,subID,ses,'func',subID+'_'+ses+'_'+task+'_'+'space-MNI152NLin2009cAsym_desc-smoothAROMAnonaggr_bold.nii.gz')
    trimmed_filename1 = op.join(trimmedDir1,subID+'_'+ses+'_'+task+'_'+'bold_space-MNI152NLin2009cAsym_preproc.nii.gz')
    trimmed_filename2 = op.join(trimmedDir2,subID+'_'+ses+'_'+task+'_'+'bold_space-MNI152NLin2009cAsym_preproc.nii.gz')

    #Discard nonStable volumes
    surviverNum = pd.read_table(trim_surviver, header=None)-1

    fourD_img1 = ni.load(fmri_filename1)
    trimmed_img1 = ni.Nifti1Image(fourD_img1.get_data()[:, :, :, surviverNum], fourD_img1.get_affine())
    ni.save(trimmed_img1, trimmed_filename1)

    fourD_img2 = ni.load(fmri_filename2)
    trimmed_img2 = ni.Nifti1Image(fourD_img2.get_data()[:, :, :, surviverNum], fourD_img2.get_affine())
    ni.save(trimmed_img2, trimmed_filename2)
