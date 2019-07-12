# ProjectATBS
Scripts for resting state data of project aiTBS.
Mainly base on fmriprep (https://fmriprep.readthedocs.io/en/stable/usage.html).
## steps:
1. bash S01_run_fmriprep.sh
* This will generate a confounds TVS table for each data set.
* Change variables in line1 to line 8 according to your setting of path and subjects you want to process.
* You could want to change the setting of fmriprep accoudding to needs (please refer https://fmriprep.readthedocs.io/en/stable/usage.html for details).
2. run S02_gen_confounds.R
* collect confounds you want to use for denoising.
3. run S03_trim.py
* get rid of: 1) non steady volumes; and 2) fd > .2 volumes.
4. bash S04_Denoise_glm.sh
*  nuisance signal regression with signals from white matter and cerebrospinal fluid on results after ICA-AROMA.
## nilearn was used for further analysis.  
brain_masker = NiftiMapsMasker(
        maps_img=atlas_filename, memory='nilearn_cache', verbose=5,
        smoothing_fwhm=6,
        allow_overlap=True,
        detrend=True, standardize=True, low_pass=0.1, high_pass=0.01, t_r=2)
