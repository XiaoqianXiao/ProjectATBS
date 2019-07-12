#!usr/bin/env Rscript
gen_counfouds <- function (datadir,subID,sesectionc,task){
setwd(resultdir1) 
ori_conf_filename <- paste(subID,"_",section,"_",task,"_desc-confounds_regressors.tsv",sep="")
conf_filename <- paste(subID,"_",section,"_",task,"_bold_confounds.tsv",sep="")
ori_confounds <- paste(datadir, ori_conf_filename, sep="/")
data <- read.csv(ori_confounds,sep="\t")
NonSteady <- names(data)[grepl("non_steady",names(data))]
Num_Nonsteady <- max(as.numeric(gsub("non_steady_state_outlier","",NonSteady))) + 1
L_RotZ <- grep("rot_z",names(data))
L_X <- L_RotZ-5
L_FD <- grep("framewise_displacement",names(data))
L_WM <- grep("white_matter",names(data))
min_CompCor <- min(grep("a_comp_cor",names(data)))
max_CompCor <- max(grep("comp_cor",names(data)))
#min_Aroma <- min(grep("AROMA",names(data)))
#max_Aroma <- max(grep("AROMA",names(data)))
#s_Aroma <- max_Aroma-min_Aroma+1
FD <- as.numeric(as.character(data$framewise_displaceme))
FD_surviver <- which(FD <= 0.2)
trim_surviver <- FD_surviver[FD_surviver > Num_Nonsteady]
#data$FD <- as.numeric(as.character(data$FramewiseDisplaceme))
#confounds1 <- data[c((Num_Nonsteady+1):(dim(data)[1])),c(min_CompCor,L_FD,L_X:L_RotZ)]
#confounds2 <- data[c((Num_Nonsteady+1):(dim(data)[1])),c(min_Aroma:max_Aroma,L_WM,min_CompCor)]
#IC <- c(1:(s_Aroma+2))
confounds1 <- data[trim_surviver,c(min_CompCor,L_FD,L_X:L_RotZ)]
confounds2 <- data[trim_surviver,c(L_WM, min_CompCor)]
write.table(confounds1, sep="\t", file=paste(resultdir1,conf_filename,sep="/"), row.names=FALSE, col.names=TRUE)
write.table(confounds2, sep="\t", file=paste(resultdir2,conf_filename,sep="/"), row.names=FALSE, col.names=TRUE)
#write.table(IC, sep="\t", file=paste(resultdir2,IC_filename,sep="/"), row.names=FALSE, col.names=TRUE)
}
