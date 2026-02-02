
import pandas as pd
import plotly.graph_objects as go
from pathlib import Path


# ground
ground_x = []
ground_y = []
ground_z = []
for ith_x in list(range(0, 45)):
    for ith_y in list(range(0, 45)):
        ground_x.append(ith_x)
        ground_y.append(ith_y)
        ground_z.append(0)
z = [0.01] * len(ground_x)
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
index_outcome = plane_pos_table.index[(plane_pos_table['x'] == 22) & (plane_pos_table['y'] == 22)].tolist()
color_index[index_outcome[0]] = 'rgb(0, 0, 255)'


# load trajectory
tra_table = pd.read_csv(Path.cwd() / "data" / "sub4_trajectory_pos_for_plot.csv")
tra_x = tra_table['x'].tolist()
tra_y = tra_table['y'].tolist()
tra_z = [1] * len(ground_x)
tra_x = [i*21 for i in tra_x]
tra_y = [i*21 for i in tra_y]
tra_x = [i+1.25 for i in tra_x]
tra_y = [i-3.25 for i in tra_y]

layout = go.Layout(
  margin=go.layout.Margin(
        l=0, #left margin
        r=0, #right margin
        b=0, #bottom margin
        t=0, #top margin
    )
)

df = pd.DataFrame(data={'x': ground_x, 'y': ground_y, 'z': z, 'color': color_index})
mainfig = go.Figure(data=go.Scatter3d(x=df['x'], y=df['y'], z=df['z']+0.2, mode='markers', marker=dict(color=df['color'], size=6, line=dict(width=5, color='black'))),
                    layout=layout)
line_trace = go.Scatter3d(x=tra_x, y=tra_y, z=tra_z, mode='lines', line=dict(color="rgb(0, 0, 0)", width=15))
mainfig.add_trace(line_trace)
line_trace = go.Scatter3d(x=[0], y=[0], z=[20], line=dict(color="rgb(255, 255, 255)", width=1))
mainfig.add_trace(line_trace)
mainfig.update_scenes(xaxis_showgrid=False, yaxis_showgrid=False, zaxis_showgrid=False,
                      xaxis_showbackground=False, yaxis_showbackground=False, zaxis_showbackground=False,
                      xaxis_showticklabels=False, yaxis_showticklabels=False, zaxis_showticklabels=False,
                      xaxis_showaxeslabels=False, yaxis_showaxeslabels=False, zaxis_showaxeslabels=False,
                      xaxis_showticksuffix=None,
                      camera=
                        {'eye': {'x': 0.5, 'y': -1.5, 'z': 1},
                         'up': {'x': 0, 'y': 1, 'z': 1},
                         'center': {'x': -0.05, 'y': -0.1, 'z': -0.4}}
                        )

mainfig.update(layout_showlegend=False)
mainfig.show()




