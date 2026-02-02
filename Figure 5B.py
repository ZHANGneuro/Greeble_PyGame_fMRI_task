
import matplotlib
from numpy import loadtxt
from fig import module_utility
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

sub_group = list(range(1, 29))
sub_group.extend([30, 32,33,34,35])

# exp data
num_subject = len(sub_group)
angle_colume = 19 #  col20 subj10 (do not forget -1)
num_samples = 36 #

output_table = np.zeros((num_subject, num_samples))
error_table = np.zeros((num_subject, num_samples))
baseline_table = np.zeros((num_subject,num_samples))
performance_vector=[]
counter = 0
for ith_sub in sub_group:
    # load raw data
    cur_path_detail = Path.cwd() / "data"/ f"sub{ith_sub}_mri_detail.txt"
    raw_data = loadtxt(cur_path_detail, dtype=str)
    detail_table = np.zeros((len(raw_data), 15))
    for ith_row in list(range(0, len(raw_data))):
        cur_row = raw_data[ith_row]
        for ith_col in list(range(0, 15)):
            detail_table[ith_row, ith_col] = cur_row[ith_col]
    detail_table = detail_table.astype(int)
    # access length vector
    num_movement_list =[]
    for ith_sess in list(range(1, 9)):
        sess_table = detail_table[np.where(detail_table[:,1]==ith_sess)[0], ...]
        trial_list = np.unique(sess_table[:,2])
        for cur_trial in trial_list:
            num_movement_list.append(len(np.where(sess_table[:,2]==cur_trial)[0]))
    num_movement_list = np.array(num_movement_list)

    # load raw data
    cur_path_task = Path.cwd() / "data"/ f"sub{ith_sub}_mri_record_obj_subj.txt"
    raw_data_task = loadtxt(cur_path_task, dtype=str)
    raw_data_task = np.delete(raw_data_task, np.where(raw_data_task[:,2]=='NA')[0], axis=0)
    angle_list = np.sort(np.unique(raw_data_task[:,angle_colume]).astype(int))
    error_list = raw_data_task[:, 7].astype(float)/0.04
    # baseline
    start_loc_list = []
    baseline_list = []
    for ith in list(range(0, np.shape(raw_data_task)[0])):
        cur_start_loc = [ int(float(raw_data_task[ith, 3])/0.04),  int(float(raw_data_task[ith, 4])/0.04)]
        start_loc_list.append(cur_start_loc)
        short_path = module_utility.access_shortest_path(cur_start_loc[0], cur_start_loc[1], goal_loc=[int(float(raw_data_task[ith, 5]) / 0.04), int(float(raw_data_task[ith, 6]) / 0.04)])
        baseline_list.append(len(short_path))
    baseline_list = np.array(baseline_list)

    for ith_angle in list(range(0, len(angle_list))):
        cur_angle = angle_list[ith_angle]
        output_table[counter, ith_angle] = np.mean(num_movement_list[np.where(raw_data_task[:,angle_colume]==str(cur_angle))[0]])
        baseline_table[counter, ith_angle] = np.mean(baseline_list[np.where(raw_data_task[:,angle_colume]==str(cur_angle))[0]])
        error_table[counter, ith_angle] = np.mean(error_list[np.where(raw_data_task[:,angle_colume]==str(cur_angle))[0]])
    counter = counter + 1


# # plot averaged beh
perfor_4f_remove = ((output_table - baseline_table) + error_table)
perfor_4f_remove = (perfor_4f_remove-np.mean(perfor_4f_remove))/ np.std(perfor_4f_remove)
perfor_mean_across_subjects = np.mean(perfor_4f_remove, axis=0)
perfor_se_across_subjects = np.std(perfor_4f_remove, axis=0)/np.sqrt(num_subject)


# #
# import pandas as pd
# df = pd.DataFrame(perfor_4f_remove)
# df.to_excel("/Users/bo/Documents/data_liujia_lab/manuscript_gridcell3hz/submission_elife/figs/Figure 5-source data 1.xlsx", index=False, header=False)
# #


plt.close('all')
fontsize = 75
font = {'family': 'Arial',
        'weight': 'normal',
        'size': fontsize}
matplotlib.rc('font', **font)
fig = plt.figure(figsize=(11, 11.5))
ax = fig.add_subplot()
ax.plot(list(range(0, 36)),perfor_mean_across_subjects, color='black', linewidth = 8)
ax.fill_between(range(0,perfor_4f_remove.shape[1]), perfor_mean_across_subjects-perfor_se_across_subjects, perfor_mean_across_subjects+perfor_se_across_subjects, edgecolor='black', alpha=0.3, color='gray')
ax.set_ylabel('Performance\n(z-score)')
for axis in ['top','right']:
    ax.spines[axis].set_linewidth(0)
for axis in ['bottom','left']:
    ax.spines[axis].set_linewidth(7.5)
ax.set_xticks([0, len(perfor_mean_across_subjects)-1], ['0', '2pi'])
ax.set_xlabel('Movement\ndirection')
plt.yticks([-0.4, 0, 0.4])
plt.show()

