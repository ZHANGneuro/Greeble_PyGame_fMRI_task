
rm(list=ls(all=TRUE)) 
library(REdaS)

sub_list = 1:35

for (ith in sub_list) {
  result_raw_table <- read.table(paste("/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/sub", ith,"_mri_record.txt", sep = ""), stringsAsFactors = FALSE)
  num_trial = length(result_raw_table[,1])
  result_table <- data.frame(sub = numeric(num_trial), sess = numeric(num_trial), orientation = numeric(num_trial), 
                             ori_x = numeric(num_trial), ori_y = numeric(num_trial), final_x = numeric(num_trial),
                             final_y = numeric(num_trial), sel_error = numeric(num_trial), time_s_pressed = numeric(num_trial),
                             time_fix = numeric(num_trial), time_stimuli = numeric(num_trial), time_trialend = numeric(num_trial),
                             sub_fee = numeric(num_trial))
  for (ith_row in 1:length(result_raw_table[,1])) {
    for (ith_col in 1:length(result_raw_table[1,])) {
      if (result_raw_table[ith_row, ith_col]=='na'){
        result_table[ith_row, ith_col]<-NA
      } else {
        result_table[ith_row, ith_col]=as.numeric(result_raw_table[ith_row, ith_col])
      }
    }
  }
  
  start_x_col_ith = 4
  start_y_col_ith = 5
  end_x_col_ith = 6
  end_y_col_ith = 7
  
  # subj
  angle_subj = c()
  for (ith_row in 1:length(result_table[,1])) {
    start_x = result_table[ith_row, start_x_col_ith]
    start_y = result_table[ith_row, start_y_col_ith]
    end_x = result_table[ith_row, end_x_col_ith]
    end_y = result_table[ith_row, end_y_col_ith]
    
    if(!is.na(start_x)){
      if(start_x==end_x & start_y>end_y){
        angle_subj <- c(angle_subj, 90)
      }
      if(start_x==end_x & start_y<end_y){
        angle_subj <- c(angle_subj, 270)
      }
      if(start_x>end_x & start_y==end_y){
        angle_subj <- c(angle_subj, 0)
      }
      if(start_x<end_x & start_y==end_y){
        angle_subj <- c(angle_subj, 180)
      }
      if (start_x>end_x & start_y>end_y){
        angle_subj <- c(angle_subj, acos(abs(start_x - end_x)/sqrt(abs(start_x-end_x)^2+abs(start_y-end_y)^2))*180/pi)
      }
      if (start_x<end_x & start_y>end_y){
        angle_subj <- c(angle_subj, asin(abs(start_x - end_x)/sqrt(abs(start_x-end_x)^2+abs(start_y-end_y)^2))*180/pi+90)
      }
      if (start_x<end_x & start_y<end_y){
        angle_subj <- c(angle_subj, acos(abs(start_x - end_x)/sqrt(abs(start_x-end_x)^2+abs(start_y-end_y)^2))*180/pi+180)
      }
      if (start_x>end_x & start_y<end_y){
        angle_subj <- c(angle_subj, asin(abs(start_x - end_x)/sqrt(abs(start_x-end_x)^2+abs(start_y-end_y)^2))*180/pi+270)
      } 
    }else {
      angle_subj <- c(angle_subj, NA)
    }
  }
  result_table <- cbind(result_table, angle_subj) # angle_subj
  result_table$angle_subj <- round(result_table$angle_subj,3)
  
  # obj 
  angle_obj = c()
  for (ith_row in 1:length(result_table[,1])) {
    start_x = result_table[ith_row, start_x_col_ith]
    start_y = result_table[ith_row, start_y_col_ith]
    end_x = 1
    end_y = 1
    
    if(!is.na(start_x)){
      if(start_x==end_x & start_y>end_y){
        angle_obj <- c(angle_obj, 90)
      }
      if(start_x==end_x & start_y<end_y){
        angle_obj <- c(angle_obj, 270)
      }
      if(start_x>end_x & start_y==end_y){
        angle_obj <- c(angle_obj, 0)
      }
      if(start_x<end_x & start_y==end_y){
        angle_obj <- c(angle_obj, 180)
      }
      if (start_x>end_x & start_y>end_y){
        angle_obj <- c(angle_obj, acos(abs(start_x - end_x)/sqrt(abs(start_x-end_x)^2+abs(start_y-end_y)^2))*180/pi)
      }
      if (start_x<end_x & start_y>end_y){
        angle_obj <- c(angle_obj, asin(abs(start_x - end_x)/sqrt(abs(start_x-end_x)^2+abs(start_y-end_y)^2))*180/pi+90)
      }
      if (start_x<end_x & start_y<end_y){
        angle_obj <- c(angle_obj, acos(abs(start_x - end_x)/sqrt(abs(start_x-end_x)^2+abs(start_y-end_y)^2))*180/pi+180)
      }
      if (start_x>end_x & start_y<end_y){
        angle_obj <- c(angle_obj, asin(abs(start_x - end_x)/sqrt(abs(start_x-end_x)^2+abs(start_y-end_y)^2))*180/pi+270)
      } 
    }else {
      angle_obj <- c(angle_obj, NA)
    }
  }
  result_table <- cbind(result_table, angle_obj) # obj
  result_table$angle_obj <- round(result_table$angle_obj,3)
  
  
  # obj 10
  angle_obj_10_bin = c()
  angle_pool = seq(0, 350, 10)
  for (cur_float_angle in result_table$angle_obj) {
    if(!is.na(cur_float_angle)){
      angle_obj_10_bin <- c(angle_obj_10_bin, angle_pool[which.min(abs(angle_pool - cur_float_angle))])
    }
    else{
      angle_obj_10_bin <- c(angle_obj_10_bin, NA)
    }
  }
  result_table <- cbind(result_table, angle_obj_10_bin)
  
  
  # obj 15
  angle_obj_15_bin = c()
  angle_pool = seq(0, 345, 15)
  for (cur_float_angle in result_table$angle_obj) {
    if(!is.na(cur_float_angle)){
      angle_obj_15_bin <- c(angle_obj_15_bin, angle_pool[which.min(abs(angle_pool - cur_float_angle))])
    }
    else{
      angle_obj_15_bin <- c(angle_obj_15_bin, NA)
    }
  }
  result_table <- cbind(result_table, angle_obj_15_bin)

  # obj 20
  angle_obj_20_bin = c()
  angle_pool = seq(0, 340, 20)
  for (cur_float_angle in result_table$angle_obj) {
    if(!is.na(cur_float_angle)){
      angle_obj_20_bin <- c(angle_obj_20_bin, angle_pool[which.min(abs(angle_pool - cur_float_angle))])
    }
    else{
      angle_obj_20_bin <- c(angle_obj_20_bin, NA)
    }
  }
  result_table <- cbind(result_table, angle_obj_20_bin)

  # obj 30
  angle_obj_30_bin = c()
  angle_pool = seq(0, 330, 30)
  for (cur_float_angle in result_table$angle_obj) {
    if(!is.na(cur_float_angle)){
      angle_obj_30_bin <- c(angle_obj_30_bin, angle_pool[which.min(abs(angle_pool - cur_float_angle))])
    }
    else{
      angle_obj_30_bin <- c(angle_obj_30_bin, NA)
    }
  }
  result_table <- cbind(result_table, angle_obj_30_bin)

  
  
  
  # subj 10
  angle_subj_10_bin = c()
  angle_pool = seq(0, 350, 10)
  for (cur_float_angle in result_table$angle_subj) {
    if(!is.na(cur_float_angle)){
      angle_subj_10_bin <- c(angle_subj_10_bin, angle_pool[which.min(abs(angle_pool - cur_float_angle))])
    }
    else{
      angle_subj_10_bin <- c(angle_subj_10_bin, NA)
    }
  }
  result_table <- cbind(result_table, angle_subj_10_bin)


  # subj 15
  angle_subj_15_bin = c()
  angle_pool = seq(0, 345, 15)
  for (cur_float_angle in result_table$angle_subj) {
    if(!is.na(cur_float_angle)){
      angle_subj_15_bin <- c(angle_subj_15_bin, angle_pool[which.min(abs(angle_pool - cur_float_angle))])
    }
    else{
      angle_subj_15_bin <- c(angle_subj_15_bin, NA)
    }
  }
  result_table <- cbind(result_table, angle_subj_15_bin)

  # subj 20
  angle_subj_20_bin = c()
  angle_pool = seq(0, 340, 20)
  for (cur_float_angle in result_table$angle_subj) {
    if(!is.na(cur_float_angle)){
      angle_subj_20_bin <- c(angle_subj_20_bin, angle_pool[which.min(abs(angle_pool - cur_float_angle))])
    }
    else{
      angle_subj_20_bin <- c(angle_subj_20_bin, NA)
    }
  }
  result_table <- cbind(result_table, angle_subj_20_bin)

  # subj 30
  angle_subj_30_bin = c()
  angle_pool = seq(0, 330, 30)
  for (cur_float_angle in result_table$angle_subj) {
    if(!is.na(cur_float_angle)){
      angle_subj_30_bin <- c(angle_subj_30_bin, angle_pool[which.min(abs(angle_pool - cur_float_angle))])
    }
    else{
      angle_subj_30_bin <- c(angle_subj_30_bin, NA)
    }
  }
  result_table <- cbind(result_table, angle_subj_30_bin)

  write.table(result_table, paste("/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/sub", ith,"_mri_record_obj_subj.txt", sep = ""), sep='\t', row.names=FALSE, col.names = FALSE, quote = FALSE)
}













