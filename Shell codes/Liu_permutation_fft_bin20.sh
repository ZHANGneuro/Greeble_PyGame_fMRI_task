#!/bin/bash

# declare -a freq_pool
# path_init_thres="/Users/bo/Documents/data_liujia_lab/task_greeble_exp/pilot_beh_mri_results/MRI_results_formal/stat_fft_ws4_max/freq_pool_12.txt"
# counter=1
# while IFS= read -r line; do
#   freq_pool[$counter]="$line"
#   counter=$((counter+1))
# done < $path_init_thres



for ith_group in 1 2;
do

  if [ $ith_group -eq 1 ];then
    cur_group='g1'
  fi
  if [ $ith_group -eq 2 ];then
    cur_group='g2'
  fi

  for ith_ws in 2 3 4;
  do

    declare -a vector_init_thres
    path_init_thres="/Users/bo/Documents/data_liujia_lab/exp_greeble/MRI_results_formal/stat_fft_win_size20/init_threshold_0.95_"$cur_group"_ws"$ith_ws".txt"
    counter=0
    while IFS= read -r line; do
      vector_init_thres[$counter]="$line"
      counter=$((counter+1))
    done < $path_init_thres

    complete_path="/Users/bo/Documents/data_liujia_lab/exp_greeble/MRI_results_formal/stat_fft_win_size20/"
    for ith_freq in {0..9};
    do
      (
      p1="randomise -i "
      path_4d=$complete_path"o4D_"$cur_group"_freq"$ith_freq"_ws"$ith_ws".nii.gz"

      other_string=" -1 -c "${vector_init_thres[ith_freq]}" -n 1000"
      # other_string=" -1 -c 2 -n 1000"
      add_mask=" -m /Users/bo/Documents/brainmask/mask_MTL_smaller.nii" # mask_MTL_smaller mask_MTL_bigger mask_MTL_bigger_full
      out_path="/Users/bo/Documents/data_liujia_lab/exp_greeble/MRI_results_formal/stat_fft_win_size20/acorr_0.95_"$cur_group"_freq"$ith_freq"_ws"$ith_ws"_mtlsmall"
      cmd=$p1$path_4d" -o "$out_path$other_string$add_mask

      eval $cmd

      )&
      if (( $(wc -w <<<$(jobs -p)) % 10 == 0 )); then wait; fi
    done

  done
done







# randomise -i /Users/bo/Documents/data_liujia_lab/task_greeble_exp/pilot_beh_mri_results/MRI_results_formal/stat_fft_ws4_max/o4D_g1_freq3_ws4.nii.gz -o /Users/bo/Desktop/aaa.nii -1 -c 0.6 -m /Users/bo/Documents/brainmask/mask_MTL_smaller.nii
