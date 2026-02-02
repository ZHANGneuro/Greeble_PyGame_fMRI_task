



%%  this is for all-session version for osci
clear;
mypath = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble';

for sub = 1:35
    % access raw table
    mypath_time_record =   [mypath, '/sub', num2str(sub), '_mri_record_fft.txt'];
    timeFile = fopen(mypath_time_record,'rt');
    table_time = textscan(timeFile,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s');
    fclose(timeFile);
    % reassign to new cell
    table_cell = cell(length(table_time{1}), length(table_time));
    for ith_col = 1:length(table_time)
        for ith_row = 1:length(table_time{1})
            table_cell{ith_row, ith_col} = table_time{ith_col}{ith_row};
        end
    end
    
    % reassign to new mat
    table_mat = NaN(length(table_cell(:,1)), length(table_cell(1,:)));
    for ith_col = 1:length(table_cell(1,:))
        for ith_row = 1:length(table_cell(:,1))
            if ismember(ith_col, 9:12)
                if strcmp(table_cell{ith_row, ith_col}, 'NA')
                    table_mat(ith_row, ith_col) = NaN;
                else
                    table_mat(ith_row, ith_col) = (str2num(table_cell{ith_row, ith_col}) - str2num(table_cell{1, 9}))*0.001;
                end
            elseif strcmp(table_cell{ith_row, ith_col}, 'NA')
                table_mat(ith_row, ith_col) = NaN;
            else
                table_mat(ith_row, ith_col) = str2num(table_cell{ith_row, ith_col});
            end
        end
    end

    % re-organize the timing
    for ith_sess = 2:8
        index_sess = find(table_mat(:,2) == ith_sess);
        index_last_sess = find(table_mat(:,2) == ith_sess-1);
        last_sess_last_value = table_mat(index_last_sess(end), 12);
        col10_new = [];
        for ith_row = 1:length(index_sess)
            if ith_row == 1
                col10_new = [col10_new; last_sess_last_value+0.021];
            else
                cur_row = index_sess(ith_row);
                col10_new = [col10_new; col10_new(end) + (table_mat(cur_row, 10) - table_mat(cur_row-1, 10))];
            end
        end
        col11_new = col10_new + (table_mat(index_sess, 11) - table_mat(index_sess, 10));
        col12_new = col10_new + (table_mat(index_sess, 12) - table_mat(index_sess, 10));
        table_mat(index_sess, 10) = col10_new;
        table_mat(index_sess, 11) = col11_new;
        table_mat(index_sess, 12) = col12_new;
    end
    table_mat(:,9) = 0;
    
    %% create segmment
    % empty trial
    target_ith = find(isnan(table_mat(:,3)));
    target_session =  table_mat(target_ith, :);
    target_onset = target_session(:, 10); % 10- fix onset
    target_end = target_session(:, 12);
    dura = target_end - target_onset;
    export_txt = [target_onset dura ones(length(dura),1)];
    fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_all_sessions_empty_trial.txt'],'w');
    for n = 1:length(export_txt(:,1))
        fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
    end
    fclose(fid);
    
    % fixation
    target_onset = table_mat(:, 10); % 10- fix onset
    dura = zeros(length(target_onset), 1)+2;
    export_txt = [target_onset dura ones(length(dura),1)];
    fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_all_sessions_fixation.txt'],'w');
    for n = 1:length(export_txt(:,1))
        fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
    end
    fclose(fid);
    
    %  10
    angle_pool = 0:10:350;
    for ith_angle = 1:length(angle_pool)
        cur_angle = angle_pool(ith_angle);
        target_index = find(table_mat(:,14)==cur_angle);
        target_onset = table_mat(target_index, 11); % 11-stimuli onset
        target_end = table_mat(target_index, 12);
        dura = target_end - target_onset;
        if length(export_txt)==0
            sub
            cur_angle
        end
        export_txt = [target_onset dura zeros(length(dura), 1)+1];
        fid = fopen([mypath,  '/MRI_event_timing_file2022/all_sessions_sub',num2str(sub), '_bin10_angle', num2str(cur_angle),'_subj.txt'],'w');
        for n = 1:length(export_txt(:,1))
            fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        end
        fclose(fid);
    end
    
    %  15
    angle_pool = 0:15:345;
    for ith_angle = 1:length(angle_pool)
        cur_angle = angle_pool(ith_angle);
        target_index = find(table_mat(:,15)==cur_angle);
        target_onset = table_mat(target_index, 11); % 11-stimuli onset
        target_end = table_mat(target_index, 12);
        dura = target_end - target_onset;
        if length(export_txt)==0
            sub
            cur_angle
        end
        export_txt = [target_onset dura zeros(length(dura), 1)+1];
        fid = fopen([mypath,  '/MRI_event_timing_file2022/all_sessions_sub',num2str(sub), '_bin15_angle', num2str(cur_angle),'_subj.txt'],'w');
        for n = 1:length(export_txt(:,1))
            fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        end
        fclose(fid);
    end

    %  20
    angle_pool = 0:20:340;
    for ith_angle = 1:length(angle_pool)
        cur_angle = angle_pool(ith_angle);
        target_index = find(table_mat(:,16)==cur_angle);
        target_onset = table_mat(target_index, 11); % 11-stimuli onset
        target_end = table_mat(target_index, 12);
        dura = target_end - target_onset;
        if length(export_txt)==0
            sub
            cur_angle
        end
        export_txt = [target_onset dura zeros(length(dura), 1)+1];
        fid = fopen([mypath,  '/MRI_event_timing_file2022/all_sessions_sub',num2str(sub), '_bin20_angle', num2str(cur_angle),'_subj.txt'],'w');
        for n = 1:length(export_txt(:,1))
            fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        end
        fclose(fid);
    end
    
%     matrix_the = zeros(length(0:15:345), max(len_list));
%     angle_pool = 0:15:345;
%     for ith_angle = 1:length(angle_pool)
%         cur_angle = angle_pool(ith_angle);
%         target_index = find(table_mat(:,17)==cur_angle);
%         target_onset = table_mat(target_index, 11); % 11-stimuli onset
%         matrix_the(ith_angle, 1:length(target_onset)) = target_onset;
%     end
end



