#---------
# Figure 1-source code 1
# Related to Figure 1d
# sub*_mri_record.txt files are also available from the Science Data Bank at https://doi.org/10.57760/sciencedb.18351
# csv_plot_pos.csv file is also accessible at https://github.com/ZHANGneuro/Greeble_PyGame_fMRI_task/blob/main/csv_plot_pos.csv
# Bo Zhang
# Feb/01/2026
#---------

# 3D plot
import numpy as np
import plotly.graph_objects as go
import pandas as pd
from pathlib import Path

data_set = np.zeros((320*33, 5))
counter = 0
sub_group = list(range(1, 29))
sub_group.extend([30,32,33,34,35])
for ith_sub in sub_group:
    cur_path = Path.cwd() / "data"/ f"sub{ith_sub}_mri_record.txt"

    with open(cur_path) as f:
        lines = [line.split("\t") for line in f]
    for ith_row in list(range(0, len(lines))):
        cur_list = lines[ith_row][0]
        lst = cur_list.split(' ')
        if lst[3] != 'na' and float(lst[3])==0 and float(lst[4])==0:
            print(ith_row)
        if lst[3] != 'na':
            data_set[counter, 0] = float(lst[3]) # start x
        if lst[4] != 'na':
            data_set[counter, 1] = float(lst[4]) # start y
        if lst[5] != 'na':
            data_set[counter, 2] = float(lst[5]) # end x
        if lst[6] != 'na':
            data_set[counter, 3] = float(lst[6]) # end y
        data_set[counter, 4] = int(lst[1])
        counter = counter + 1
data_set = data_set[np.where((data_set[:, 0] != 0) & (data_set[:, 1] != 0))[0], :]
counter_end_location = []
for ith in list(range(0, len(data_set[:,1]))):
    cur_x = data_set[ith, 2]
    cur_y = data_set[ith, 3]
    counter_end_location.append(len(np.where((data_set[:, 2] == cur_x) & (data_set[:, 3] == cur_y))[0]))
counter_end_location = np.array(counter_end_location)


ground_x = []
ground_y = []
ground_z = []
for ith_x in list(range(0, 45)):
    for ith_y in list(range(0, 45)):
        ground_x.append(ith_x)
        ground_y.append(ith_y)
        ground_z.append(0)
z = [0] * len(ground_x)
z_2d = z.copy()

coor_x = data_set[:,2] * 22
coor_y = data_set[:,3] * 22
coor_x = np.round(coor_x).astype(int)
coor_y = np.round(coor_y).astype(int)

for ith in list(range(0, len(coor_x))):
    z_2d[coor_x[ith]*45 + coor_y[ith]] = counter_end_location[ith]

plane_pos_table = pd.DataFrame(data={'x': ground_x, 'y': ground_y})
start_circle_table = pd.read_csv(Path.cwd() / "data" / "csv_plot_pos.csv")
start_pos_x = start_circle_table['row_ith'].tolist()
start_pos_y = start_circle_table['col_ith'].tolist()
color_index = ["rgb(224, 224, 224)"] * len(ground_x)
for ith_row_subject in list(range(0, len(start_pos_x))):
    cur_start_x = start_pos_x[ith_row_subject]
    cur_start_y = start_pos_y[ith_row_subject]
    index_outcome = plane_pos_table.index[(plane_pos_table['x'] == cur_start_x) & (plane_pos_table['y'] == cur_start_y)].tolist()
    if len(index_outcome) > 0:
        color_index[index_outcome[0]] = 'rgb(204, 102, 0)'

layout = go.Layout(
  margin=go.layout.Margin(
        l=0, #left margin
        r=0, #right margin
        b=0, #bottom margin
        t=0, #top margin
    )
)
z_2d = np.array(z_2d).reshape(45,45)

# #
# df = pd.DataFrame(z_2d)
# df.to_excel("/Users/bo/Documents/data_liujia_lab/manuscript_gridcell3hz/submission_elife/figs/Figure 1-source data 1.xlsx", index=False, header=False)
# #

ground_x_2d = np.array(ground_x).reshape(45, 45)
ground_y_2d = np.array(ground_y).reshape(45, 45)
fig = go.Figure(data=
                [go.Surface(x= ground_x_2d, y= ground_y_2d, z=z_2d, colorscale="RdPu", showscale=False)]
                )
df = pd.DataFrame(data={'x': ground_x, 'y': ground_y, 'z': z, 'color': color_index})
scatter_trace = go.Scatter3d(x=df['x'], y=df['y'], z=df['z']+0.2, mode='markers', marker=dict(color=df['color'], size=6, line=dict(width=5, color='black')))
fig.add_trace(scatter_trace)
fig.update_scenes(xaxis_showgrid=False, yaxis_showgrid=False, zaxis_showgrid=False,
                      xaxis_showbackground=False, yaxis_showbackground=False, zaxis_showbackground=False,
                      xaxis_showticklabels=False, yaxis_showticklabels=False, zaxis_showticklabels=False,
                      xaxis_showaxeslabels=False, yaxis_showaxeslabels=False, zaxis_showaxeslabels=False,
                      xaxis_showticksuffix=None,
                      camera=
                      {'eye': {'x': 0.5, 'y': -1.5, 'z': 1},
                       'up': {'x': 0, 'y': 1, 'z': 1},
                       'center': {'x': -0.05, 'y': -0.1, 'z': -0.4}}
                      )
fig.show()
