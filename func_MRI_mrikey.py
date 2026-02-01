
import pygame
import time
import re
import numpy as np

###############
# mri
###############
def mri_scanning(screen_width, screen_height, window, stimuli_width, stimuli_height, give_a_fixed_time_interval,
                 entry, application_path, time_sleep, making_a_session, from_xy_to_position, from_position_to_xy,
                 from_position_to_path, position_x_list, position_y_list, calculate_fee, sub_fee_pool):

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
        # # screenshot
        # rect = pygame.Rect(112, 84, 800, 600)
        # sub = screen.subsurface(rect)
        # pygame.image.save(sub, "/Users/bo/Desktop/cross_screen.png")

    def show_text(text_input):
        screen.fill(pygame.Color("black"))
        text_inst = font.render(text_input, True, pygame.Color("white"))
        text_inst_rect = text_inst.get_rect(center=(screen_width / 2, screen_height / 2))
        screen.blit(text_inst, text_inst_rect)
        pygame.display.update()

    def show_stimuli(input_image_path):
        screen.fill(pygame.Color("black"))
        cur_ima = pygame.image.load(input_image_path)
        cur_ima = pygame.transform.scale(cur_ima, (stimuli_width, stimuli_height))
        screen.blit(cur_ima, (screen_width / 2 - stimuli_width / 2, screen_height / 2 - stimuli_height / 2))
        pygame.display.update()

    def trial_maker():
        shuffled_session_image_path_pool, shuffled_session_orientation_pool = making_a_session(task_type='mri')
        num_trial = len(shuffled_session_image_path_pool)
        for ith_trial in list(range(0, num_trial)):
            show_fixation()
            time_fix_displayed = pygame.time.get_ticks()
            cur_image_path = shuffled_session_image_path_pool[ith_trial]
            if cur_image_path == 'empty':
                give_a_fixed_time_interval(duration=12000) #12000
                if ith_trial == max(list(range(0, num_trial))):
                    end_screen_while = True
                f_record = open(application_path + "/sub" + str(sub_no) + "_mri_record" + ".txt", 'a')
                cur_trial_ori = 'na'
                ori_x = 'na'
                ori_y = 'na'
                final_x = 'na'
                final_y = 'na'
                selection_error = 'na'
                time_stimuli_displayed = 'na'
                time_trialEnd = pygame.time.get_ticks()
                sub_fee = round(np.sum(sub_fee_pool), 2)
                output_pool = np.array([str(sub_no), str(ith_sess), str(cur_trial_ori),
                                        str(ori_x), str(ori_y), str(final_x), str(final_y),
                                        str(selection_error), str(time_keyS_pressed), str(time_fix_displayed),
                                        str(time_stimuli_displayed), str(time_trialEnd), str(sub_fee)])
                np.savetxt(f_record, output_pool, fmt="%s", delimiter="\t", newline=" ")
                f_record.write("\n")
                f_record.close()
            if cur_image_path != 'empty':
                give_a_fixed_time_interval(duration=2000) #2000
                show_stimuli(input_image_path=cur_image_path)
                time_stimuli_displayed = pygame.time.get_ticks()
                ori_x = float(re.search('x_axis-(.*)-y_axis', cur_image_path).group(1))
                ori_y = float(re.search('y_axis-(.*).tif', cur_image_path).group(1))
                cur_trial_ori = shuffled_session_orientation_pool[ith_trial]
                p_x, p_y = from_xy_to_position(ori_x, ori_y)
                ori_p_x = p_x
                ori_p_y = p_y
                on_greeble_morphing = True
                # photo_pass = True
                while on_greeble_morphing:
                    pygame.event.pump()
                    # if photo_pass:
                    #     # screenshot
                    # rect = pygame.Rect(112, 84, 800, 600)
                    # sub = screen.subsurface(rect)
                    # pygame.image.save(sub, "/Users/bo/Desktop/initial greeble.png")
                        # photo_pass = False

                    cur_x, cur_y = from_position_to_xy(p_x, p_y)
                    show_stimuli(input_image_path=from_position_to_path(p_x, p_y))
                    remaining_time = 10000 - (pygame.time.get_ticks() - time_stimuli_displayed)  # 10000
                    pygame.draw.rect(screen, pygame.Color("white"), (
                    screen_width / 2 - 2 * stimuli_width / 10, screen_height / 2 - 7 * screen_height / 20,
                    (screen_width - 2 * (screen_width / 2 - 2 * stimuli_width / 10)) * remaining_time / 10000,
                    stimuli_height / 100), 2)
                    pygame.display.update(pygame.Rect(0, 0, screen_width, screen_height / 2))

                    for event in pygame.event.get():
                        if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_t):
                            on_greeble_morphing = False
                            pygame.display.quit()
                            pygame.quit()

                        # keys = pygame.key.get_pressed()
                        if event.type == pygame.KEYDOWN and event.key == pygame.K_1:
                            p_y = p_y - 1
                            if p_y < 0:
                                p_y = 0
                            time_moved = pygame.time.get_ticks()
                            f_details = open(application_path + "/sub" + str(sub_no) + "_mri_detail" + ".txt", 'a')
                            details_pool = np.array([str(sub_no), str(ith_sess), str(ith_trial), str(cur_trial_ori),
                                                     str(ori_x), str(ori_y), str(cur_x), str(cur_y), str(ori_p_x),
                                                     str(ori_p_y), str(p_x), str(p_y), str(time_keyS_pressed),
                                                     str(time_stimuli_displayed), str(time_moved)])
                            np.savetxt(f_details, details_pool, fmt="%s", delimiter="\t", newline=" ")
                            f_details.write("\n")
                            f_details.close()
                        if event.type == pygame.KEYDOWN and event.key == pygame.K_2:
                            p_y = p_y + 1
                            if p_y > np.max(position_y_list):
                                p_y = np.max(position_y_list)
                            time_moved = pygame.time.get_ticks()
                            f_details = open(application_path + "/sub" + str(sub_no) + "_mri_detail" + ".txt", 'a')
                            details_pool = np.array([str(sub_no), str(ith_sess), str(ith_trial), str(cur_trial_ori),
                                                     str(ori_x), str(ori_y), str(cur_x), str(cur_y), str(ori_p_x),
                                                     str(ori_p_y), str(p_x), str(p_y), str(time_keyS_pressed),
                                                     str(time_stimuli_displayed), str(time_moved)])
                            np.savetxt(f_details, details_pool, fmt="%s", delimiter="\t", newline=" ")
                            f_details.write("\n")
                            f_details.close()
                        if event.type == pygame.KEYDOWN and event.key == pygame.K_3:
                            p_x = p_x - 1
                            if p_x < 0:
                                p_x = 0
                            time_moved = pygame.time.get_ticks()
                            f_details = open(application_path + "/sub" + str(sub_no) + "_mri_detail" + ".txt", 'a')
                            details_pool = np.array([str(sub_no), str(ith_sess), str(ith_trial), str(cur_trial_ori),
                                                     str(ori_x), str(ori_y), str(cur_x), str(cur_y), str(ori_p_x),
                                                     str(ori_p_y), str(p_x), str(p_y), str(time_keyS_pressed),
                                                     str(time_stimuli_displayed), str(time_moved)])
                            np.savetxt(f_details, details_pool, fmt="%s", delimiter="\t", newline=" ")
                            f_details.write("\n")
                            f_details.close()
                        if event.type == pygame.KEYDOWN and event.key == pygame.K_4:
                            p_x = p_x + 1
                            if p_x > np.max(position_x_list):
                                p_x = np.max(position_x_list)
                            time_moved = pygame.time.get_ticks()
                            f_details = open(application_path + "/sub" + str(sub_no) + "_mri_detail" + ".txt", 'a')
                            details_pool = np.array([str(sub_no), str(ith_sess), str(ith_trial), str(cur_trial_ori),
                                                     str(ori_x), str(ori_y), str(cur_x), str(cur_y), str(ori_p_x),
                                                     str(ori_p_y), str(p_x), str(p_y), str(time_keyS_pressed),
                                                     str(time_stimuli_displayed), str(time_moved)])
                            np.savetxt(f_details, details_pool, fmt="%s", delimiter="\t", newline=" ")
                            f_details.write("\n")
                            f_details.close()
                    if remaining_time <= 0:
                        # # screenshot
                        # rect = pygame.Rect(112, 84, 800, 600)
                        # sub = screen.subsurface(rect)
                        # pygame.image.save(sub, "/Users/bo/Desktop/final greeble.png")
                        time_trialEnd = pygame.time.get_ticks()
                        final_x, final_y = from_position_to_xy(p_x, p_y)
                        selection_error = round(np.sqrt(abs(abs(final_x*3) - 3)**2 + abs(abs(final_y*3) - 3)**2), 3)
                        sub_fee_pool.append(calculate_fee(selection_error))
                        sub_fee = round(np.sum(sub_fee_pool), 2)
                        f_record = open(application_path + "/sub" + str(sub_no) + "_mri_record" + ".txt", 'a')
                        output_pool = np.array([str(sub_no), str(ith_sess), str(cur_trial_ori),
                                                str(ori_x), str(ori_y), str(final_x), str(final_y),
                                                str(selection_error), str(time_keyS_pressed), str(time_fix_displayed),
                                                str(time_stimuli_displayed), str(time_trialEnd), str(sub_fee)])
                        np.savetxt(f_record, output_pool, fmt="%s", delimiter="\t", newline=" ")
                        f_record.write("\n")
                        f_record.close()
                        on_greeble_morphing = False
                        if ith_trial == max(list(range(0, num_trial))):
                            end_screen_while = True
                # time.sleep(time_sleep)
        return end_screen_while

    # game start
    in_game = True
    pygame.mouse.set_visible(0)
    while in_game:
        conti_training_while = True
        while conti_training_while:
            pygame.event.pump()
            num_sess = 9
            for ith_sess in list(range(1, num_sess)):  # 8
                show_text("将开始第 " + str(ith_sess) + "组实验，当前可休息，按键示意开始")
                in_session = True
                while in_session:
                    pygame.event.pump()
                    for event in pygame.event.get():
                        if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_t):
                            in_session = False
                            conti_training_while = False
                            in_game = False
                            end_screen_while = True
                            pygame.display.quit()
                            pygame.quit()
                        if event.type == pygame.KEYDOWN and event.key == pygame.K_s:
                            pygame.event.clear()
                            time_keyS_pressed = pygame.time.get_ticks()
                            end_screen_while = trial_maker()
                            in_session = False
                            if ith_sess == num_sess-1:
                                ith_sess = num_sess
                                conti_training_while = False

        while end_screen_while:
            pygame.event.pump()
            pygame.event.clear()
            show_text("实验结束, 请等待")
            for event in pygame.event.get():
                if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_t):
                    pygame.display.quit()
                    pygame.quit()


