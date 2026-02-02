


%% this is for periodic analysis (actual direction)
%  training part
clear;
mypath = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble';
output_key_word = '';
for sub = 1:35
    for sess = 1:2:8
        % access raw table
        mypath_time_record =   [mypath, '/sub', num2str(sub), '_mri_record_sinusoid_subj.txt'];
        timeFile = fopen(mypath_time_record,'rt');
        table_time = textscan(timeFile,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s');
        fclose(timeFile);
        % reassign to new cell
        table_cell = cell(length(table_time{1}), length(table_time));
        for ith_col = 1:length(table_time)
            for ith_row = 1:length(table_time{1})
                table_cell{ith_row, ith_col} = table_time{ith_col}{ith_row};
            end
        end
        % access session
        sess_ith = find(cellfun(@(x) strcmp(x, num2str(sess)), table_cell(:,2)));
        table_cell = table_cell(sess_ith, :);
        % reassign to new mat
        table_mat = NaN(length(table_cell(:,1)), length(table_cell(1,:)));
        for ith_col = 1:length(table_cell(1,:))
            for ith_row = 1:length(table_cell(:,1))
                if ~strcmp(table_cell{ith_row, ith_col}, 'NA')
                    if ismember(ith_col, 9:12)
                        table_mat(ith_row, ith_col) = (str2num(table_cell{ith_row, ith_col}) - str2num(table_cell{1, 9}))*0.001;
                    else
                        table_mat(ith_row, ith_col) = str2num(table_cell{ith_row, ith_col});
                    end
                else
                    table_mat(ith_row, ith_col) = NaN;
                end
            end
        end
        
        table_mat(find(isnan(table_mat(:, 18))), :) = [];
        
        
        % target_onset = table_mat(:, 11); %11-stimuli onset
        % target_end = table_mat(:, 12);
        % sin_value_continuous= table_mat(:, 18);
        % dura = target_end - target_onset;
        % export_txt = [target_onset, dura, sin_value_continuous];
        % fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_sin1_', output_key_word,'.txt'],'w');
        % for n = 1:length(export_txt(:,1))
        %     fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        % end
        % fclose(fid);
        % target_onset = table_mat(:, 11); %11-stimuli onset
        % target_end = table_mat(:, 12);
        % sin_value_continuous= table_mat(:, 19);
        % dura = target_end - target_onset;
        % export_txt = [target_onset, dura, sin_value_continuous];
        % fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_cos1_', output_key_word,'.txt'],'w');
        % for n = 1:length(export_txt(:,1))
        %     fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        % end
        % fclose(fid);
        
        
        
        % target_onset = table_mat(:, 11); %11-stimuli onset
        % target_end = table_mat(:, 12);
        % sin_value_continuous= table_mat(:, 20);
        % dura = target_end - target_onset;
        % export_txt = [target_onset, dura, sin_value_continuous];
        % fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_sin2_', output_key_word,'.txt'],'w');
        % for n = 1:length(export_txt(:,1))
        %     fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        % end
        % fclose(fid);
        % target_onset = table_mat(:, 11); %11-stimuli onset
        % target_end = table_mat(:, 12);
        % sin_value_continuous= table_mat(:, 21);
        % dura = target_end - target_onset;
        % export_txt = [target_onset, dura, sin_value_continuous];
        % fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_cos2_', output_key_word,'.txt'],'w');
        % for n = 1:length(export_txt(:,1))
        %     fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        % end
        % fclose(fid);
        
        
        target_onset = table_mat(:, 11); %11-stimuli onset
        target_end = table_mat(:, 12);
        sin_value_continuous= table_mat(:, 22);
        dura = target_end - target_onset;
        export_txt = [target_onset, dura, sin_value_continuous];
        fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_sin3_', output_key_word,'.txt'],'w');
        for n = 1:length(export_txt(:,1))
            fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        end
        fclose(fid);
        target_onset = table_mat(:, 11); %11-stimuli onset
        target_end = table_mat(:, 12);
        sin_value_continuous= table_mat(:, 23);
        dura = target_end - target_onset;
        export_txt = [target_onset, dura, sin_value_continuous];
        fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_cos3_', output_key_word,'.txt'],'w');
        for n = 1:length(export_txt(:,1))
            fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        end
        fclose(fid);
        
        
        
        % target_onset = table_mat(:, 11); %11-stimuli onset
        % target_end = table_mat(:, 12);
        % sin_value_continuous= table_mat(:, 24);
        % dura = target_end - target_onset;
        % export_txt = [target_onset, dura, sin_value_continuous];
        % fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_sin4_', output_key_word,'.txt'],'w');
        % for n = 1:length(export_txt(:,1))
        %     fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        % end
        % fclose(fid);
        % target_onset = table_mat(:, 11); %11-stimuli onset
        % target_end = table_mat(:, 12);
        % sin_value_continuous= table_mat(:, 25);
        % dura = target_end - target_onset;
        % export_txt = [target_onset, dura, sin_value_continuous];
        % fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_cos4_', output_key_word,'.txt'],'w');
        % for n = 1:length(export_txt(:,1))
        %     fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        % end
        % fclose(fid);
        % 
        % 
        % target_onset = table_mat(:, 11); %11-stimuli onset
        % target_end = table_mat(:, 12);
        % sin_value_continuous= table_mat(:, 26);
        % dura = target_end - target_onset;
        % export_txt = [target_onset, dura, sin_value_continuous];
        % fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_sin5_', output_key_word,'.txt'],'w');
        % for n = 1:length(export_txt(:,1))
        %     fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        % end
        % fclose(fid);
        % target_onset = table_mat(:, 11); %11-stimuli onset
        % target_end = table_mat(:, 12);
        % sin_value_continuous= table_mat(:, 27);
        % dura = target_end - target_onset;
        % export_txt = [target_onset, dura, sin_value_continuous];
        % fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_cos5_', output_key_word,'.txt'],'w');
        % for n = 1:length(export_txt(:,1))
        %     fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        % end
        % fclose(fid);

        
        % target_onset = table_mat(:, 11); %11-stimuli onset
        % target_end = table_mat(:, 12);
        % sin_value_continuous= table_mat(:, 28);
        % dura = target_end - target_onset;
        % export_txt = [target_onset, dura, sin_value_continuous];
        % fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_sin6_', output_key_word,'.txt'],'w');
        % for n = 1:length(export_txt(:,1))
        %     fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        % end
        % fclose(fid);
        % 
        % target_onset = table_mat(:, 11); %11-stimuli onset
        % target_end = table_mat(:, 12);
        % sin_value_continuous= table_mat(:, 29);
        % dura = target_end - target_onset;
        % export_txt = [target_onset, dura, sin_value_continuous];
        % fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_cos6_', output_key_word,'.txt'],'w');
        % for n = 1:length(export_txt(:,1))
        %     fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        % end
        % fclose(fid);
        
        
        % target_onset = table_mat(:, 11); %11-stimuli onset
        % target_end = table_mat(:, 12);
        % sin_value_continuous= table_mat(:, 30);
        % dura = target_end - target_onset;
        % export_txt = [target_onset, dura, sin_value_continuous];
        % fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_sin7_', output_key_word,'.txt'],'w');
        % for n = 1:length(export_txt(:,1))
        %     fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        % end
        % fclose(fid);
        % 
        % target_onset = table_mat(:, 11); %11-stimuli onset
        % target_end = table_mat(:, 12);
        % sin_value_continuous= table_mat(:, 31);
        % dura = target_end - target_onset;
        % export_txt = [target_onset, dura, sin_value_continuous];
        % fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_cos7_', output_key_word,'.txt'],'w');
        % for n = 1:length(export_txt(:,1))
        %     fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        % end
        % fclose(fid);
        
        
        % target_onset = table_mat(:, 11); 
        % target_end = table_mat(:, 12);
        % sin_value_continuous= table_mat(:, 32);
        % dura = target_end - target_onset;
        % export_txt = [target_onset, dura, sin_value_continuous];
        % fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_sin8_', output_key_word,'.txt'],'w');
        % for n = 1:length(export_txt(:,1))
        %     fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        % end
        % fclose(fid);
        % target_onset = table_mat(:, 11);
        % target_end = table_mat(:, 12);
        % sin_value_continuous= table_mat(:, 33);
        % dura = target_end - target_onset;
        % export_txt = [target_onset, dura, sin_value_continuous];
        % fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_cos8_', output_key_word,'.txt'],'w');
        % for n = 1:length(export_txt(:,1))
        %     fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        % end
        % fclose(fid);
        % 
        % target_onset = table_mat(:, 11); 
        % target_end = table_mat(:, 12);
        % sin_value_continuous= table_mat(:, 34);
        % dura = target_end - target_onset;
        % export_txt = [target_onset, dura, sin_value_continuous];
        % fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_sin9_', output_key_word,'.txt'],'w');
        % for n = 1:length(export_txt(:,1))
        %     fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        % end
        % fclose(fid);
        % target_onset = table_mat(:, 11);
        % target_end = table_mat(:, 12);
        % sin_value_continuous= table_mat(:, 35);
        % dura = target_end - target_onset;
        % export_txt = [target_onset, dura, sin_value_continuous];
        % fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_obj_cos9_', output_key_word,'.txt'],'w');
        % for n = 1:length(export_txt(:,1))
        %     fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        % end
        % fclose(fid);
    end
end



%%  this is for timing files
clear;
mypath = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/';
for sub = 1:35
    for sess = 1:8

       mypath_time_record =   [mypath, '/sub', num2str(sub), '_mri_record_sinusoid_subj.txt'];
        timeFile = fopen(mypath_time_record,'rt');
        table_time = textscan(timeFile,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s');
        fclose(timeFile);
        % reassign to new cell
        table_cell = cell(length(table_time{1}), length(table_time));
        for ith_col = 1:length(table_time)
            for ith_row = 1:length(table_time{1})
                table_cell{ith_row, ith_col} = table_time{ith_col}{ith_row};
            end
        end
        % access session
        sess_ith = find(cellfun(@(x) strcmp(x, num2str(sess)), table_cell(:,2)));
        table_cell = table_cell(sess_ith, :);
        % reassign to new mat
        table_mat = NaN(length(table_cell(:,1)), length(table_cell(1,:)));
        for ith_col = 1:length(table_cell(1,:))
            for ith_row = 1:length(table_cell(:,1))
                if ~strcmp(table_cell{ith_row, ith_col}, 'NA')
                    if ismember(ith_col, 9:12)
                        table_mat(ith_row, ith_col) = (str2num(table_cell{ith_row, ith_col}) - str2num(table_cell{1, 9}))*0.001;
                    else
                        table_mat(ith_row, ith_col) = str2num(table_cell{ith_row, ith_col});
                    end
                else
                    table_mat(ith_row, ith_col) = NaN;
                end
            end
        end

        %% 
        % empty trial
        target_ith = find(isnan(table_mat(:,3)));
        target_session =  table_mat(target_ith, :);
        target_onset = target_session(:, 10); % 10- fix onset
        target_end = target_session(:, 12);
        dura = target_end - target_onset;
        export_txt = [target_onset dura ones(length(dura),1)];
        fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_empty_trial.txt'],'w');
        for n = 1:length(export_txt(:,1))
            fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        end
        fclose(fid);


        % fixation
        target_onset = table_mat(:, 10); % 10- fix onset
        dura = zeros(length(target_onset), 1)+2;
        export_txt = [target_onset dura ones(length(dura),1)];
        fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_fixation.txt'],'w');
        for n = 1:length(export_txt(:,1))
            fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        end
        fclose(fid);
    end
end



