
import matplotlib
from numpy import loadtxt
from fig import module_utility
import scipy
import random
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


# plot fft
perfor_4f_remove_fft = np.mean(perfor_4f_remove, axis=0)
perfor_4f_remove_fft = scipy.signal.detrend(perfor_4f_remove_fft)
r_dir_fourier = np.abs(np.fft.fft(perfor_4f_remove_fft).real)
r_dir_fourier = r_dir_fourier[0:12]

# #
# import pandas as pd
# df = pd.DataFrame(r_dir_fourier)
# df.to_excel("/Users/bo/Documents/data_liujia_lab/manuscript_gridcell3hz/submission_elife/figs/Figure 5-source data 2.xlsx", index=False, header=False)
# #

freq_pool = np.linspace(0, 13, 13, endpoint=False)

# shuffling
shuf_matrix = np.zeros((5000, 9))
for ith in list(range(0, 5000)):
    dis_pool_copy = perfor_4f_remove_fft.copy()
    random.shuffle(dis_pool_copy)
    fft_power_shuffle = np.abs(np.fft.fft(dis_pool_copy).real)
    fft_power_shuffle = fft_power_shuffle[1:10]
    shuf_matrix[ith, ...] = fft_power_shuffle
uncorr_thres_list = []
for ith in list(range(0, 9)):
    cur_list = np.sort(shuf_matrix[:,ith])
    uncorr_thres_list.append(cur_list[int(len(cur_list)*0.99)])

plt.close('all')
fontsize = 65
font = {'family': 'Arial',
        'weight': 'normal',
        'size': fontsize}
matplotlib.rc('font', **font)
fig = plt.figure(figsize=(10, 9.5))
ax = fig.add_subplot()
ax.plot(r_dir_fourier, color='black', linewidth=8)
ax.plot(list(range(0, len(r_dir_fourier))), [np.max(uncorr_thres_list)]*len(r_dir_fourier), color='r', linestyle='--', linewidth=8)
ax.set_xticks([0, 3, 6, 9, 12], [0, 3, 6 , 9, 12])
ax.set_ylabel('Spectral power')
ax.set_xlabel('#-fold\nmodulation', fontsize= fontsize*0.95)
# ax.set_yticks([0, 90])
# plt.subplots_adjust(left=0, right=1, top=1, bottom=0)
# plt.tight_layout()
for axis in ['top','right']:
    ax.spines[axis].set_linewidth(0)
for axis in ['bottom','left']:
    ax.spines[axis].set_linewidth(7.5)
plt.yticks([0, 0.5, 1])
plt.show()



