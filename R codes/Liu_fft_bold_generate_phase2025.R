

rm(list=ls(all=TRUE))
font_size = 15
scaleFUN <- function(x) sprintf("%.2f", x)
bar_width=0.5
library(ggplot2)
library(ggpubr)
library(pracma)
library(fourierin)
library(seewave)

angle_list <- seq(0, 350, 10)

x_text = seq(1, length(angle_list)/2, length.out = 50)

freq_index_pool = seq(1, length(angle_list)/2, length.out = length(angle_list)/2)
target_freq_index_pool = c()
for (cur_freq_index in freq_index_pool) {
  target_freq_index_pool <- c(target_freq_index_pool, which.min(abs(x_text - cur_freq_index)))
}
fft_win = ftwindow(length(angle_list), wn="hanning")
num_zero = 100 - length(angle_list)

for (ith_sub in c(1:28, 30, 32:35)) {
  result_table <- read.table(paste("/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/MRI_results_formal/bold_angle_perio_bin10_sub", ith_sub,"_subj_z_funhpc.txt", sep = ""), stringsAsFactors = FALSE)
  num_row <- length(result_table[,1])
  # create export table
  export_table <- data.frame(matrix(NA, nrow=num_row, ncol=1 ))
  
  for (ith_row in 1:num_row) {
    raw_signal = as.numeric(result_table[ith_row, ])
    detrend_value <- detrend(raw_signal)
    windowed_value <- fft_win * detrend_value
    detrend_value_zeroPad <- c(windowed_value, zeros(num_zero,1))
    fft_value <- fft(detrend_value_zeroPad)
    phase_value <- atan2(Im(fft_value), Re(fft_value))
    # for (ith_sample in 1:num_signal) {
    #   cur_center_index = target_freq_index_pool[ith_sample]
    #   # cur_index_range = c(seq(cur_center_index-6, cur_center_index-1, 1), cur_center_index, seq(cur_center_index+1, cur_center_index+6))
    #   export_table[ith_row, ith_sample] <- mean(phase_value[cur_center_index])
    # }
    export_table[ith_row,1] <- phase_value[target_freq_index_pool[4]]
    print(ith_row)
  }
  write.table(export_table, file = paste("/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/MRI_results_formal/fft_phase_sub", as.character(ith_sub),"_subj_funhpc.txt", sep = ""),
              row.names = FALSE, col.names = FALSE, quote=FALSE)
  print(ith_sub)
}



rm(list=ls(all=TRUE))
font_size = 15
scaleFUN <- function(x) sprintf("%.2f", x)
bar_width=0.5
library(ggplot2)
library(ggpubr)
library(pracma)
library(fourierin)
library(seewave)

angle_list <- seq(0, 350, 10)

x_text = seq(1, length(angle_list)/2, length.out = 50)

freq_index_pool = seq(1, length(angle_list)/2, length.out = length(angle_list)/2)
target_freq_index_pool = c()
for (cur_freq_index in freq_index_pool) {
  target_freq_index_pool <- c(target_freq_index_pool, which.min(abs(x_text - cur_freq_index)))
}
num_point <- length(target_freq_index_pool)
fft_win = ftwindow(length(angle_list), wn="hanning")
num_zero = 100 - length(angle_list)


for (ith_sub in c(1:28, 30, 32:35)) {
  result_table <- read.table(paste("/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/MRI_results_formal/bold_angle_perio_bin10_sub", ith_sub,"_subj_z_funerc.txt", sep = ""), stringsAsFactors = FALSE)
  num_row <- length(result_table[,1])
  export_table <- data.frame(matrix(NA, nrow=num_row, ncol=1 ))

  for (ith_row in 1:num_row) {
    raw_signal = as.numeric(result_table[ith_row, ])
    detrend_value <- detrend(raw_signal)
    windowed_value <- fft_win * detrend_value
    detrend_value_zeroPad <- c(windowed_value, zeros(num_zero,1))
    fft_value <- fft(detrend_value_zeroPad)
    phase_value <- atan2(Im(fft_value), Re(fft_value))
    # for (ith_sample in 1:num_signal) {
    #   cur_center_index = target_freq_index_pool[ith_sample]
    #   # cur_index_range = c(seq(cur_center_index-6, cur_center_index-1, 1), cur_center_index, seq(cur_center_index+1, cur_center_index+6))
    #   export_table[ith_row, ith_sample] <- mean(phase_value[cur_center_index])
    # }
    export_table[ith_row,1] <- phase_value[target_freq_index_pool[7]]
    print(ith_row)
  }
  write.table(export_table, file = paste("/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/MRI_results_formal/fft_phase_sub", as.character(ith_sub),"_subj_funerc.txt", sep = ""),
              row.names = FALSE, col.names = FALSE, quote=FALSE)
  print(ith_sub)
}



