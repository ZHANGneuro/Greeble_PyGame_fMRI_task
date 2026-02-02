
import matplotlib
import numpy as np
import matplotlib.pyplot as plt
from scipy import stats
from pathlib import Path

cur_path = Path.cwd() / "data"/ "coupling_z_records_g123_fold36.txt"
# cur_path = Path.cwd() / "data"/ "coupling_z_records_g123_fold39.txt" #
# cur_path = Path.cwd() / "data"/ "coupling_z_records_g123_fold312.txt" #

with open(cur_path) as f:
    lines = [line.split("\t") for line in f]
data_set = np.zeros((len(lines), len(lines[0])))
for ith_row in list(range(0, len(lines))):
    for ith_col in list(range(0, len(lines[0]))):
        data_set[ith_row, ith_col] = lines[ith_row][ith_col]


con1 = data_set[:,5]
print((np.mean(con1))/ np.std(con1))
# t_stat, p_value = stats.ttest_rel(con1, con2)
t_stat, p_value = stats.ttest_1samp(data_set, popmean=0, alternative='greater')
p_value = p_value * 3

color_sig = (162/255, 201/255, 103/255)
color_non_sig = (255/255, 255/255, 255/255)
bar_colors = [color_sig if p < 0.05 else color_non_sig for p in p_value]

bar_condition = np.linspace(0, 360, 9).astype(int)
bar_count = np.mean(data_set, axis=0)
bar_error = np.std(data_set, axis=0)/np.sqrt(len(data_set))

plt.close('all')
fontsize = 70
font = {'family': 'Arial',
        'weight': 'normal',
        'size': fontsize}
matplotlib.rc('font', **font)
fig, ax1 = plt.subplots(1, 1, figsize=(18, 10))
plt.bar(bar_condition, bar_count, color=bar_colors, width= 25, edgecolor='black', linewidth=4)
plt.errorbar(bar_condition, bar_count, yerr=bar_error, fmt='o', color='black',  elinewidth=4, capsize=8, capthick=4)
for ith_bar in list(range(0, len(bar_condition))):
    ax1.scatter(np.array([bar_condition[ith_bar]]*len(data_set[:,ith_bar]))+20, data_set[:,ith_bar], s=400, color=bar_colors[ith_bar], edgecolors='black', linewidths=4, alpha=1)
ax1.set_ylabel('Coupling Strength', fontsize=fontsize*1)
ax1.set_xlabel('Phase (HPC)')
ax1.set_xticks([np.min(bar_condition), int(np.mean(bar_condition)), np.max(bar_condition)], ['-π', '0', 'π'])
for axis in ['top', 'bottom']:
    ax1.spines[axis].set_linewidth(0)
for axis in ['right', 'left']:
    ax1.spines[axis].set_linewidth(10)
ax1.set_ylim([-1, 1.2])
ax1.set_yticks([-1, 0, 1], ['-1', '0', '1'])
plt.subplots_adjust(left=0.2, right=0.95, top=0.95, bottom=0.2)
plt.show()


