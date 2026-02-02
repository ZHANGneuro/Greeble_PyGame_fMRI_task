#!/bin/bash



# # 2024-04-11
# # convert mgh
# cur_path=/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj
# mri_vol2surf --mov $cur_path/Corr_bin10_g123_freq6_ws0_clustere_corrp_tstat1_binary_wr_c30r.nii.gz --surf white --reg /Applications/freesurfer/7.3.2/subjects/register_2mm.dat --hemi "lh" --out $cur_path/fs_g123_freq6_binary_l.mgh
# mri_vol2surf --mov $cur_path/Corr_bin10_g123_freq6_ws0_clustere_corrp_tstat1_binary_wr_c30r.nii.gz --surf white --reg /Applications/freesurfer/7.3.2/subjects/register_2mm.dat --hemi "rh" --out $cur_path/fs_g123_freq6_binary_r.mgh

# mri_vol2surf --mov $cur_path/Corr_bin10_g123_freq3_ws0_clustere_corrp_tstat1_binary_wr_c30r.nii.gz --surf white --reg /Applications/freesurfer/7.3.2/subjects/register_2mm.dat --hemi "lh" --out $cur_path/fs_g123_freq3_binary_l.mgh
# mri_vol2surf --mov $cur_path/Corr_bin10_g123_freq3_ws0_clustere_corrp_tstat1_binary_wr_c30r.nii.gz --surf white --reg /Applications/freesurfer/7.3.2/subjects/register_2mm.dat --hemi "rh" --out $cur_path/fs_g123_freq3_binary_r.mgh


# input_l=$cur_path/fs_g123_freq6_binary_l.mgh
# output_l=$cur_path/fs_g123_freq6_binary_l_label.mgh
# mri_cor2label --i $input_l --id 1 --l $output_l --surf mni "lh" 

# input_r=$cur_path/fs_g123_freq6_binary_r.mgh
# output_r=$cur_path/fs_g123_freq6_binary_r_label.mgh
# mri_cor2label --i $input_r --id 1 --l $output_r --surf mni "rh" 

# input_l=$cur_path/fs_g123_freq3_binary_l.mgh
# output_l=$cur_path/fs_g123_freq3_binary_l_label.mgh
# mri_cor2label --i $input_l --id 1 --l $output_l --surf mni "lh" 

# input_r=$cur_path/fs_g123_freq3_binary_r.mgh
# output_r=$cur_path/fs_g123_freq3_binary_r_label.mgh
# mri_cor2label --i $input_r --id 1 --l $output_r --surf mni "rh" 



# # convert mgh
# export_path=/Users/bo/Documents/data_liujia_lab/exp_greeble/MRI_results_formal/
# for ith in {7..9}
# do
#   lh_path=$export_path"unc_periodic_2205_testing_"$ith"_fieldmap__hpcOused_lh.mgh"
#   rh_path=$export_path"unc_periodic_2205_testing_"$ith"_fieldmap__hpcOused_rh.mgh"
#   freeview -f /Users/bo/freesurfer/subjects/freesurfer_subject_MRI/surf/lh.inflated:curvature_method=binary:color=255,255,225:overlay=$lh_path:overlay_threshold=0.95,0.975,0.99:label="/Users/bo/freesurfer/subjects/freesurfer_subject_MRI/label/lh.entorhinal_exvivo.label":label_outline=true:label_color=blue -ss "/Users/bo/Documents/data_liujia_lab/AI_figures/freesurfer_grid/lh_medial_"$ith"_hpc_Oused.png" -viewsize 900 700 -view medial -zoom 1.5 -cam Azimuth -10 Dolly 1 Elevation -30
#   # freeview -f /Users/bo/freesurfer/subjects/freesurfer_subject_MRI/surf/lh.inflated:curvature_method=binary:color=255,255,225:overlay=$lh_path:overlay_threshold=0.95,0.975,0.99:label="/Users/bo/freesurfer/subjects/freesurfer_subject_MRI/label/lh.entorhinal_exvivo.label":label_outline=true:label_color=blue -ss "/Users/bo/Documents/data_liujia_lab/AI_figures/freesurfer_grid/lh_superior_"$ith"_hpc_Oused.png" -viewsize 900 700 -view superior -zoom 1.5
#
#   # freeview -f /Users/bo/freesurfer/subjects/freesurfer_subject_MRI/surf/rh.inflated:curvature_method=binary:color=255,255,225:overlay=$rh_path:overlay_threshold=0.95,0.975,0.99:label="/Users/bo/freesurfer/subjects/freesurfer_subject_MRI/label/rh.entorhinal_exvivo.label":label_outline=true:label_color=blue -ss "/Users/bo/Documents/data_liujia_lab/AI_figures/freesurfer_grid/rh_medial_"$ith"_hpc_Oused.png" -viewsize 900 700 -view medial -zoom 1.5 -cam Azimuth -10 Dolly 1 Elevation -30
#   # freeview -f /Users/bo/freesurfer/subjects/freesurfer_subject_MRI/surf/rh.inflated:curvature_method=binary:color=255,255,225:overlay=$rh_path:overlay_threshold=0.95,0.975,0.99:label="/Users/bo/freesurfer/subjects/freesurfer_subject_MRI/label/rh.entorhinal_exvivo.label":label_outline=true:label_color=blue -ss "/Users/bo/Documents/data_liujia_lab/AI_figures/freesurfer_grid/rh_superior_"$ith"_hpc_Oused.png" -viewsize 900 700 -view lateral -zoom 1.5
# done
#



# 6-fold
# left brain
SUBJECTS_DIR="/Applications/freesurfer/7.3.2/subjects"
LABEL_DIR="$SUBJECTS_DIR/mni/label"
SURF="$SUBJECTS_DIR/mni/surf/lh.inflated"
CMD="freeview -f ${SURF}:curvature_method=binary:curvature_setting=-1:color=255,255,225:label=/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj/fs_g123_freq6_binary_l_label.mgh.label:label_color=red"
for LABEL in "$LABEL_DIR"/lh.aparc.DKTatlas.annot-*label; do
    CMD="${CMD}:label=${LABEL}:label_outline=true:label_color=160,160,160"
done
CMD="${CMD} -ss /Users/bo/Desktop/6fold_lh_medial.png -view medial -zoom 1 -viewport 3d -cam Azimuth 15 Dolly 1.8 Elevation -30 Roll 20"
echo "$CMD"
eval "$CMD"

SUBJECTS_DIR="/Applications/freesurfer/7.3.2/subjects"
LABEL_DIR="$SUBJECTS_DIR/mni/label"
SURF="$SUBJECTS_DIR/mni/surf/lh.inflated"
CMD="freeview -f ${SURF}:curvature_method=binary:curvature_setting=-1:color=255,255,225:label=/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj/fs_g123_freq6_binary_l_label.mgh.label:label_color=red"
for LABEL in "$LABEL_DIR"/lh.aparc.DKTatlas.annot-*label; do
    CMD="${CMD}:label=${LABEL}:label_outline=true:label_color=160,160,160"
done
CMD="${CMD} -ss /Users/bo/Desktop/6fold_lh_lateral.png -view lateral -zoom 1 -viewport 3d -cam Azimuth -5 Dolly 1.5 Elevation 30 Roll 5" 
echo "$CMD"
eval "$CMD"

# right brain
SUBJECTS_DIR="/Applications/freesurfer/7.3.2/subjects"
LABEL_DIR="$SUBJECTS_DIR/mni/label"
SURF="$SUBJECTS_DIR/mni/surf/rh.inflated"
CMD="freeview -f ${SURF}:curvature_method=binary:curvature_setting=-1:color=255,255,225:label=/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj/fs_g123_freq6_binary_r_label.mgh.label:label_color=red"
for LABEL in "$LABEL_DIR"/rh.aparc.DKTatlas.annot-*label; do
    CMD="${CMD}:label=${LABEL}:label_outline=true:label_color=160,160,160"
done
CMD="${CMD} -ss /Users/bo/Desktop/6fold_rh_medial.png -view medial -zoom 1 -viewport 3d -cam Azimuth -15 Dolly 1.8 Elevation -30 Roll -20"
echo "$CMD"
eval "$CMD"

SUBJECTS_DIR="/Applications/freesurfer/7.3.2/subjects"
LABEL_DIR="$SUBJECTS_DIR/mni/label"
SURF="$SUBJECTS_DIR/mni/surf/rh.inflated"
CMD="freeview -f ${SURF}:curvature_method=binary:curvature_setting=-1:color=255,255,225:label=/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj/fs_g123_freq6_binary_r_label.mgh.label:label_color=red"
for LABEL in "$LABEL_DIR"/rh.aparc.DKTatlas.annot-*label; do
    CMD="${CMD}:label=${LABEL}:label_outline=true:label_color=160,160,160"
done
CMD="${CMD} -ss /Users/bo/Desktop/6fold_rh_lateral.png -view lateral -zoom 1 -viewport 3d -cam Azimuth 5 Dolly 1.5 Elevation 30 Roll -5" 
echo "$CMD"
eval "$CMD"



# 3-fold
# left brain
SUBJECTS_DIR="/Applications/freesurfer/7.3.2/subjects"
LABEL_DIR="$SUBJECTS_DIR/mni/label"
SURF="$SUBJECTS_DIR/mni/surf/lh.inflated"
CMD="freeview -f ${SURF}:curvature_method=binary:curvature_setting=-1:color=255,255,225:label=/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj/fs_g123_freq3_binary_l_label.mgh.label:label_color=red"
for LABEL in "$LABEL_DIR"/lh.aparc.DKTatlas.annot-*label; do
    CMD="${CMD}:label=${LABEL}:label_outline=true:label_color=160,160,160"
done
CMD="${CMD} -ss /Users/bo/Desktop/3fold_lh_medial.png -view medial -zoom 1 -viewport 3d -cam Azimuth 15 Dolly 1.8 Elevation -30 Roll 20"
echo "$CMD"
eval "$CMD"

SUBJECTS_DIR="/Applications/freesurfer/7.3.2/subjects"
LABEL_DIR="$SUBJECTS_DIR/mni/label"
SURF="$SUBJECTS_DIR/mni/surf/lh.inflated"
CMD="freeview -f ${SURF}:curvature_method=binary:curvature_setting=-1:color=255,255,225:label=/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj/fs_g123_freq3_binary_l_label.mgh.label:label_color=red"
for LABEL in "$LABEL_DIR"/lh.aparc.DKTatlas.annot-*label; do
    CMD="${CMD}:label=${LABEL}:label_outline=true:label_color=160,160,160"
done
CMD="${CMD} -ss /Users/bo/Desktop/3fold_lh_lateral.png -view lateral -zoom 1 -viewport 3d -cam Azimuth -5 Dolly 1.5 Elevation 30 Roll 5" 
echo "$CMD"
eval "$CMD"

# right brain
SUBJECTS_DIR="/Applications/freesurfer/7.3.2/subjects"
LABEL_DIR="$SUBJECTS_DIR/mni/label"
SURF="$SUBJECTS_DIR/mni/surf/rh.inflated"
CMD="freeview -f ${SURF}:curvature_method=binary:curvature_setting=-1:color=255,255,225:label=/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj/fs_g123_freq3_binary_r_label.mgh.label:label_color=red"
for LABEL in "$LABEL_DIR"/rh.aparc.DKTatlas.annot-*label; do
    CMD="${CMD}:label=${LABEL}:label_outline=true:label_color=160,160,160"
done
CMD="${CMD} -ss /Users/bo/Desktop/3fold_rh_medial.png -view medial -zoom 1 -viewport 3d -cam Azimuth -15 Dolly 1.8 Elevation -30 Roll -20"
echo "$CMD"
eval "$CMD"

SUBJECTS_DIR="/Applications/freesurfer/7.3.2/subjects"
LABEL_DIR="$SUBJECTS_DIR/mni/label"
SURF="$SUBJECTS_DIR/mni/surf/rh.inflated"
CMD="freeview -f ${SURF}:curvature_method=binary:curvature_setting=-1:color=255,255,225:label=/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj/fs_g123_freq3_binary_r_label.mgh.label:label_color=red"
for LABEL in "$LABEL_DIR"/rh.aparc.DKTatlas.annot-*label; do
    CMD="${CMD}:label=${LABEL}:label_outline=true:label_color=160,160,160"
done
CMD="${CMD} -ss /Users/bo/Desktop/3fold_rh_lateral.png -view lateral -zoom 1 -viewport 3d -cam Azimuth 5 Dolly 1.5 Elevation 30 Roll -5" 
echo "$CMD"
eval "$CMD"




#   cur_path=/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj
#   freeview -f /Applications/freesurfer/7.3.2/subjects/mni/surf/rh.inflated:curvature_method=binary:label="/Applications/freesurfer/7.3.2/subjects/mni/label/rh.entorhinal_exvivo.label":label_outline=true:label_color=black:label="/Applications/freesurfer/7.3.2/subjects/mni/label/rh.entorhinal_exvivo.label":label_outline=true:label_color=black -ss /Users/bo/Desktop/aaa.png -view medial -zoom 1.5 -cam Azimuth 20 Dolly 1 Elevation -20 Roll 0
#   freeview -f /Applications/freesurfer/7.3.2/subjects/mni/surf/rh.inflated:curvature_method=binary:color=255,255,225:offset=0,0,45:overlay=$export_path$file_name".mgh":overlay_custom=1,255,0,0:label="/Users/bo/freesurfer/subjects/fsaverage/label/rh.entorhinal_exvivo.label":label_outline=true:label_color=blue -ss $export_path2$file_name".png" -view medial -zoom 3.5 -cam Azimuth 20 Dolly 1 Elevation -20 Roll 0


# mri_annotation2label --subject mni \
#   --hemi rh \
#   --labelbase /Applications/freesurfer/7.3.2/subjects/mni/label/rh.aparc.DKTatlas.annot
# mri_annotation2label --subject mni \
#   --hemi lh \
#   --labelbase /Applications/freesurfer/7.3.2/subjects/mni/label/lh.aparc.DKTatlas.annot



