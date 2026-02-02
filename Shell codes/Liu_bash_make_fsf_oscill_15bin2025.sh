#!/bin/bash
declare -a volume_num_pool
declare -a voxel_num_pool
volume_num_pool[21]=1965
volume_num_pool[22]=2116
volume_num_pool[23]=1994
volume_num_pool[24]=1988
volume_num_pool[25]=2003
volume_num_pool[26]=2056
volume_num_pool[27]=2043
volume_num_pool[28]=2075
volume_num_pool[29]=1949
volume_num_pool[30]=1940
volume_num_pool[31]=1941
volume_num_pool[32]=2005
volume_num_pool[33]=1950
volume_num_pool[34]=2018
volume_num_pool[35]=1947
voxel_num_pool[21]=1528235520
voxel_num_pool[22]=1645672448
voxel_num_pool[23]=1550789632
voxel_num_pool[24]=1546123264
voxel_num_pool[25]=1557789184
voxel_num_pool[26]=1599008768
voxel_num_pool[27]=1588898304
voxel_num_pool[28]=1613785600
voxel_num_pool[29]=1515791872
voxel_num_pool[30]=1508792320
voxel_num_pool[31]=1509570048
voxel_num_pool[32]=1559344640
voxel_num_pool[33]=1516569600
voxel_num_pool[34]=1569455104
voxel_num_pool[35]=1514236416

# generated on mac, path are for server
for sub in 27 29; do
  NUM_VOLUME=${volume_num_pool[$sub]}
  NUM_VOXEL=${voxel_num_pool[$sub]}

    server_root="/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble"
    TEMPLATE_PATH="/Users/bo/Documents/script_bash/batch_oscill_fieldmap_template_bin15.fsf"
    OUTPUTDIR=$server_root"/liujia_formal_sub"$sub"/oscill_fieldmap_obj_bin15"
    T1_IMAGE=$server_root"/MRI_raw_t1/sub"$sub"_t1_brain"
    BOLD_IMAGE=$server_root"/MRI_raw_bold_4d_session_connected/bold_4d_all_session_sub"$sub".nii.gz"
    Slice_Timing_file=$server_root"/slice_timing_file.txt"
    Standard_brain_dir=$server_root"/brainmask/fsl_standard/MNI152_T1_2mm_brain"
    field_map_phase=$server_root"/MRI_fieldmap_pha/sub"$sub"_fieldmap_pha_rad.nii.gz"
    field_map_mag=$server_root"/MRI_fieldmap_mag/sub"$sub"_fieldmap_mag_brain.nii.gz"

    sed -e 's@OUTPUTDIR@'$OUTPUTDIR'@g' \
    -e 's@SUBNO@'$sub'@g' \
    -e 's@NUM_VOLUME@'$NUM_VOLUME'@g' \
    -e 's@NUM_VOXEL@'$NUM_VOXEL'@g' \
    -e 's@T1_IMAGE@'$T1_IMAGE'@g' \
    -e 's@server_root@'$server_root'@g' \
    -e 's@field_map_phase@'$field_map_phase'@g' \
    -e 's@field_map_mag@'$field_map_mag'@g' \
    -e 's@Slice_Timing_file@'$Slice_Timing_file'@g' \
    -e 's@Standard_brain_dir@'$Standard_brain_dir'@g' \
    -e 's@BOLD_IMAGE@'$BOLD_IMAGE'@g' <$TEMPLATE_PATH> /Users/bo/Documents/script_bash/template_osci2025/fsf_osci_bin15_sub$sub".fsf"
done
