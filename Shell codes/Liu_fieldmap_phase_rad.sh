#!/bin/bash

#################################################
# stand2fun roi maker
# flirt   -ref  -in  -out -init .mat -applyxfm
#################################################


for ith_sub in {21..35}; do

  fieldmap_phase_ima="/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_fieldmap_pha/sub"$ith_sub"_fieldmap_pha.nii.gz"
  fieldmap_mag_ima="/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_fieldmap_mag/sub"$ith_sub"_fieldmap_mag_brain.nii.gz"
  output_ima="/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_fieldmap_pha/sub"$ith_sub"_fieldmap_pha_rad.nii.gz"
  fsl_prepare_fieldmap SIEMENS $fieldmap_phase_ima $fieldmap_mag_ima $output_ima 2.46

done
