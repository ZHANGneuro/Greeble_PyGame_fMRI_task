

import sys, os
# os.environ['SDL_VIDEODRIVER'] = 'windows'
import pygame
import random
import tkinter.font
import numpy as np
import pandas as pd
import func_training_mrikey, func_MRI_mrikey, func_MRI_prac_mrikey

config_name = 'myapp.cfg'
if getattr(sys, 'frozen', False):
    application_path = os.path.dirname(sys.executable)
    running_mode = 'Frozen/executable'
else:
    try:
        app_full_path = os.path.realpath(__file__)
        application_path = os.path.dirname(app_full_path)
        running_mode = "Non-interactive (e.g. 'python myapp.py')"
    except NameError:
        application_path = os.getcwd()
        running_mode = 'Interactive'
config_full_path = os.path.join(application_path, config_name)

screen_width = 1024
screen_height = 768
stimuli_width = 350
stimuli_height = 350
sub_fee_pool = []
time_sleep = 0
on_greeble_morphing = False

#
raw_table = pd.read_csv(application_path + "/dataset_1_2_space_withTitle.csv")  # raw_table.columns
# raw_table = pd.read_csv(application_path + "/dataset_91_point_space_with_title.csv")  # raw_table.columns
value_x_list = raw_table['row'].to_list()
value_y_list = raw_table['col'].to_list()
position_x_list = raw_table['row_ith'].to_list()
position_y_list = raw_table['col_ith'].to_list()

aa = np.unique(np.sort(raw_table['angle'].to_list()))

pool_index_sp = []
stimuli_path_pool_o0 = []
stimuli_path_pool_o30 = []
stimuli_path_pool_o60 = []
stimuli_path_pool_o90 = []
stimuli_path_pool_o120 = []
stimuli_path_pool_o150 = []
stimuli_path_pool_o180 = []
stimuli_path_pool_o210 = []
stimuli_path_pool_o240 = []
stimuli_path_pool_o270 = []
stimuli_path_pool_o300 = []
stimuli_path_pool_o330 = []
[pool_index_sp.append(ith_value) for ith_value in list(range(len(raw_table['value']))) if raw_table['value'][ith_value]=='sp']
for cur_index in pool_index_sp:
    value_x = raw_table['row'][cur_index]
    value_y = raw_table['col'][cur_index]
    if str(value_x)[-1] == '0':
        value_x = int(value_x)
    if str(value_y)[-1] == '0':
        value_y = int(value_y)
    if raw_table['ang_con'][cur_index]==0:
        stimuli_path_pool_o0.append(application_path + "/stimuli_91_point_space/x_axis-" + str(value_x) + "-y_axis-" + str(value_y) + ".tif")
    if raw_table['ang_con'][cur_index]==30:
        stimuli_path_pool_o30.append(application_path + "/stimuli_91_point_space/x_axis-" + str(value_x) + "-y_axis-" + str(value_y) + ".tif")
    if raw_table['ang_con'][cur_index]==60:
        stimuli_path_pool_o60.append(application_path + "/stimuli_91_point_space/x_axis-" + str(value_x) + "-y_axis-" + str(value_y) + ".tif")
    if raw_table['ang_con'][cur_index]==90:
        stimuli_path_pool_o90.append(application_path + "/stimuli_91_point_space/x_axis-" + str(value_x) + "-y_axis-" + str(value_y) + ".tif")
    if raw_table['ang_con'][cur_index]==120:
        stimuli_path_pool_o120.append(application_path + "/stimuli_91_point_space/x_axis-" + str(value_x) + "-y_axis-" + str(value_y) + ".tif")
    if raw_table['ang_con'][cur_index]==150:
        stimuli_path_pool_o150.append(application_path + "/stimuli_91_point_space/x_axis-" + str(value_x) + "-y_axis-" + str(value_y) + ".tif")
    if raw_table['ang_con'][cur_index]==180:
        stimuli_path_pool_o180.append(application_path + "/stimuli_91_point_space/x_axis-" + str(value_x) + "-y_axis-" + str(value_y) + ".tif")
    if raw_table['ang_con'][cur_index]==210:
        stimuli_path_pool_o210.append(application_path + "/stimuli_91_point_space/x_axis-" + str(value_x) + "-y_axis-" + str(value_y) + ".tif")
    if raw_table['ang_con'][cur_index]==240:
        stimuli_path_pool_o240.append(application_path + "/stimuli_91_point_space/x_axis-" + str(value_x) + "-y_axis-" + str(value_y) + ".tif")
    if raw_table['ang_con'][cur_index]==270:
        stimuli_path_pool_o270.append(application_path + "/stimuli_91_point_space/x_axis-" + str(value_x) + "-y_axis-" + str(value_y) + ".tif")
    if raw_table['ang_con'][cur_index]==300:
        stimuli_path_pool_o300.append(application_path + "/stimuli_91_point_space/x_axis-" + str(value_x) + "-y_axis-" + str(value_y) + ".tif")
    if raw_table['ang_con'][cur_index]==330:
        stimuli_path_pool_o330.append(application_path + "/stimuli_91_point_space/x_axis-" + str(value_x) + "-y_axis-" + str(value_y) + ".tif")

def from_xy_to_position(x, y):
    value_x_index = value_x_list.index(x)
    value_y_index = value_y_list.index(y)
    p_x = position_x_list[value_x_index]
    p_y = position_y_list[value_y_index]
    return p_x, p_y

def from_position_to_xy(x, y):
    p_x_index = position_x_list.index(x)
    p_y_index = position_y_list.index(y)
    value_x = value_x_list[p_x_index]
    value_y = value_y_list[p_y_index]
    if str(value_x)[-1] == '0':
        value_x = int(value_x)
    if str(value_y)[-1] == '0':
        value_y = int(value_y)
    return value_x, value_y

def from_position_to_path(x, y):
    p_x_index = position_x_list.index(x)
    p_y_index = position_y_list.index(y)
    value_x = value_x_list[p_x_index]
    value_y = value_y_list[p_y_index]
    if str(value_x)[-1] == '0':
        value_x = int(value_x)
    if str(value_y)[-1] == '0':
        value_y = int(value_y)
    cur_path = application_path + "/stimuli_91_point_space/x_axis-" + str(value_x) + "-y_axis-" + str(value_y) + ".tif"
    return cur_path

def making_a_session(task_type):
    session_image_path_pool = []
    session_orientation_pool = []
    for ith_cond in [1, 2, 3]:
        session_image_path_pool.append(random.choice(stimuli_path_pool_o0))
        session_orientation_pool.append(0)
    for ith_cond in [1, 2, 3]:
        session_image_path_pool.append(random.choice(stimuli_path_pool_o30))
        session_orientation_pool.append(30)
    for ith_cond in [1, 2, 3]:
        session_image_path_pool.append(random.choice(stimuli_path_pool_o60))
        session_orientation_pool.append(60)
    for ith_cond in [1, 2, 3]:
        session_image_path_pool.append(random.choice(stimuli_path_pool_o90))
        session_orientation_pool.append(90)
    for ith_cond in [1, 2, 3]:
        session_image_path_pool.append(random.choice(stimuli_path_pool_o120))
        session_orientation_pool.append(120)
    for ith_cond in [1, 2, 3]:
        session_image_path_pool.append(random.choice(stimuli_path_pool_o150))
        session_orientation_pool.append(150)
    for ith_cond in [1, 2, 3]:
        session_image_path_pool.append(random.choice(stimuli_path_pool_o180))
        session_orientation_pool.append(180)
    for ith_cond in [1, 2, 3]:
        session_image_path_pool.append(random.choice(stimuli_path_pool_o210))
        session_orientation_pool.append(210)
    for ith_cond in [1, 2, 3]:
        session_image_path_pool.append(random.choice(stimuli_path_pool_o240))
        session_orientation_pool.append(240)
    for ith_cond in [1, 2, 3]:
        session_image_path_pool.append(random.choice(stimuli_path_pool_o270))
        session_orientation_pool.append(270)
    for ith_cond in [1, 2, 3]:
        session_image_path_pool.append(random.choice(stimuli_path_pool_o300))
        session_orientation_pool.append(300)
    for ith_cond in [1, 2, 3]:
        session_image_path_pool.append(random.choice(stimuli_path_pool_o330))
        session_orientation_pool.append(330)
    if task_type=='training':
        enu_session_image_path_pool = list(enumerate(session_image_path_pool))
        random.shuffle(enu_session_image_path_pool)
        shuffled_indices, shuffled_session_image_path_pool = zip(*enu_session_image_path_pool)
        shuffled_session_orientation_pool = []
        [shuffled_session_orientation_pool.append(session_orientation_pool[x]) for x in shuffled_indices]
    if task_type=='mri':
        session_image_path_pool.extend(['empty', 'empty', 'empty', 'empty'])
        session_orientation_pool.extend(['empty', 'empty', 'empty', 'empty'])
        enu_session_image_path_pool = list(enumerate(session_image_path_pool))
        random.shuffle(enu_session_image_path_pool)
        shuffled_indices, shuffled_session_image_path_pool = zip(*enu_session_image_path_pool)
        shuffled_session_image_path_pool = list(shuffled_session_image_path_pool)
        shuffled_session_orientation_pool = []
        [shuffled_session_orientation_pool.append(session_orientation_pool[x]) for x in shuffled_indices]
    return shuffled_session_image_path_pool, shuffled_session_orientation_pool


def give_a_fixed_time_interval(duration):
    # random_duration = int(round(random.uniform(1, 3) * 1000, 0))
    end_time = pygame.time.get_ticks() + duration
    on_iti = True
    while on_iti:
        pygame.event.pump()
        current_time = pygame.time.get_ticks()
        if current_time >= end_time:
            on_iti = False


def calculate_fee(cur_selection_error):
    import numpy as np
    # import matplotlib.pyplot as plt
    fee_weight = 3
    selection_error_pool = np.linspace(0, 3.8, 100, endpoint=True)
    fee = np.exp(fee_weight * selection_error_pool)
    # plt.plot(selection_error_pool, fee, '-r')
    # plt.show()
    fee_weight = 3
    return np.exp(-fee_weight * cur_selection_error)


def doing_training():
    func_training_mrikey.training(screen_width, screen_height, window, entry, application_path, stimuli_width, stimuli_height,
             give_a_fixed_time_interval, from_xy_to_position, from_position_to_xy, position_x_list, position_y_list,
             from_position_to_path, calculate_fee, making_a_session, sub_fee_pool, time_sleep, stimuli_path_pool_o60)

def doing_mri_practice():
    func_MRI_prac_mrikey.practice(screen_width, screen_height, window, application_path, stimuli_width, stimuli_height,
             give_a_fixed_time_interval, from_xy_to_position, position_x_list, position_y_list,
             from_position_to_path, making_a_session, time_sleep)

def doing_MRI():
    func_MRI_mrikey.mri_scanning(screen_width, screen_height, window, stimuli_width, stimuli_height, give_a_fixed_time_interval,
                 entry, application_path, time_sleep, making_a_session, from_xy_to_position, from_position_to_xy,
                 from_position_to_path, position_x_list, position_y_list, calculate_fee, sub_fee_pool)


tk_win_width = 350
tk_win_height = 450
text_width = 10
text_height = 5
button_width = 25
button_height = 3
window = tkinter.Tk()
window.title('Task option')
window.geometry("350x450")
myFont = tkinter.font.Font(size=15)

entry_label = tkinter.Label(window, text="被试编号")
entry_label.place(x=tk_win_width*0.1, y=tk_win_height-9*tk_win_height/10)
entry = tkinter.Entry(window, textvariable="aa", font=myFont, width=text_width)
entry.place(x=tk_win_width*0.1, y=tk_win_height-8.5*tk_win_height/10)

btn1 = tkinter.Button(window, text="[Day 1] Training & test", command=doing_training, width=button_width, height=button_height)
btn1.place(x=tk_win_width*0.1, y=tk_win_height-7*tk_win_height/10)
btn1['font'] = myFont
btn2 = tkinter.Button(window, text="[Day 2] MRI practice", command=doing_mri_practice, width=button_width, height=button_height)
btn2.place(x=tk_win_width*0.1, y=tk_win_height-5*tk_win_height/10)
btn2['font'] = myFont
# btn2['state'] = "disabled"
btn3 = tkinter.Button(window, text="[Day 2] MRI scanning", command=doing_MRI, width=button_width, height=button_height)
btn3.place(x=tk_win_width*0.1, y=tk_win_height-3*tk_win_height/10)
btn3['font'] = myFont
# btn3['state'] = "disabled"
window.mainloop()
