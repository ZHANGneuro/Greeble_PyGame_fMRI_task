
import matplotlib
import numpy as np
import matplotlib.pyplot as plt

angle_list = np.linspace(0, 350, 1000)
fold3 = np.cos(3*np.linspace(-np.pi/3, np.pi/3, len(angle_list), endpoint=False))
fold6 = np.cos(6*np.linspace(-np.pi/3, np.pi/3, len(angle_list), endpoint=False))
fold3 = (fold3-np.min(fold3))/(np.max(fold3) - np.min(fold3)) -0.5
fold6 = (fold6-np.min(fold6))/(np.max(fold6) - np.min(fold6)) -0.5
# one cycle
fontsize = 73
plt.close('all')
font = {'family': 'Arial',
        'weight': 'normal',
        'size': fontsize}
matplotlib.rc('font', **font)
fig, ax1 = plt.subplots(1, 1, figsize=(15, 10))
ax1.plot(angle_list, fold6, color= (160/255, 69/255, 113/255), linewidth = 13, alpha= 1)
ax1.set_xlabel('Phase (HPC)')
ax1.set_ylabel('ERC activity\n', color=(160/255, 69/255, 113/255), fontsize=fontsize*1.1)

# ax1.set_ylabel(r'$e^{i\theta_{HPC}}$', color='black', fontsize=fontsize*1.3)
# ax1.set_xticks([0, np.max(angle_list)], ['0', '2π'])
ax1.set_xticks([])
ax1.set_yticks([])
ax2 = ax1.twinx()
ax2.plot(angle_list, fold3, color = (109/255, 158/255, 45/255), linewidth = 13, alpha= 1)
# ax2.set_ylabel(r'$A_{ERC}$', color='black', fontsize=fontsize*1.3)
ax2.set_ylabel('\nHPC activity', color=(109/255, 158/255, 45/255), fontsize=fontsize*1.1)

ax2.tick_params(axis='y', labelcolor='black')
ax2.set_yticks([])
ax2.set_xticks([])
ax2.set_xticks([np.min(angle_list), int(np.mean(angle_list)), np.max(angle_list)], ['-π/3', '0', 'π/3'])

# ax2.set_xticks([0, np.max(angle_list)], ['0', '2π/3'])
for axis in ['top', 'bottom']:
    ax1.spines[axis].set_linewidth(0)
for axis in ['right', 'left']:
    ax1.spines[axis].set_linewidth(10)
for axis in ['top', 'bottom']:
    ax2.spines[axis].set_linewidth(0)
for axis in ['right', 'left']:
    ax2.spines[axis].set_linewidth(10)
plt.subplots_adjust(left=0.18, right=0.85, top=0.95, bottom=0.2)
plt.show()
