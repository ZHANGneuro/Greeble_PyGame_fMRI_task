
import numpy as np
import plotly.graph_objects as go
import pandas as pd
import re
from os import listdir
from pathlib import Path

ConSink = np.load(Path.cwd() / "data"/ "sink_rep_goal_low.npy")
n = ConSink.shape[0]
mypath = Path.cwd() / "data"/ "fig6c_nav_sim_result"
traj_list = np.array([str(mypath) + '/'+ f for f in listdir(mypath) if "file_trajectory_" in f])
corr_index_list = [int(re.search('ith(.*)_dir', f).group(1)) for f in traj_list]
traj_list = traj_list[np.argsort(corr_index_list)].tolist()

coor_start_x = []
coor_start_y = []
coor_circle_x =[]
coor_circle_y = []
for ith_file in list(range(0, len(traj_list))):
    cur_locs = np.load(traj_list[ith_file])
    coor_start_x.append(cur_locs[0, 0])
    coor_start_y.append(cur_locs[0, 1])


# export excel
path_label = []
coor_x = []
coor_y = []
for ith_file in list(range(0, len(traj_list))):
    cur_locs = np.load(traj_list[ith_file])
    for ith_row in list(range(0, len(cur_locs))):
        path_label.append('Path' + str(ith_file))
        coor_x.append(cur_locs[ith_row][0])
        coor_y.append(cur_locs[ith_row][1])
path_label = np.array(path_label)
coor_x = np.array(coor_x)
coor_y = np.array(coor_y)

# import pandas as pd
# data_set = np.concatenate((path_label.reshape(-1, 1), coor_x.reshape(-1, 1), coor_y.reshape(-1, 1)), axis=1)
# df = pd.DataFrame(data_set)
# df.to_excel("/Users/bo/Documents/data_liujia_lab/manuscript_gridcell3hz/submission_elife/figs/Figure 6-source data 1.xlsx", index=False, header=False)
# #

# ground
ground = np.zeros((n, n))
for ith_x in list(range(0, n)):
    for ith_y in list(range(0, n)):
        ground[ith_x, ith_y] = 0

sphere_x = []
sphere_y = []
sphere_color = []
z_height = []
sphere_size = []
for ith in list(range(0, len(coor_start_x))):
    sphere_x.append(coor_start_x[ith])
    sphere_y.append(coor_start_y[ith])
    sphere_color.append('rgb(183, 113, 57)')
    z_height.append(0)
    sphere_size.append(30)
sphere_x.append(int(n/2))
sphere_y.append(int(n/2))
sphere_color.append('rgb(0, 0, 255)') # blue
z_height.append(0)
sphere_size.append(30)

df_sphere = pd.DataFrame(data={'x': sphere_x, 'y': sphere_y, 'z': z_height, 'color': sphere_color})

fig = go.Figure(data=go.Surface(z=ground, opacity=1, colorscale=['rgb(224, 224, 224)', 'rgb(224, 224, 224)'], showscale=False))
for ith_line in list(range(0, len(traj_list))):
    cur_line = np.load(traj_list[ith_line])
    fig.add_trace(go.Scatter3d(
        x=cur_line[:,0],
        y=cur_line[:,1],
        z=np.zeros_like(cur_line[:,0])+0.2,
        mode='lines',
        line=dict(color='rgb(0, 0, 0)', width=10),
        opacity=1
    ))
cur_scatter3d = go.Scatter3d(x=df_sphere['x'], y=df_sphere['y'], z=df_sphere['z'], mode='markers',
                             marker=dict(size=sphere_size, color=sphere_color, opacity=1))
fig.add_trace(cur_scatter3d)
fig.update_scenes(xaxis_showgrid=False, yaxis_showgrid=False, zaxis_showgrid=False,
                      xaxis_showbackground=False, yaxis_showbackground=False, zaxis_showbackground=False,
                      xaxis_showticklabels=False, yaxis_showticklabels=False, zaxis_showticklabels=False,
                      xaxis_showaxeslabels=False, yaxis_showaxeslabels=False, zaxis_showaxeslabels=False,
                      xaxis_showticksuffix=None,
                      camera={
                          'eye': {'x': 0, 'y': 0, 'z': 10},
                          'up': {'x': 0, 'y': 1, 'z': 0},
                          'center': {'x': 0, 'y': 0, 'z': 0}
                      }
                    )
fig.update_layout(
    margin=dict(l=0, r=0, t=0, b=0),  # 去掉四周所有空白
    scene=dict(
        xaxis=dict(visible=False),
        yaxis=dict(visible=False),
        zaxis=dict(visible=False),
        aspectmode='data'
    ),
    paper_bgcolor='rgba(0,0,0,0)',
    plot_bgcolor='rgba(0,0,0,0)',
)
fig.update(layout_showlegend=False)
fig.show()


