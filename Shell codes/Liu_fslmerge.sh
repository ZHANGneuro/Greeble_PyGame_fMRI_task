# #!/bin/bash


for i in {1..35}; do
  file_list=("/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_raw_bold_4d/sub"$i"_s*")


  fslmerge -tr "/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_raw_bold_4d_session_connected/bold_4d_all_session_sub"$i".nii" $file_list 2

done





