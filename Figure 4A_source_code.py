
from pathlib import Path
import numpy as np
import matplotlib.pyplot as plt
import matplotlib as mpl

cur_path = Path.cwd() / "data" / "txt_fig4a.txt"
with open(cur_path) as f:
    lines = [line.split("\t") for line in f]
data_set = np.zeros((len(lines), 2))
for ith_ele in list(range(0, len(lines))):
    cur_list = lines[ith_ele]
    data_set[ith_ele, 0] = float(cur_list[0])
    data_set[ith_ele, 1] = float(cur_list[1])


# import pandas as pd
# df = pd.DataFrame(data_set)
# df.to_excel("/Users/bo/Documents/data_liujia_lab/manuscript_gridcell3hz/submission_elife/figs/Figure 4-source data 1.xlsx", index=False, header=False)


sort_index = np.argsort(data_set[:,0])
phase_x = data_set[:,0][sort_index]
phase_y = data_set[:,1][sort_index]

phi_hpc_native=phase_x
phi_ec_native=phase_y

n = phi_hpc_native.size

theta_hpc = phi_hpc_native / (2*np.pi/3) * 2*np.pi   # HPC: 0–120° → 0–360°
theta_ec  = phi_ec_native  / (np.pi/3)   * 2*np.pi   # EC : 0–60°  → 0–360°

r_ec, r_hpc = 0.9, 1.1
cmap = mpl.colormaps['gist_stern']
colors_link = cmap((theta_hpc % (2*np.pi)) / (2*np.pi))
ec_color  = np.array([160, 69, 113]) / 255.0
hpc_color = np.array([152, 202, 88]) / 255.0

plt.close('all')
mpl.rc('font', family='Arial', size=70)
fig, ax = plt.subplots(1, 1, subplot_kw={'projection': 'polar'}, figsize=(12, 12))
ax.set_theta_zero_location('E')
ax.set_theta_direction(-1)

outer_r = 1.17
tick_len = 0.02   # 外周刻度长度
def draw_tick(ax_, theta, r0, length, color, lw=5, zorder=1):
    ax_.plot([theta, theta], [r0 - length, r0], color=color, lw=lw, zorder=zorder)

angle_plot = np.linspace(0, 360, 3, endpoint=False)
for deg in angle_plot:
    th = np.deg2rad(deg)        # 映射整圆
    draw_tick(ax, th, outer_r, tick_len, 'black', lw=15)

for i in range(n):
    ax.plot([theta_ec[i], theta_hpc[i]], [r_ec, r_hpc],
            color=colors_link[i], lw=4, alpha=0.9, zorder=2)


ax.scatter(theta_ec,  np.full(n, r_ec),  c=[ec_color],  s=1000, edgecolor='k', lw=5, zorder=3)
ax.scatter(theta_hpc, np.full(n, r_hpc), c=[hpc_color], s=1000, edgecolor='k', lw=5, zorder=3)

ax.set_xticks([]); ax.set_yticks([])
ax.spines['polar'].set_visible(False)
ax.set_rlim(0.75, 1.3)

plt.subplots_adjust(left=0, right=1, top=1, bottom=0)
plt.subplots_adjust(left=0, right=1, top=1, bottom=0)
outpath = '/Users/bo/Documents/data_liujia_lab/manuscript_gridcell3hz/fig4a.png'
plt.savefig(outpath, dpi=200, bbox_inches='tight', pad_inches=0)
# plt.show()
