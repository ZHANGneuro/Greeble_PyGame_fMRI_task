import numpy as np
import scipy
import scipy.signal
import scipy.ndimage as ndimage

def plot_C(ConSink):
    plt.close('all')
    fig = plt.figure(figsize=(7, 7))
    ax = fig.add_subplot()
    ax.imshow(ConSink, cmap='jet')
    ax.get_xaxis().set_ticks([])
    ax.get_yaxis().set_ticks([])
    ax.get_xaxis().set_ticks([])
    ax.get_yaxis().set_ticks([])
    plt.show()

def plot_start_locs(coor_circle_x, coor_circle_y,n):
    plt.close('all')
    aa = np.zeros((n,n))
    aa[coor_circle_x, coor_circle_y] = 1
    fig = plt.figure(figsize=(7, 7),facecolor='white')
    ax = fig.add_subplot()
    ax.get_xaxis().set_ticks([])
    ax.get_yaxis().set_ticks([])
    for axis in ['top', 'bottom', 'left', 'right']:
        ax.spines[axis].set_linewidth(1)
        ax.spines[axis].set_color((149 / 255, 163 / 255, 151 / 255))
    plt.imshow(1-aa, cmap='gray', vmin=0, vmax=1)
    plt.subplots_adjust(left=0, right=1, top=1, bottom=0)
    plt.show()

def plot_start_locs_on_C(coor_circle_x, coor_circle_y, ConSink):
    ConSink[coor_circle_x, coor_circle_y] = np.max(ConSink)
    fig = plt.figure(figsize=(7, 7),facecolor='white')
    ax = fig.add_subplot()
    ax.get_xaxis().set_ticks([])
    ax.get_yaxis().set_ticks([])
    for axis in ['top', 'bottom', 'left', 'right']:
        ax.spines[axis].set_linewidth(1)
        ax.spines[axis].set_color((149 / 255, 163 / 255, 151 / 255))
    plt.imshow(ConSink)
    plt.subplots_adjust(left=0, right=1, top=1, bottom=0)
    plt.show()

def access_shortest_path(x,y, goal_loc):
    loc_list = np.array([x, y]).reshape(1,2).astype(int)
    while 1:
        opt1 = np.array([1, 0]).reshape(1,2) + loc_list[-1]
        opt2 = np.array([0, 1]).reshape(1,2) + loc_list[-1]
        opt3 = np.array([0, -1]).reshape(1, 2) + loc_list[-1]
        opt4 = np.array([-1, 0]).reshape(1, 2) + loc_list[-1]

        distance1 = np.sqrt((goal_loc[0] - opt1[0][0]) ** 2 + (goal_loc[1] - opt1[0][1]) ** 2)
        distance2 = np.sqrt((goal_loc[0] - opt2[0][0]) ** 2 + (goal_loc[1] - opt2[0][1]) ** 2)
        distance3 = np.sqrt((goal_loc[0] - opt3[0][0]) ** 2 + (goal_loc[1] - opt3[0][1]) ** 2)
        distance4 = np.sqrt((goal_loc[0] - opt4[0][0]) ** 2 + (goal_loc[1] - opt4[0][1]) ** 2)
        index_max = np.argmin([distance1, distance2, distance3, distance4])

        new_loc= [opt1, opt2, opt3, opt4][index_max]

        if (new_loc[0, 0]!=goal_loc[0]) or (new_loc[0, 1]!=goal_loc[1]):
            loc_list = np.append(loc_list, new_loc, axis=0)
        else:
            break
    return loc_list

def z_normalize(input):
    output = np.zeros((4, n, n))
    for ith in list(range(0, 4)):
        x = input[ith]
        output[ith] = (x-np.min(x))/(np.max(x)-np.min(x))
    return output

def access_distance_map(n, goal_loc):
    size = n
    x = np.linspace(0, size-1, size)
    y = np.linspace(0, size-1, size)
    X, Y = np.meshgrid(y, x)
    x0, y0 = goal_loc[0], goal_loc[1]  # 正中心
    sigma = np.round(n/2).astype(int)
    # 高斯函数
    distance_map = np.exp(-((X - x0)**2 + (Y - y0)**2) / (2 * sigma**2))
    return distance_map


def sigmoid(x):
  return 1 / (1 + np.exp(-x))

def access_coor_of_circle(radius, offset):
    coor_x = np.cos(np.linspace(0, np.pi * 2, 360, endpoint=False)) * radius + offset[0]
    coor_x = np.round(coor_x).astype(int)
    coor_y = np.sin(np.linspace(0, np.pi * 2, 360, endpoint=False)) * radius + offset[1]
    coor_y = np.round(coor_y).astype(int)
    return coor_x, coor_y

def minimum_diff_angle(angle, ref_direction):
  res = (angle-ref_direction)%180
  if res < 90:
    return res
  else:
    return (180-res)

def compute_mean_angle(angle_vector):
    x = y = 0
    for ith_ori in list(range(0, len(angle_vector))):
        cur_ori = angle_vector[ith_ori]
        x += np.cos(cur_ori*np.pi/180)
        y += np.sin(cur_ori*np.pi/180)
        mean_angle = np.round(np.remainder(np.arctan2(y, x) * 180/np.pi, 360))
    return mean_angle

def index_1d_to_2d(index_1d, n):
    return np.array([int(index_1d / n), int(index_1d % n)])

def index_2d_to_1d(x, y, n):
    return x * n + y

# make loc sink
n = 45
def get_distance(imagery_loc):
    return np.sqrt(np.abs((int(n / 2)-imagery_loc[0]))**2+ np.abs((int(n / 2)-imagery_loc[1]))**2)

def index_2d_to_1d(x, y, n):
    return x * n + y

# generate w weight
import numpy as np
import matplotlib.pyplot as plt
# planar wave for test
def gen_2d_wave(local_angle, cur_scale, loc_x, loc_y, n):
    resolution = 1
    amplitude = 1/3
    x = np.arange(0, n, resolution) - loc_x  # (loc_x / n) * cur_scale
    y = np.arange(0, n, resolution) - loc_y  # (loc_y / n) * cur_scale
    [xx, yy] = np.meshgrid(x, y)
    kx = np.cos(local_angle * np.pi / 180)
    ky = np.sin(local_angle * np.pi / 180)
    # w = 2 * np.pi / (np.sin(np.pi/3) * cur_scale)
    w = 2 * np.pi / (cur_scale)
    gradient_map = w * (kx * xx + ky * yy)
    plane_wave = amplitude * (np.cos(gradient_map))
    return plane_wave, gradient_map, w
