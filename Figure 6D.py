
import matplotlib.pyplot as plt
import matplotlib
import numpy as np
from pathlib import Path

performance_array = np.load(Path.cwd() / "data"/ "model_performance_array.npy")

# fft
fft_array = np.zeros((performance_array.shape[0], 9))
thres_array = np.zeros((performance_array.shape[0], 9))
for ith_folder in list(range(performance_array.shape[0])):
    cur_signal = performance_array[ith_folder,:]
    r_dir_fourier = np.square(np.abs(np.fft.fft(cur_signal)))
    signal_final = r_dir_fourier[1:10]
    fft_array[ith_folder, :] = signal_final

    # shuffling
    shuf_matrix = np.zeros((5000, 9))
    for ith in list(range(0, 5000)):
        cur_signals = np.array(performance_array[ith_folder, :].copy())
        cur_signals = cur_signals.reshape(-1)
        np.random.shuffle(cur_signals)
        fft_power_shuffle = np.square(np.abs(np.fft.fft(cur_signals)))
        fft_power_shuffle = fft_power_shuffle[1:10]
        shuf_matrix[ith, ...] = fft_power_shuffle
    uncorr_thres_list = []
    for ith in list(range(0, 9)):
        cur_list = np.sort(shuf_matrix[:,ith])
        # uncorr_thres_list.append(cur_list[int(len(cur_list)*0.99)])
        uncorr_thres_list.append(np.max(cur_list))
    thres_array[ith_folder, :] = uncorr_thres_list


# #
# import pandas as pd
# df = pd.DataFrame(fft_array)
# df.to_excel("/Users/bo/Documents/data_liujia_lab/manuscript_gridcell3hz/submission_elife/figs/Figure 6-source data 2.xlsx", index=False, header=False)
# #


list_mean = np.mean(fft_array, axis=0)
list_se = np.std(fft_array, axis=0)/np.sqrt(len(fft_array))
list_thres = np.max(thres_array)
plt.close('all')
font = {'family': 'Arial',
        'weight': 'normal',
        'size': 45}
matplotlib.rc('font', **font)
fig = plt.figure(figsize=(8, 5.5))
ax = fig.add_subplot()
for ith_line in list(range(0, len(fft_array))):
    ax.plot(fft_array[ith_line, :], color=(150 / 255, 150 / 255, 150 / 255), linewidth=2, zorder=2)
ax.plot(list_mean, color='black', linewidth=6, zorder=4)
ax.fill_between(list(range(0, len(list_mean))),
                list_mean - list_se,
                list_mean + list_se,
                color='blue', alpha=0.6, zorder=3)
ax.set_ylabel('Spectral power')
ax.plot(list(range(0, len(list_mean))),[list_thres]*len(list_mean), color='r', linestyle='--', linewidth=5)
ax.set_xlabel('#-fold modulation')
for axis in ['bottom', 'left']:
    ax.spines[axis].set_linewidth(5)
for axis in ['top', 'right']:
    ax.spines[axis].set_linewidth(0)
ax.set_xticks([0, 2, 4, 6, 8], [1,3,5,7,9])
plt.show()



