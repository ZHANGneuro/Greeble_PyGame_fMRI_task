#!/bin/bash

declare -a s1
s1[21]=245
s1[22]=277
s1[23]=251
s1[24]=258
s1[25]=243
s1[26]=262
s1[27]=248
s1[28]=320
s1[29]=244
s1[30]=243
s1[31]=242
s1[32]=304
s1[33]=241
s1[34]=249
s1[35]=242
s1_nv[21]=190543360
s1_nv[22]=215430656
s1_nv[23]=195209728
s1_nv[24]=200653824
s1_nv[25]=188987904
s1_nv[26]=203764736
s1_nv[27]=192876544
s1_nv[28]=248872960
s1_nv[29]=189765632
s1_nv[30]=188987904
s1_nv[31]=188210176
s1_nv[32]=236429312
s1_nv[33]=187432448
s1_nv[34]=193654272
s1_nv[35]=188210176
declare -a s2
s2[21]=261
s2[22]=265
s2[23]=246
s2[24]=244
s2[25]=244
s2[26]=242
s2[27]=243
s2[28]=272
s2[29]=243
s2[30]=243
s2[31]=241
s2[32]=241
s2[33]=252
s2[34]=244
s2[35]=242
s2_nv[21]=202987008
s2_nv[22]=206097920
s2_nv[23]=191321088
s2_nv[24]=189765632
s2_nv[25]=189765632
s2_nv[26]=188210176
s2_nv[27]=188987904
s2_nv[28]=211542016
s2_nv[29]=188987904
s2_nv[30]=188987904
s2_nv[31]=187432448
s2_nv[32]=187432448
s2_nv[33]=195987456
s2_nv[34]=189765632
s2_nv[35]=188210176
declare -a s3
s3[21]=248
s3[22]=252
s3[23]=254
s3[24]=245
s3[25]=246
s3[26]=259
s3[27]=246
s3[28]=262
s3[29]=247
s3[30]=243
s3[31]=243
s3[32]=242
s3[33]=243
s3[34]=242
s3[35]=251
s3_nv[21]=192876544
s3_nv[22]=195987456
s3_nv[23]=197542912
s3_nv[24]=190543360
s3_nv[25]=191321088
s3_nv[26]=201431552
s3_nv[27]=191321088
s3_nv[28]=203764736
s3_nv[29]=192098816
s3_nv[30]=188987904
s3_nv[31]=188987904
s3_nv[32]=188210176
s3_nv[33]=188987904
s3_nv[34]=188210176
s3_nv[35]=195209728
declare -a s4
s4[21]=244
s4[22]=243
s4[23]=249
s4[24]=263
s4[25]=255
s4[26]=246
s4[27]=258
s4[28]=245
s4[29]=242
s4[30]=241
s4[31]=241
s4[32]=242
s4[33]=243
s4[34]=248
s4[35]=241
s4_nv[21]=189765632
s4_nv[22]=188987904
s4_nv[23]=193654272
s4_nv[24]=204542464
s4_nv[25]=198320640
s4_nv[26]=191321088
s4_nv[27]=200653824
s4_nv[28]=190543360
s4_nv[29]=188210176
s4_nv[30]=187432448
s4_nv[31]=187432448
s4_nv[32]=188210176
s4_nv[33]=188987904
s4_nv[34]=192876544
s4_nv[35]=187432448
declare -a s5
s5[21]=242
s5[22]=320
s5[23]=246
s5[24]=243
s5[25]=248
s5[26]=242
s5[27]=270
s5[28]=241
s5[29]=242
s5[30]=243
s5[31]=243
s5[32]=242
s5[33]=241
s5[34]=267
s5[35]=245
s5_nv[21]=188210176
s5_nv[22]=248872960
s5_nv[23]=191321088
s5_nv[24]=188987904
s5_nv[25]=192876544
s5_nv[26]=188210176
s5_nv[27]=209986560
s5_nv[28]=187432448
s5_nv[29]=188210176
s5_nv[30]=188987904
s5_nv[31]=188987904
s5_nv[32]=188210176
s5_nv[33]=187432448
s5_nv[34]=207653376
s5_nv[35]=190543360
declare -a s6
s6[21]=241
s6[22]=255
s6[23]=257
s6[24]=243
s6[25]=264
s6[26]=242
s6[27]=273
s6[28]=244
s6[29]=246
s6[30]=242
s6[31]=243
s6[32]=243
s6[33]=244
s6[34]=284
s6[35]=242
s6_nv[21]=187432448
s6_nv[22]=198320640
s6_nv[23]=199876096
s6_nv[24]=188987904
s6_nv[25]=205320192
s6_nv[26]=188210176
s6_nv[27]=212319744
s6_nv[28]=189765632
s6_nv[29]=191321088
s6_nv[30]=188210176
s6_nv[31]=188987904
s6_nv[32]=188987904
s6_nv[33]=189765632
s6_nv[34]=220874752
s6_nv[35]=188210176
declare -a s7
s7[21]=243
s7[22]=258
s7[23]=244
s7[24]=244
s7[25]=247
s7[26]=243
s7[27]=259
s7[28]=246
s7[29]=243
s7[30]=244
s7[31]=241
s7[32]=242
s7[33]=242
s7[34]=241
s7[35]=243
s7_nv[21]=188987904
s7_nv[22]=200653824
s7_nv[23]=189765632
s7_nv[24]=189765632
s7_nv[25]=192098816
s7_nv[26]=188987904
s7_nv[27]=201431552
s7_nv[28]=191321088
s7_nv[29]=188987904
s7_nv[30]=189765632
s7_nv[31]=187432448
s7_nv[32]=188210176
s7_nv[33]=188210176
s7_nv[34]=187432448
s7_nv[35]=188987904
declare -a s8
s8[21]=241
s8[22]=246
s8[23]=247
s8[24]=248
s8[25]=256
s8[26]=320
s8[27]=246
s8[28]=245
s8[29]=242
s8[30]=241
s8[31]=247
s8[32]=249
s8[33]=244
s8[34]=243
s8[35]=241
s8_nv[21]=187432448
s8_nv[22]=191321088
s8_nv[23]=192098816
s8_nv[24]=192876544
s8_nv[25]=199098368
s8_nv[26]=248872960
s8_nv[27]=191321088
s8_nv[28]=190543360
s8_nv[29]=188210176
s8_nv[30]=187432448
s8_nv[31]=192098816
s8_nv[32]=193654272
s8_nv[33]=189765632
s8_nv[34]=188987904
s8_nv[35]=187432448

# generated on mac, path are for server
# mac

for sub in {21..35}; do

  for session in 2 4 6 8; do #2 4 6 8 1 3 5 7

    if [ $session -eq 1 ];then
      NUM_VOLUME=${s1[$sub]}
      NUM_VOXEL=${s1_nv[$sub]}
    fi
    if [ $session -eq 2 ];then
      NUM_VOLUME=${s2[$sub]}
      NUM_VOXEL=${s2_nv[$sub]}
    fi
    if [ $session -eq 3 ];then
      NUM_VOLUME=${s3[$sub]}
      NUM_VOXEL=${s3_nv[$sub]}
    fi
    if [ $session -eq 4 ];then
      NUM_VOLUME=${s4[$sub]}
      NUM_VOXEL=${s4_nv[$sub]}
    fi
    if [ $session -eq 5 ];then
      NUM_VOLUME=${s5[$sub]}
      NUM_VOXEL=${s5_nv[$sub]}
    fi
    if [ $session -eq 6 ];then
      NUM_VOLUME=${s6[$sub]}
      NUM_VOXEL=${s6_nv[$sub]}
    fi
    if [ $session -eq 7 ];then
      NUM_VOLUME=${s7[$sub]}
      NUM_VOXEL=${s7_nv[$sub]}
    fi
    if [ $session -eq 8 ];then
      NUM_VOLUME=${s8[$sub]}
      NUM_VOXEL=${s8_nv[$sub]}
    fi

    Parameter="3"
    server_root="/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble"
    fiting_type="testing" #training testing

    Standard_brain_dir=$server_root"/brainmask/fsl_standard/MNI152_T1_2mm_brain"
    BOLD_IMAGE=$server_root"/MRI_filtered_bold_nosmooth_fieldmap/filtered_nosmooth_sub"$sub"_s"$session".nii.gz"
    
    TEMPLATE_PATH="/Users/bo/Documents/script_bash/batch_periodic_template_"$fiting_type"_2024.fsf"
    OUTPUTDIR=$server_root"/liujia_formal_sub"$sub"/periodic_2501_"$fiting_type"_"$Parameter"_fieldmap_s"$session"_phaseA"
    EV_file_name_cos_test="sub"$sub"_s"$session"_obj_test_"$Parameter"_no_cali_erchand.txt"
    EV_file_name_fix="sub"$sub"_s"$session"_fixation.txt"
    EV_file_name_lure="sub"$sub"_s"$session"_empty_trial.txt"
    MOTION_para=$server_root"/MRI_motion_parameter_fieldmap/sub"$sub"_s"$session".txt"

    sed -e 's@OUTPUTDIR@'$OUTPUTDIR'@g' \
    -e 's@NUM_VOLUME@'$NUM_VOLUME'@g' \
    -e 's@EV_file_name_cos_test@'$EV_file_name_cos_test'@g' \
    -e 's@EV_file_name_fix@'$EV_file_name_fix'@g' \
    -e 's@EV_file_name_lure@'$EV_file_name_lure'@g' \
    -e 's@MOTION_para@'$MOTION_para'@g' \
    -e 's@NUM_VOXEL@'$NUM_VOXEL'@g' \
    -e 's@BOLD_IMAGE@'$BOLD_IMAGE'@g' \
    -e 's@server_root@'$server_root'@g' \
    -e 's@Standard_brain_dir@'$Standard_brain_dir'@g' <$TEMPLATE_PATH> "/Users/bo/Documents/script_bash/template_periodic_testing_fieldmap2025/fsf_"$Parameter"_sub"$sub"_s"$session"_"$fiting_type".fsf"

  done
done


