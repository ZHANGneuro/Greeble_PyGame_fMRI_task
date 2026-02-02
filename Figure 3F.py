

from matplotlib import gridspec
import matplotlib
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

cur_fold = 3

cur_path = Path.cwd() / "data" / "txt_barchart_"f"{cur_fold}_fold_effect_erc_handdraw_g12_2025.txt"

with open(cur_path) as f:
    lines = [line for line in f]
num_each_row = len(lines[0].split())
data_set = np.zeros((len(lines), num_each_row))
for ith_row in list(range(0, len(lines))):
    cur_list = lines[ith_row].split()
    for ith_col in list(range(0, num_each_row)):
        data_set[ith_row, ith_col] = float(cur_list[ith_col])
num_sub = data_set.shape[0]

# #
# import pandas as pd
# df = pd.DataFrame(data_set)
# df.to_excel("/Users/bo/Documents/data_liujia_lab/manuscript_gridcell3hz/submission_elife/figs/Figure 3-source data 2.xlsx", index=False, header=False)
# #

xx = np.mean(data_set, axis=0)
se = np.std(data_set, axis=0)/np.sqrt(num_sub)
gray_color = (115/255, 115/255, 115/255)
cur_color = (145/255,248/255, 89/255)
bar_colors = [gray_color, gray_color, cur_color, gray_color, gray_color, gray_color, cur_color, gray_color, gray_color, gray_color, cur_color, gray_color]


plt.close('all')
font_size = 47
font = {'family': 'Arial',
        'weight': 'normal',
        'size': font_size}
matplotlib.rc('font', **font)
fig = plt.figure(figsize=(10, 7))
gs = gridspec.GridSpec(1, 1)
gs.update(left=0.22, right=0.95, top=0.95, bottom=0.2, wspace=0, hspace=0)
ax = fig.add_subplot(gs[0])
ax.bar(range(0, len(xx)), xx, width=0.8, color=bar_colors)
ax.set_xlabel('')
ax.set_xticks(np.linspace(0, 11, 6))
plt.xticks(rotation=35)
ax.set_xticklabels(["0°","60°","120°","180°","240°","300°"])
ax.set_ylabel('Beta value')
ax.errorbar(range(0, len(xx)), xx, se, fmt='.', color='Black', elinewidth=7, capthick=7, capsize = 15)
for axis in ['top', 'right']:
    ax.spines[axis].set_linewidth(0)
for axis in ['bottom', 'left']:
    ax.spines[axis].set_linewidth(6)
plt.show()




