
import pygame
import time
import re
import numpy as np


##############################
# training
##############################
def practice(screen_width, screen_height, window, application_path, stimuli_width, stimuli_height,
             give_a_fixed_time_interval, from_xy_to_position, position_x_list, position_y_list,
             from_position_to_path, making_a_session, time_sleep):
    # create pygame windowshow_stimuli_beh
    pygame.init()
    screen = pygame.display.set_mode((screen_width, screen_height), pygame.FULLSCREEN)
    # screen = pygame.display.set_mode((screen_width, screen_height))
    screen.fill(pygame.Color("black"))
    pygame.display.update()
    pygame.display.set_caption('Grid cell task')
    window.wm_state('iconic')
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
        text_l1_rect = text_l1.get_rect(center=(screen_width / 2, screen_height / 2 - 8 * screen_height / 20))
        screen.blit(text_l1, text_l1_rect)
        text_l2 = font.render("请记住 Loogit 和 Vacso 的长度", True, pygame.Color("white"))
        text_l2_rect = text_l2.get_rect(center=(screen_width / 2, screen_height / 2 - 7 * screen_height / 20))
        screen.blit(text_l2, text_l2_rect)
        text_l3 = font.render("按任意键继续", True, pygame.Color("white"))
        text_l3_rect = text_l3.get_rect(center=(screen_width / 2, screen_height / 2 - 6 * screen_height / 20))
        screen.blit(text_l3, text_l3_rect)
        text_l4 = font.render("Loogit 长度 = 1", True, pygame.Color("white"))
        text_l4_rect = text_l4.get_rect(center=(screen_width / 2, screen_height / 2 + 6 * screen_height / 20))
        screen.blit(text_l4, text_l4_rect)
        text_l5 = font.render("Vacso 长度 = 1", True, pygame.Color("white"))
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
            if cur_loogit_len_float < 1:
                text_l1 = font.render("Loogit: 比目标短了" + str(round(1-cur_loogit_len_float, 2)), True, pygame.Color("white"))
            if cur_loogit_len_float == 1:
                text_l1 = font.render("Loogit: 很好!", True, pygame.Color("white"))
            if cur_vacso_len_float > 1:
                text_l2 = font.render("Vacso: 比目标长了" + str(round(cur_vacso_len_float-1, 2)), True, pygame.Color("white"))
            if cur_vacso_len_float < 1:
                text_l2 = font.render("Vacso: 比目标短了" + str(round(1-cur_vacso_len_float, 2)), True, pygame.Color("white"))
            if cur_vacso_len_float == 1:
                text_l2 = font.render("Vacso: 很好!", True, pygame.Color("white"))
            text_l1_rect = text_l1.get_rect(center=(screen_width / 2, screen_height / 2 + 6 * screen_height / 20))
            screen.blit(text_l1, text_l1_rect)
            text_l2_rect = text_l2.get_rect(center=(screen_width / 2, screen_height / 2 + 7 * screen_height / 20))
            screen.blit(text_l2, text_l2_rect)
            text_l3 = font.render("按任意键继续", True, pygame.Color("white"))
            text_l3_rect = text_l3.get_rect(center=(screen_width / 2, screen_height / 2 + 9 * screen_height / 20))
            screen.blit(text_l3, text_l3_rect)
        pygame.display.update()

    def trial_maker():
        shuffled_session_image_path_pool, shuffled_session_orientation_pool = making_a_session(task_type='training')
        num_trial = 10
        for ith_trial in list(range(0, num_trial)):
            show_fixation()  # show fix
            give_a_fixed_time_interval(duration=2000)
            cur_image_path = shuffled_session_image_path_pool[ith_trial]
            show_stimuli_beh(input_image_path=cur_image_path, with_feedback=False)
            time_stimuli_displayed = pygame.time.get_ticks()
            ori_x = float(re.search('x_axis-(.*)-y_axis', cur_image_path).group(1))
            ori_y = float(re.search('y_axis-(.*).tif', cur_image_path).group(1))
            p_x, p_y = from_xy_to_position(ori_x, ori_y)

            on_greeble_morphing = True
            while on_greeble_morphing:
                pygame.event.pump()
                show_stimuli_beh(input_image_path=from_position_to_path(p_x, p_y), with_feedback=False)
                remaining_time = 10000 - (pygame.time.get_ticks() - time_stimuli_displayed)
                pygame.draw.rect(screen, pygame.Color("white"), (
                    screen_width / 2 - 2 * stimuli_width / 10, screen_height / 2 - 7 * screen_height / 20,
                    (screen_width - 2 * (screen_width / 2 - 2 * stimuli_width / 10)) * remaining_time / 10000,
                    stimuli_height / 100), 2)
                pygame.display.update(pygame.Rect(0, 0, screen_width, screen_height / 2))

                for event in pygame.event.get():
                    if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_t):
                        on_greeble_morphing = False
                        end_screen_while = True
                        pygame.quit()

                    # keys = pygame.key.get_pressed()
                    if event.type == pygame.KEYDOWN and event.key == pygame.K_1:
                        p_y = p_y - 1
                        if p_y < 0:
                            p_y = 0
                    if event.type == pygame.KEYDOWN and event.key == pygame.K_2:
                        p_y = p_y + 1
                        if p_y > np.max(position_y_list):
                            p_y = np.max(position_y_list)
                    if event.type == pygame.KEYDOWN and event.key == pygame.K_3:
                        p_x = p_x - 1
                        if p_x < 0:
                            p_x = 0
                    if event.type == pygame.KEYDOWN and event.key == pygame.K_4:
                        p_x = p_x + 1
                        if p_x > np.max(position_x_list):
                            p_x = np.max(position_x_list)
                if remaining_time <= 0:
                    on_greeble_morphing = False
                    if ith_trial == np.max(list(range(0, num_trial))):
                        end_screen_while = True
                # time.sleep(time_sleep)
        return end_screen_while

    # game start
    in_game = True
    practice_while = False
    end_screen_while = False

    pygame.mouse.set_visible(0)
    while in_game:
        page1_inst_while = True
        while page1_inst_while:
            show_text("请用几分钟的时间做练习，按任意键开始")
            pygame.event.pump()
            for event in pygame.event.get():
                if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_q):
                    page1_inst_while = False
                    in_game = False
                    pygame.event.clear()
                if event.type == pygame.KEYDOWN:
                    pygame.event.clear()
                    page1_inst_while = False
                    practice_while = True

        while practice_while:
            pygame.event.pump()
            show_baseline_greeble()
            for event in pygame.event.get():
                if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_t):
                    practice_while = False
                    in_game = False
                if event.type == pygame.KEYDOWN:
                    pygame.event.clear()
                    practice_while = False
                    end_screen_while = trial_maker()

        while end_screen_while:
            pygame.event.pump()
            show_text("完成, 按任意键关闭窗口")
            for event in pygame.event.get():
                if event.type == pygame.QUIT or event.type == pygame.KEYDOWN:
                    end_screen_while = False
                    in_game = False
    pygame.quit()
