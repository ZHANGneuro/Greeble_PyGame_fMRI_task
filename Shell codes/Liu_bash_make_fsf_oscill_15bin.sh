#!/bin/bash
declare -a volume_num_pool
declare -a voxel_num_pool
volume_num_pool[1]=1937
volume_num_pool[2]=1940
volume_num_pool[3]=1936
volume_num_pool[4]=1936
volume_num_pool[5]=1937
volume_num_pool[6]=1934
volume_num_pool[7]=1936
volume_num_pool[8]=1936
volume_num_pool[9]=1935
volume_num_pool[10]=1933
volume_num_pool[11]=1950
volume_num_pool[12]=1935
volume_num_pool[13]=1939
volume_num_pool[14]=1950
volume_num_pool[15]=1930
volume_num_pool[16]=1969
volume_num_pool[17]=1944
volume_num_pool[18]=1935
volume_num_pool[19]=2013
volume_num_pool[20]=1959
voxel_num_pool[1]=1506459136
voxel_num_pool[2]=1508792320
voxel_num_pool[3]=1505681408
voxel_num_pool[4]=1505681408
voxel_num_pool[5]=1506459136
voxel_num_pool[6]=1504125952
voxel_num_pool[7]=1505681408
voxel_num_pool[8]=1505681408
voxel_num_pool[9]=1504903680
voxel_num_pool[10]=1503348224
voxel_num_pool[11]=1516569600
voxel_num_pool[12]=1504903680
voxel_num_pool[13]=1508014592
voxel_num_pool[14]=1516569600
voxel_num_pool[15]=1501015040
voxel_num_pool[16]=1531346432
voxel_num_pool[17]=1511903232
voxel_num_pool[18]=1504903680
voxel_num_pool[19]=1565566464
voxel_num_pool[20]=1523569152


# generated on mac, path are for server
# mac

for sub in {1..20}; do
  NUM_VOLUME=${volume_num_pool[$sub]}
  NUM_VOXEL=${voxel_num_pool[$sub]}

    if [ $sub -eq 1 ];then
        ith_sub_str='01'
    fi
    if [ $sub -eq 2 ];then
        ith_sub_str='02'
    fi
    if [ $sub -eq 3 ];then
        ith_sub_str='03'
    fi
    if [ $sub -eq 4 ];then
        ith_sub_str='04'
    fi
    if [ $sub -eq 5 ];then
        ith_sub_str='05'
    fi
    if [ $sub -eq 6 ];then
        ith_sub_str='06'
    fi
    if [ $sub -eq 7 ];then
        ith_sub_str='07'
    fi
    if [ $sub -eq 8 ];then
        ith_sub_str='08'
    fi
    if [ $sub -eq 9 ];then
        ith_sub_str='09'
    fi
    if [ $sub -eq 10 ];then
        ith_sub_str='10'
    fi
    if [ $sub -eq 11 ];then
        ith_sub_str='11'
    fi
    if [ $sub -eq 12 ];then
        ith_sub_str='12'
    fi
    if [ $sub -eq 13 ];then
        ith_sub_str='13'
    fi
    if [ $sub -eq 14 ];then
        ith_sub_str='14'
    fi
    if [ $sub -eq 15 ];then
        ith_sub_str='15'
    fi
    if [ $sub -eq 16 ];then
        ith_sub_str='16'
    fi
    if [ $sub -eq 17 ];then
        ith_sub_str='17'
    fi
    if [ $sub -eq 18 ];then
        ith_sub_str='18'
    fi
    if [ $sub -eq 19 ];then
        ith_sub_str='19'
    fi
    if [ $sub -eq 20 ];then
        ith_sub_str='20'
    fi

    server_root="/data0/home/liulab/fMRI_Liujia"
    TEMPLATE_PATH="/Users/bo/Documents/bash_script/batch_oscill_fieldmap_template.fsf"
    OUTPUTDIR=$server_root"/liujia_pilot_sub"$ith_sub_str"/oscill_fieldmap_obj"
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
    -e 's@BOLD_IMAGE@'$BOLD_IMAGE'@g' <$TEMPLATE_PATH> /Users/bo/Documents/bash_script/template_liujia_osci/fsf_sub$sub".fsf"
done
