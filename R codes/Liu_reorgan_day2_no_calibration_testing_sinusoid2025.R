

rm(list=ls(all=TRUE)) 
library(REdaS)


para=12

#ori_baseline <- read.table(paste("/Users/bo/Documents/data_liujia_lab/manuscript_gridcell3hz/analysis_liuP1_greeble/MRI_result_sinusoid/mean_orientation_para",para,"_subj_sub1_35_Vector_Mean.txt", sep = ""), stringsAsFactors = FALSE)

for (ith in c(1:28,30, 32:35)) {
  result_raw_table <- read.table(paste("/Users/bo/Documents/data_liujia_lab/manuscript_gridcell3hz/analysis_liuP1_greeble/sub", ith,"_mri_record.txt", sep = ""), stringsAsFactors = FALSE)
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
  
  quadrant_list = c()
  angle = c()
  for (ith_row in 1:length(result_table[,1])) {
    start_x = result_table[ith_row, start_x_col_ith]
    start_y = result_table[ith_row, start_y_col_ith]
    end_x = result_table[ith_row, end_x_col_ith]
    end_y = result_table[ith_row, end_y_col_ith]
    #end_x = 1
    #end_y = 1
    
    if(!is.na(start_x)){
      if(start_x==end_x & start_y>end_y){
        quadrant_list<-c(quadrant_list, NA)
        angle <- c(angle, 90)
      }
      if(start_x==end_x & start_y<end_y){
        quadrant_list<-c(quadrant_list, NA)
        angle <- c(angle, 270)
      }
      if(start_x>end_x & start_y==end_y){
        quadrant_list<-c(quadrant_list, NA)
        angle <- c(angle, 0)
      }
      if(start_x<end_x & start_y==end_y){
        quadrant_list<-c(quadrant_list, NA)
        angle <- c(angle, 180)
      }
      if (start_x>end_x & start_y>end_y){
        quadrant_list<-c(quadrant_list, 1)
        angle <- c(angle, acos(abs(start_x - end_x)/sqrt(abs(start_x-end_x)^2+abs(start_y-end_y)^2))*180/pi)
      }
      if (start_x<end_x & start_y>end_y){
        quadrant_list<-c(quadrant_list, 2)
        angle <- c(angle, asin(abs(start_x - end_x)/sqrt(abs(start_x-end_x)^2+abs(start_y-end_y)^2))*180/pi+90)
      }
      if (start_x<end_x & start_y<end_y){
        quadrant_list<-c(quadrant_list, 3)
        angle <- c(angle, acos(abs(start_x - end_x)/sqrt(abs(start_x-end_x)^2+abs(start_y-end_y)^2))*180/pi+180)
      }
      if (start_x>end_x & start_y<end_y){
        quadrant_list<-c(quadrant_list, 4)
        angle <- c(angle, asin(abs(start_x - end_x)/sqrt(abs(start_x-end_x)^2+abs(start_y-end_y)^2))*180/pi+270)
      } 
    }else {
      quadrant_list<-c(quadrant_list, NA)
      angle <- c(angle, NA)
    }
  }
  
  
  result_table <- cbind(result_table, quadrant_list, angle)
  result_table$angle <- round(result_table$angle,3)
  #temp_ori_table = ori_baseline[which(ori_baseline[,2] == ith), ]
  #result_table$obj_para = round(cos(para*  (deg2rad(result_table$angle) - temp_ori_table[which(temp_ori_table[,1]==paste("periodic_2501_subj_training_",para,"_fieldmap_s",sep = "")), 3] )), 3)
  
  #result_table$obj_para = round(cos(para*  (deg2rad(result_table$angle) )), 3)
  result_table$obj_cos <- round(cos(para * deg2rad(result_table$angle)), 6)
  result_table$obj_sin <- round(sin(para * deg2rad(result_table$angle)), 6)
  
  
  # subj bin 10
  angle_subj_10_bin = c()
  angle_pool = seq(0, 350, 10)
  for (cur_float_angle in result_table$angle) {
    if(!is.na(cur_float_angle)){
      angle_subj_10_bin <- c(angle_subj_10_bin, angle_pool[which.min(abs(angle_pool - cur_float_angle))])
    }
    else{
      angle_subj_10_bin <- c(angle_subj_10_bin, NA)
    }
  }
  result_table <- cbind(result_table, angle_subj_10_bin)
  

  write.table(result_table, paste("/Users/bo/Documents/data_liujia_lab/manuscript_gridcell3hz/analysis_liuP1_greeble/sub", ith,"_mri_record_subj_vector_mean_testing_para",para,"_1_35_bin10.txt", sep = ""), sep='\t', row.names=FALSE, col.names = FALSE, quote = FALSE)
}













