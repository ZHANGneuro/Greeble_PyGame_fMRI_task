
import pygame
import time
import glob
import random
import re
import tkinter
import tkinter.font
import sys, os
import numpy as np
import pandas as pd


##############################
# training
##############################
def training(screen_width, screen_height, window, entry, application_path, stimuli_width, stimuli_height,
             give_a_fixed_time_interval, from_xy_to_position, from_position_to_xy, position_x_list, position_y_list,
             from_position_to_path, calculate_fee, making_a_session, sub_fee_pool, time_sleep, stimuli_path_pool_o60):
    # create pygame window
    pygame.init()
    screen = pygame.display.set_mode((screen_width, screen_height), pygame.FULLSCREEN)
    # screen = pygame.display.set_mode((screen_width, screen_height))
    screen.fill(pygame.Color("black"))
    pygame.display.update()
    pygame.display.set_caption('Grid cell task')
    window.wm_state('iconic')
    sub_no = entry.get()
    font = pygame.font.Font(application_path + "/STHeiti_Light.ttc", 30)

    # define function
    def show_text(text_input):
        screen.fill(pygame.Color("black"))
        text_inst = font.render(text_input, True, pygame.Color("white"))
        text_inst_rect = text_inst.get_rect(center=(screen_width / 2, screen_height / 2))
        screen.blit(text_inst, text_inst_rect)
        pygame.display.update()

    def show_fixation():
        line_length_factor = 0.02
        screen.fill(pygame.Color("black"))
        pygame.draw.line(screen, pygame.Color("white"),
                         (screen_width / 2 - screen_width * line_length_factor, screen_height / 2),
                         (screen_width / 2 + screen_width * line_length_factor, screen_height / 2), width=5)
        pygame.draw.line(screen, pygame.Color("white"),
                         (screen_width / 2, screen_height / 2 - screen_height * line_length_factor),
                         (screen_width / 2, screen_height / 2 + screen_height * (line_length_factor + 0.005)), width=5)
        pygame.display.update()

    def show_baseline_greeble():
        screen.fill(pygame.Color("black"))
        baseline_greeble_path = application_path + '/stimuli_91_point_space/target_image-01.tif'
        cur_ima = pygame.image.load(baseline_greeble_path)
        cur_ima = pygame.transform.scale(cur_ima, (stimuli_width, stimuli_height))
        screen.blit(cur_ima, (screen_width / 2 - stimuli_width / 2, screen_height / 2 - stimuli_height / 2))
        text_l1 = font.render("这是一个积木，作为游戏目标", True, pygame.Color("white"))
        # text_l1 = font.render("This is the target", True, pygame.Color("white"))
        text_l1_rect = text_l1.get_rect(center=(screen_width / 2, screen_height / 2 - 8 * screen_height / 20))
        screen.blit(text_l1, text_l1_rect)
        text_l2 = font.render("请记住 Loogit 和 Vacso 的长度", True, pygame.Color("white"))
        # text_l2 = font.render("Please remember the length of Loogit and Vacso", True, pygame.Color("white"))
        text_l2_rect = text_l2.get_rect(center=(screen_width / 2, screen_height / 2 - 7 * screen_height / 20))
        screen.blit(text_l2, text_l2_rect)
        text_l3 = font.render("按回车键继续", True, pygame.Color("white"))
        # text_l3 = font.render("Press Enter key to continue", True, pygame.Color("white"))
        text_l3_rect = text_l3.get_rect(center=(screen_width / 2, screen_height / 2 - 6 * screen_height / 20))
        screen.blit(text_l3, text_l3_rect)
        text_l4 = font.render("Loogit 长度 = 1", True, pygame.Color("white"))
        # text_l4 = font.render("current length of Loogit = 1", True, pygame.Color("white"))
        text_l4_rect = text_l4.get_rect(center=(screen_width / 2, screen_height / 2 + 6 * screen_height / 20))
        screen.blit(text_l4, text_l4_rect)
        text_l5 = font.render("Vacso 长度 = 1", True, pygame.Color("white"))
        # text_l5 = font.render("current length of Vacso = 1", True, pygame.Color("white"))
        text_l5_rect = text_l5.get_rect(center=(screen_width / 2, screen_height / 2 + 7 * screen_height / 20))
        screen.blit(text_l5, text_l5_rect)
        pygame.display.update()
        # # screenshot
        # rect = pygame.Rect(112, 84, 800, 600)
        # sub = screen.subsurface(rect)
        # pygame.image.save(sub, "/Users/bo/Desktop/practice_intro.png")

    def show_stimuli_inst(file_name):
        screen.fill(pygame.Color("black"))
        cur_vacso_len_str = str(round(float(re.search('x_axis-(.*)-y_axis', file_name).group(1)), 1))
        cur_loogit_len_str = str(round(float(re.search('y_axis-(.*).tif', file_name).group(1)), 1))
        cur_ima = pygame.image.load(file_name)
        cur_ima = pygame.transform.scale(cur_ima, (stimuli_width, stimuli_height))
        screen.blit(cur_ima, (screen_width / 2 - stimuli_width / 2, screen_height / 2 - stimuli_height / 2))
        # show inst
        text_l1 = font.render("按左右键调整 Loogit 长度, 上下键调整 vacso 长度", True, pygame.Color("white"))
        text_l1_rect = text_l1.get_rect(center=(screen_width / 2, screen_height / 2 - 8 * screen_height / 20))
        screen.blit(text_l1, text_l1_rect)
        text_l2 = font.render("使他们和目标积木的长度相同", True, pygame.Color("white"))
        text_l2_rect = text_l2.get_rect(center=(screen_width / 2, screen_height / 2 - 7 * screen_height / 20))
        screen.blit(text_l2, text_l2_rect)
        text_l3 = font.render("完成后按回车键", True, pygame.Color("white"))
        text_l3_rect = text_l3.get_rect(center=(screen_width / 2, screen_height / 2 - 6 * screen_height / 20))
        screen.blit(text_l3, text_l3_rect)
        text_l4 = font.render("Loogit 长度 = " + cur_loogit_len_str, True, pygame.Color("white"))
        text_l4_rect = text_l4.get_rect(center=(screen_width / 2, screen_height / 2 + 6 * screen_height / 20))
        screen.blit(text_l4, text_l4_rect)
        text_l5 = font.render("Vacso 长度 = " + cur_vacso_len_str, True, pygame.Color("white"))
        text_l5_rect = text_l5.get_rect(center=(screen_width / 2, screen_height / 2 + 7 * screen_height / 20))
        screen.blit(text_l5, text_l5_rect)
        pygame.display.update()

    def show_stimuli_beh(input_image_path, with_feedback):
        screen.fill(pygame.Color("black"))
        cur_ima = pygame.image.load(input_image_path)
        cur_ima = pygame.transform.scale(cur_ima, (stimuli_width, stimuli_height))
        screen.blit(cur_ima, (screen_width / 2 - stimuli_width / 2, screen_height / 2 - stimuli_height / 2))
        if with_feedback:
            cur_vacso_len_float = round(float(re.search('x_axis-(.*)-y_axis', input_image_path).group(1)), 1)
            cur_loogit_len_float = round(float(re.search('y_axis-(.*).tif', input_image_path).group(1)), 1)
            if cur_loogit_len_float > 1:
                text_l1 = font.render("Loogit: 比目标长了" + str(round(cur_loogit_len_float-1, 2)), True, pygame.Color("white"))
                # text_l1 = font.render("Loogit: " + str(round(cur_loogit_len_float - 1, 2)) + " longer than target", True, pygame.Color("white"))
            if cur_loogit_len_float < 1:
                text_l1 = font.render("Loogit: 比目标短了" + str(round(1-cur_loogit_len_float, 2)), True, pygame.Color("white"))
                # text_l1 = font.render("Loogit: " + str(round(1 - cur_loogit_len_float, 2)) + " shorter than target", True, pygame.Color("white"))
            if cur_loogit_len_float == 1:
                text_l1 = font.render("Loogit: 很好!", True, pygame.Color("white"))
                # text_l1 = font.render("Loogit: good!", True, pygame.Color("white"))
            if cur_vacso_len_float > 1:
                text_l2 = font.render("Vacso: 比目标长了" + str(round(cur_vacso_len_float-1, 2)), True, pygame.Color("white"))
                # text_l2 = font.render("Vacso: " + str(round(cur_loogit_len_float - 1, 2)) + " longer than target", True, pygame.Color("white"))
            if cur_vacso_len_float < 1:
                text_l2 = font.render("Vacso: 比目标短了" + str(round(1-cur_vacso_len_float, 2)), True, pygame.Color("white"))
                # text_l2 = font.render("Vacso: " + str(round(1 - cur_loogit_len_float, 2)) + " shorter than target", True, pygame.Color("white"))
            if cur_vacso_len_float == 1:
                text_l2 = font.render("Vacso: 很好!", True, pygame.Color("white"))
                # text_l2 = font.render("Vacso: good!", True, pygame.Color("white"))
            text_l1_rect = text_l1.get_rect(center=(screen_width / 2, screen_height / 2 + 6 * screen_height / 20))
            screen.blit(text_l1, text_l1_rect)
            text_l2_rect = text_l2.get_rect(center=(screen_width / 2, screen_height / 2 + 7 * screen_height / 20))
            screen.blit(text_l2, text_l2_rect)
            text_l3 = font.render("按回车键继续", True, pygame.Color("white"))
            # text_l3 = font.render("Press Enter to continue", True, pygame.Color("white"))
            text_l3_rect = text_l3.get_rect(center=(screen_width / 2, screen_height / 2 + 9 * screen_height / 20))
            screen.blit(text_l3, text_l3_rect)
        pygame.display.update()
        # # screenshot
        # rect = pygame.Rect(112, 84, 800, 600)
        # sub = screen.subsurface(rect)
        # pygame.image.save(sub, "/Users/bo/Desktop/practice_trial_end.png")

    def trial_maker(is_formal, with_feedback, is_ending):
        shuffled_session_image_path_pool, shuffled_session_orientation_pool = making_a_session(task_type='training')
        if with_feedback:
            trial_type = "practice"
        else:
            trial_type = "testing"
        if is_formal:
            num_trial = len(shuffled_session_image_path_pool)
        else:
            num_trial = 4
        performance_pool = []
        for ith_trial in list(range(0, num_trial)):
            show_fixation()  # show fix
            give_a_fixed_time_interval(duration=1500)  # give a interval
            cur_image_path = shuffled_session_image_path_pool[ith_trial]
            show_stimuli_beh(input_image_path=cur_image_path, with_feedback=False)
            time_stimuli_displayed = pygame.time.get_ticks()
            ori_x = float(re.search('x_axis-(.*)-y_axis', cur_image_path).group(1))
            ori_y = float(re.search('y_axis-(.*).tif', cur_image_path).group(1))
            cur_trial_ori = shuffled_session_orientation_pool[ith_trial]
            p_x, p_y = from_xy_to_position(ori_x, ori_y)
            ori_p_x = p_x
            ori_p_y = p_y

            # # screenshot
            # rect = pygame.Rect(112, 84, 800, 600)
            # sub = screen.subsurface(rect)
            # pygame.image.save(sub, "/Users/bo/Desktop/practice_stimuli_show.png")

            on_greeble_morphing = True
            while on_greeble_morphing:
                pygame.event.pump()
                for event in pygame.event.get():
                    if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_q):
                        on_greeble_morphing = False
                        next_while = False
                        end_screen_while = True
                        pygame.quit()
                keys = pygame.key.get_pressed()
                if keys[pygame.K_LEFT]:
                    p_y = p_y - 1
                    if p_y < 0:
                        p_y = 0
                    cur_x, cur_y = from_position_to_xy(p_x, p_y)
                    show_stimuli_beh(input_image_path=from_position_to_path(p_x, p_y), with_feedback=False)
                    if is_formal:
                        f_details = open(application_path + "/sub" + str(sub_no) + "_beh_detail" + ".txt", 'a')
                        details_pool = np.array([str(sub_no), str(ith_sess), str(ith_trial), trial_type,
                                                 str(cur_trial_ori), str(ori_x), str(ori_y), str(cur_x),
                                                 str(cur_y), str(ori_p_x), str(ori_p_y), str(p_x), str(p_y)])
                        np.savetxt(f_details, details_pool, fmt="%s", delimiter="\t", newline=" ")
                        f_details.write("\n")
                        f_details.close()
                if keys[pygame.K_RIGHT]:
                    p_y = p_y + 1
                    if p_y > np.max(position_y_list):
                        p_y = np.max(position_y_list)
                    cur_x, cur_y = from_position_to_xy(p_x, p_y)
                    show_stimuli_beh(input_image_path=from_position_to_path(p_x, p_y), with_feedback=False)
                    if is_formal:
                        f_details = open(application_path + "/sub" + str(sub_no) + "_beh_detail" + ".txt", 'a')
                        details_pool = np.array([str(sub_no), str(ith_sess), str(ith_trial), trial_type,
                                                 str(cur_trial_ori), str(ori_x), str(ori_y), str(cur_x),
                                                 str(cur_y), str(ori_p_x), str(ori_p_y), str(p_x), str(p_y)])
                        np.savetxt(f_details, details_pool, fmt="%s", delimiter="\t", newline=" ")
                        f_details.write("\n")
                        f_details.close()
                if keys[pygame.K_UP]:
                    p_x = p_x - 1
                    if p_x < 0:
                        p_x = 0
                    cur_x, cur_y = from_position_to_xy(p_x, p_y)
                    show_stimuli_beh(input_image_path=from_position_to_path(p_x, p_y), with_feedback=False)
                    if is_formal:
                        f_details = open(application_path + "/sub" + str(sub_no) + "_beh_detail" + ".txt", 'a')
                        details_pool = np.array([str(sub_no), str(ith_sess), str(ith_trial), trial_type,
                                                 str(cur_trial_ori), str(ori_x), str(ori_y), str(cur_x),
                                                 str(cur_y), str(ori_p_x), str(ori_p_y), str(p_x), str(p_y)])
                        np.savetxt(f_details, details_pool, fmt="%s", delimiter="\t", newline=" ")
                        f_details.write("\n")
                        f_details.close()
                if keys[pygame.K_DOWN]:
                    p_x = p_x + 1
                    if p_x > np.max(position_x_list):
                        p_x = np.max(position_x_list)
                    cur_x, cur_y = from_position_to_xy(p_x, p_y)
                    show_stimuli_beh(input_image_path=from_position_to_path(p_x, p_y), with_feedback=False)
                    if is_formal:
                        f_details = open(application_path + "/sub" + str(sub_no) + "_beh_detail" + ".txt", 'a')
                        details_pool = np.array([str(sub_no), str(ith_sess), str(ith_trial), trial_type,
                                                 str(cur_trial_ori), str(ori_x), str(ori_y), str(cur_x),
                                                 str(cur_y), str(ori_p_x), str(ori_p_y), str(p_x), str(p_y)])
                        np.savetxt(f_details, details_pool, fmt="%s", delimiter="\t", newline=" ")
                        f_details.write("\n")
                        f_details.close()
                if keys[pygame.K_RETURN]:
                    pygame.event.clear()
                    time_enter_pressed = pygame.time.get_ticks()
                    resp_duration = time_enter_pressed - time_stimuli_displayed
                    final_x, final_y = from_position_to_xy(p_x, p_y)
                    selection_error = round(np.sqrt(abs(abs(final_x*3) - 3)**2 + abs(abs(final_y*3) - 3)**2), 3)
                    # print(str(abs(abs(final_x*3) - 3)) + ' ' + str(abs(abs(final_y*3) - 3)) + ' ' + str(selection_error) + ' ' + str(calculate_fee(selection_error)))
                    sub_fee_pool.append(calculate_fee(selection_error))
                    sub_fee = round(np.sum(sub_fee_pool), 2)
                    if 0.2 >= selection_error >= 0:
                        response_outcome = 1
                        performance_pool.append(response_outcome)
                    else:
                        response_outcome = 0
                        performance_pool.append(response_outcome)


                    if is_formal:
                        f_record = open(application_path + "/sub" + str(sub_no) + "_beh_record" + ".txt", 'a')
                        output_pool = np.array([str(sub_no), str(ith_sess), trial_type, str(cur_trial_ori),
                                                str(ori_x), str(ori_y),
                                                str(final_x), str(final_y), str(resp_duration), str(selection_error),
                                                str(response_outcome), str(sub_fee)])
                        np.savetxt(f_record, output_pool, fmt="%s", delimiter="\t", newline=" ")
                        f_record.write("\n")
                        f_record.close()

                    if with_feedback:
                        show_stimuli_beh(input_image_path=from_position_to_path(p_x, p_y), with_feedback=True)
                        waiting_for_enter = True
                        while waiting_for_enter:
                            pygame.event.pump()
                            for event in pygame.event.get():
                                if event.type == pygame.KEYDOWN and event.key == pygame.K_RETURN:
                                    pygame.event.clear()
                                    waiting_for_enter = False
                                    on_greeble_morphing = False
                                    if is_ending:
                                        end_screen_while = True
                                        next_while = True
                                    else:
                                        end_screen_while = False
                                        next_while = True
                                if event.type == pygame.QUIT or (
                                        event.type == pygame.KEYDOWN and event.key == pygame.K_q):
                                    waiting_for_enter = False
                                    on_greeble_morphing = False
                                    next_while = False
                                    end_screen_while = True
                                    pygame.quit()
                    else:
                        on_greeble_morphing = False
                        if ith_trial == np.max(list(range(0, num_trial))):
                            if is_ending:
                                end_screen_while = True
                                next_while = True
                            else:
                                end_screen_while = False
                                next_while = True

                time.sleep(time_sleep)

        return performance_pool, next_while, end_screen_while


    # game start
    in_game = True
    baseline_greeble_while = False
    practice_while = False
    formal_inst_while = False
    conti_training_while = False
    test_session_inst_while = False
    test_session_while = False
    end_screen_while = False

    pygame.mouse.set_visible(0)
    while in_game:
        page1_inst_while = True
        while page1_inst_while:
            show_text("按回车键开始训练")
            pygame.event.pump()
            for event in pygame.event.get():
                if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_q):
                    page1_inst_while = False
                    in_game = False
                    pygame.event.clear()
                if event.type == pygame.KEYDOWN and event.key == pygame.K_RETURN:
                    pygame.event.clear()
                    page1_inst_while = False
                    baseline_greeble_while = True


        while baseline_greeble_while:
            pygame.event.pump()
            show_baseline_greeble()
            for event in pygame.event.get():
                if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_q):
                    baseline_greeble_while = False
                    in_game = False
                    pygame.event.clear()
                if event.type == pygame.KEYDOWN and event.key == pygame.K_RETURN:
                    pygame.event.clear()
                    image_path = stimuli_path_pool_o60[random.randrange(0, len(stimuli_path_pool_o60) - 1)]
                    show_stimuli_inst(file_name=image_path)
                    ori_x = float(re.search('x_axis-(.*)-y_axis', image_path).group(1))
                    ori_y = float(re.search('y_axis-(.*).tif', image_path).group(1))
                    p_x, p_y = from_xy_to_position(ori_x, ori_y)
                    cur_p_x = p_x
                    cur_p_y = p_y
                    greeble_morphing_while = True
                    while greeble_morphing_while:
                        pygame.event.pump()
                        for event in pygame.event.get():
                            if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_q):
                                greeble_morphing_while = False
                                baseline_greeble_while = False
                                in_game = False
                        keys = pygame.key.get_pressed()
                        if keys[pygame.K_LEFT]:
                            p_y = p_y - 1
                            if p_y < 0:
                                p_y = 0
                            show_stimuli_inst(file_name=from_position_to_path(p_x, p_y))
                        if keys[pygame.K_RIGHT]:
                            p_y = p_y + 1
                            if p_y > np.max(position_y_list):
                                p_y = np.max(position_y_list)
                            show_stimuli_inst(file_name=from_position_to_path(p_x, p_y))
                        if keys[pygame.K_UP]:
                            p_x = p_x - 1
                            if p_x < 0:
                                p_x = 0
                            show_stimuli_inst(file_name=from_position_to_path(p_x, p_y))
                        if keys[pygame.K_DOWN]:
                            p_x = p_x + 1
                            if p_x > np.max(position_x_list):
                                p_x = np.max(position_x_list)
                            show_stimuli_inst(file_name=from_position_to_path(p_x, p_y))
                        if cur_p_x != p_x or cur_p_y != p_y:
                            if keys[pygame.K_RETURN]:
                                pygame.event.clear()
                                greeble_morphing_while = False
                                baseline_greeble_while = False
                                practice_while = True
                        time.sleep(time_sleep)


        while practice_while:
            pygame.event.pump()
            show_text("练习 按回车键开始")
            for event in pygame.event.get():
                if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_q):
                    practice_while = False
                    in_game = False
                if event.type == pygame.KEYDOWN and event.key == pygame.K_RETURN:
                    # pygame.event.clear()
                    practice_while = False
                    useless, formal_inst_while, end_screen_while = trial_maker(is_formal=False, with_feedback=True, is_ending=False)

        while formal_inst_while:
            pygame.event.pump()
            show_text("开始正式训练 按回车键开始")
            for event in pygame.event.get():
                if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_q):
                    formal_inst_while = False
                    in_game = False
                if event.type == pygame.KEYDOWN and event.key == pygame.K_RETURN:
                    pygame.event.clear()
                    formal_inst_while = False
                    conti_training_while = True

        while conti_training_while:
            # pygame.event.pump()
            num_sess = 8 #8
            for ith_sess in list(range(1, num_sess)):
                show_text("第 " + str(ith_sess) + "组训练, 按回车键开始")
                in_session = True
                while in_session:
                    pygame.event.pump()
                    for event in pygame.event.get():
                        if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_q):
                            in_session = False
                            conti_training_while = False
                            end_screen_while = True
                        if event.type == pygame.KEYDOWN and event.key == pygame.K_RETURN:
                            pygame.event.clear()
                            in_session = False
                            performance_pool, next_while, end_screen_while = trial_maker(is_formal=True, with_feedback=True, is_ending=False)
                            if ith_sess == num_sess-1:
                                ith_sess = num_sess
                                conti_training_while = False
                                test_session_inst_while = True

        while test_session_inst_while:
            pygame.event.pump()
            show_text("实验1-测试 按回车键开始 ")
            for event in pygame.event.get():
                if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_q):
                    test_session_inst_while = False
                    in_game = False
                if event.type == pygame.KEYDOWN and event.key == pygame.K_RETURN:
                    pygame.event.clear()
                    test_session_inst_while = False
                    test_session_while = True

        while test_session_while:
            performance_pool, next_while, end_screen_while = trial_maker(is_formal=True, with_feedback=False, is_ending=True)
            test_session_while = False
            end_screen_while = True

        while end_screen_while:
            pygame.event.pump()
            show_text("完成, 按回车键关闭窗口")
            for event in pygame.event.get():
                if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_RETURN):
                    end_screen_while = False
                    in_game = False
    pygame.quit()
