
rm(list=ls(all=TRUE)) 
library(REdaS)

for (ith in 1:35) {
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
  
  angle_30_bin = c()
  angle_pool = seq(0, 330, 30)
  for (cur_float_angle in result_table[, 15]) {
    if(!is.na(cur_float_angle)){
      angle_30_bin <- c(angle_30_bin, angle_pool[which.min(abs(angle_pool - cur_float_angle))])
    }
    else{
      angle_30_bin <- c(angle_30_bin, NA)
    }
  }
  angle_15_bin = c()
  angle_pool = seq(0, 345, 15)
  for (cur_float_angle in result_table[, 15]) {
    if(!is.na(cur_float_angle)){
      angle_15_bin <- c(angle_15_bin, angle_pool[which.min(abs(angle_pool - cur_float_angle))])
    }
    else{
      angle_15_bin <- c(angle_15_bin, NA)
    }
  }
  result_table <- cbind(result_table, angle_30_bin, angle_15_bin)
  result_table$angle <- round(result_table$angle,3)
  
  result_table$subj_sin1 = round(sin(deg2rad(result_table$angle*1)),3)
  result_table$subj_cos1 = round(cos(deg2rad(result_table$angle*1)),3)

  result_table$subj_sin2 = round(sin(deg2rad(result_table$angle*2)),3)
  result_table$subj_cos2 = round(cos(deg2rad(result_table$angle*2)),3)
  
  result_table$subj_sin3 = round(sin(deg2rad(result_table$angle*3)),3)
  result_table$subj_cos3 = round(cos(deg2rad(result_table$angle*3)),3)
  
  result_table$subj_sin4 = round(sin(deg2rad(result_table$angle*4)),3)
  result_table$subj_cos4 = round(cos(deg2rad(result_table$angle*4)),3)
  
  result_table$subj_sin5 = round(sin(deg2rad(result_table$angle*5)),3)
  result_table$subj_cos5 = round(cos(deg2rad(result_table$angle*5)),3)
  
  result_table$subj_sin6 = round(sin(deg2rad(result_table$angle*6)),3)
  result_table$subj_cos6 = round(cos(deg2rad(result_table$angle*6)),3)
  
  result_table$subj_sin7 = round(sin(deg2rad(result_table$angle*7)),3)
  result_table$subj_cos7 = round(cos(deg2rad(result_table$angle*7)),3)

  result_table$subj_sin8 = round(sin(deg2rad(result_table$angle*8)),3)
  result_table$subj_cos8 = round(cos(deg2rad(result_table$angle*8)),3)
  
  result_table$subj_sin9 = round(sin(deg2rad(result_table$angle*9)),3)
  result_table$subj_cos9 = round(cos(deg2rad(result_table$angle*9)),3)
  
  write.table(result_table, paste("/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/sub", ith,"_mri_record_sinusoid_subj.txt", sep = ""), sep='\t', row.names=FALSE, col.names = FALSE, quote = FALSE)
}




