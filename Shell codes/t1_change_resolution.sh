#!/bin/bash


fslreorient2std /Users/boo/Desktop/s0mask.nii  /Users/boo/Desktop/ttts0mask.nii

flirt -in /Users/boo/Desktop/saaa01_ISO_IIHC_TAL.nii -ref /Users/boo/Desktop/fmri_script/brainmask/original_ima/MNI152_T1_2mm_template.nii -out /Users/boo/Desktop/ttt1.nii -omat /Users/boo/Desktop/ttt1.mat -dof 6


flirt -in /Users/boo/Desktop/ttts0mask.nii -ref /Users/boo/Desktop/fmri_script/brainmask/original_ima/MNI152_T1_2mm_template.nii -out /Users/boo/Desktop/tttmask.nii -init /Users/boo/Desktop/ttt1.mat -applyxfm
