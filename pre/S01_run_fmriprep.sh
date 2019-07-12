BaseDir='/Users/xiaoqian/Projects/aTBS'
WorkDir=${BaseDir}/work
FreesuferLicsensePath=/Users/xiaoqian/tools/freesurfer
NipVersion='1.2.3'
##1st open-treat1 41 44
DataDir=${BaseDir}/source/study-open/treat-1st
OutputDir=${BaseDir}/derivatives/study-open/treat-1st
for i in 41 44
do
	if [ ${i} -lt 10 ]
	then
		subID=00${i}
	else
		subID=0${i}
	fi
	echo ${subID}
	docker run -ti --rm \
	-v $DataDir:/data:ro -v $OutputDir:/ \
	-v $WorkDir:/work -v $FreesuferLicsensePath/license.txt:/opt/freesurfer/license.txt \
	poldracklab/fmriprep:$NipVersion /data /out/out participant \
	-w /work \
	-t resting \
	--ignore fieldmaps --ignore slicetiming --no-freesurfer \
	--longitudinal \
	--use-aroma --ignore-aroma-denoising-errors \
	--template-resampling-grid 2mm \
	--participant_label sub-$subID \
	--fs-license-file /opt/freesurfer/license.txt --low-mem \
	--nthreads 16 --omp-nthreads 2
done
