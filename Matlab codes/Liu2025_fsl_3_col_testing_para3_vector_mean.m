


%% testing part pending
clear;
mypath = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble';

para=7;

for sub = 1:35
    for sess = 2:2:8
        % access raw table  
        mypath_time_record = [mypath, '/sub', num2str(sub), '_mri_record_subj_vector_mean_testing_para',num2str(para),'_1_35.txt'];  
        timeFile = fopen(mypath_time_record,'rt');
        table_time = textscan(timeFile,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s');
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
        
        table_mat(find(isnan(table_mat(:, 3))), :) = [];
        target_onset = table_mat(:, 11); % 11-stimuli onset
        target_end = table_mat(:, 12);
        
        cos_value_continuous= table_mat(:, 16);
        dura = target_end - target_onset;
        export_txt = [target_onset, dura, cos_value_continuous];
        fid = fopen([  mypath,  '/MRI_event_timing_file2022/sub',num2str(sub), '_s', num2str(sess), '_subj_vector_mean_test_',num2str(para),'.txt'],'w');
        for n = 1:length(export_txt(:,1))
            fprintf(fid,'%f\t  %f\t  %d\n',export_txt(n,:));
        end
        fclose(fid);
        
    end
end








