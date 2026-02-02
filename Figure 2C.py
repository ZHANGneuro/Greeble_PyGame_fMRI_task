
from matplotlib import gridspec
import matplotlib
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

cur_path = Path.cwd() / "data" / "bar_6_fold_para34567.txt"

with open(cur_path) as f:
    lines = [line for line in f]
num_each_row = len(lines[0].split())
data_set = np.zeros((len(lines), num_each_row))
for ith_row in list(range(0, len(lines))):
    cur_list = lines[ith_row].split()
    for ith_col in list(range(0, num_each_row)):
        data_set[ith_row, ith_col] = float(cur_list[ith_col])


num_sub = data_set.shape[0]
xx = np.mean(data_set, axis=0)
se = np.std(data_set, axis=0)/np.sqrt(num_sub)
gray_level = 96
bar_colors = [(gray_level/255, gray_level/255, gray_level/255)]*5
bar_colors[3]= np.round((188/255, 48/255, 117/255), 2)


plt.close('all')
font_size = 50
font = {'family': 'Arial',
        'weight': 'normal',
        'size': font_size}
matplotlib.rc('font', **font)
fig = plt.figure(figsize=(12, 7))
gs = gridspec.GridSpec(1, 1)
gs.update(left=0.25, right=0.95, top=0.95, bottom=0.25, wspace=0, hspace=0)
ax = fig.add_subplot(gs[0])
ax.bar(range(0, len(xx)), xx, width=0.45, color=bar_colors)
ax.set_xlabel('')
ax.set_xticks(range(0, len(xx)))
plt.xticks(rotation=35)
ax.set_xticklabels(['3-fold', '4-fold', '5-fold', '6-fold', '7-fold'], fontsize=font_size)
ax.set_ylabel('Beta value')
ax.errorbar(range(0, len(xx)), xx, se, fmt='.', color='Black', elinewidth=7, capthick=7, capsize = 15)
for axis in ['top', 'right']:
    ax.spines[axis].set_linewidth(0)
for axis in ['bottom', 'left']:
    ax.spines[axis].set_linewidth(6)
plt.show()

