

#
rm(list=ls(all=TRUE))
font_size = 15
scaleFUN <- function(x) sprintf("%.2f", x)
library(ggplot2)
library(ggpubr)
library(pracma)
library(fourierin)
library(seewave)

num_sample=90

x_text = seq(1, length(seq(0, 345, 15))/2, length.out =num_sample/2)
freq_pool = seq(1, 12, 1)
target_freq_index_pool = c()
for (cur_freq in freq_pool) {
  target_freq_index_pool <- c(target_freq_index_pool, which.min(abs(x_text - cur_freq)))
}

angle_list <- seq(0, 345, 15)
fft_win = ftwindow(length(angle_list), wn="hanning")
num_zero = num_sample - length(angle_list)

for (ith_sub in 1:35) {
  result_table <- read.table(paste("/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/MRI_results_formal/bold_angle_perio_bin15_sub", ith_sub,"_subj_z_wb.txt", sep = ""), stringsAsFactors = FALSE)
  
  num_voxel <- length(result_table[,1])
  num_freq <- length(target_freq_index_pool)
  # create export table
  #for (ith_win_size in 0:4) {
   # ith_win_size = 1
  for (ith_win_size in c(1,2,4)) {
    export_table <- data.frame(matrix(NA, nrow=num_voxel, ncol=num_freq ))
    for (ith_row in 1:num_voxel) {
      raw_signal = as.numeric(result_table[ith_row, ])
      detrend_value <- detrend(raw_signal)
      windowed_value <- fft_win * detrend_value
      # add zero
      detrend_value_zeroPad <- c(windowed_value, zeros(num_zero,1))
      fft_value <- abs(fft(detrend_value_zeroPad))
      fft_value <- fft_value[1:(num_sample/2)]
      #for (ith_freq in 1:num_freq) {
      for (ith_freq in c(4,7)) {
        cur_index_range = c()
        cur_center_index = target_freq_index_pool[ith_freq]
        
        if(cur_center_index==1){
          cur_index_range = seq(cur_center_index, cur_center_index+ith_win_size)
        } else if (cur_center_index == max(target_freq_index_pool)){
          cur_index_range = seq(cur_center_index-ith_win_size, cur_center_index, 1)
        } else {
          cur_index_range = seq(cur_center_index-ith_win_size, cur_center_index+ith_win_size, 1)
        }
        indicator = which(cur_index_range>max(target_freq_index_pool) | cur_index_range<=0)
        if (length(indicator)>0){
          cur_index_range <- cur_index_range[-indicator]
        }
        
        export_table[ith_row, ith_freq] <- mean(fft_value[cur_index_range])
        print(paste(ith_row,"-" ,ith_freq, sep = ""))
    
      }
    }
    write.table(export_table, file = paste("/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/MRI_results_formal/fft_value_bin15_sub", as.character(ith_sub),"_wb_win_size_", as.character(ith_win_size),"_subj.txt", sep = ""),
                row.names = FALSE, col.names = FALSE, quote=FALSE)
    print(ith_sub)
  }
}




