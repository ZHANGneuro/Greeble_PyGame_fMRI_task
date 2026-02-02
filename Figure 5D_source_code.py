

# plv distribution
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from numpy import loadtxt
from scipy.stats import ttest_rel
from pathlib import Path

cur_dataset = Path.cwd() / "data"/ "plv_distribution.txt"
raw_data = loadtxt(cur_dataset, dtype=str).astype(float)

cur_table = raw_data[:,0]
thres_list = raw_data[:,1]

t_stat, p_value = ttest_rel(cur_table, thres_list)
(np.mean(cur_table) - np.mean(thres_list))/ np.std(cur_table + thres_list)


# #
# import pandas as pd
# df = pd.DataFrame(raw_data)
# df.to_excel("/Users/bo/Documents/data_liujia_lab/manuscript_gridcell3hz/submission_elife/figs/Figure 5-source data 3.xlsx", index=False, header=False)
# #


z_error = np.std(cur_table)/np.sqrt(len(cur_table))
z_surro_error = np.std(thres_list)/np.sqrt(len(thres_list))
plt.close('all')
fontsize = 50
font = {'family': 'Arial',
        'weight': 'normal',
        'size': fontsize}
matplotlib.rc('font', **font)
fig = plt.figure(figsize=(11, 11))
ax = fig.add_subplot()
ax.bar([1.5,4.5], [np.mean(cur_table), np.mean(thres_list)],width=1, color=[(135/255, 166/255, 148/255),(160/255, 160/255, 160/255)], edgecolor='black', linewidth=7)
ax.errorbar([1.5,4.5], [np.mean(cur_table), np.mean(thres_list)], [z_error, z_surro_error], fmt='None', color='Black', elinewidth=8, capthick=8, capsize = 10)
ax.scatter(np.array([1.5]*len(cur_table))+0.5, cur_table, s=500, color=(135/255, 166/255, 148/255), edgecolors='black', linewidths=5, alpha=1)
ax.scatter(np.array([4.5]*len(thres_list))+0.5, thres_list, s=500, color=(160/255, 160/255, 160/255), edgecolors='black', linewidths=5, alpha=1)
for axis in ['top','right']:
    ax.spines[axis].set_linewidth(0)
for axis in ['bottom','left']:
    ax.spines[axis].set_linewidth(8)
plt.xticks([0, 0.8, 4.5, 6], rotation=0)
ax.set_xticklabels(['', 'Brain–Behavior\nCoupling', 'Surrogates', ''], rotation=25, fontsize=fontsize*0.9)
plt.ylabel('Coupling Strength\n(PLV)', fontsize= fontsize*0.9)
plt.tight_layout()
plt.show()



