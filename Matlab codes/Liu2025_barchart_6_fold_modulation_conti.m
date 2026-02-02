

%% predicted
clear;
mypath = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble';
sub_pool = [1:28, 30, 32, 33, 34, 35];

mask = MRIread('/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/mask/mask_wholebrain.nii'); %mask_nowm_withsubc mask_wholebrain
mask = mask.vol;

cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_ERC_fun_sinusoid.nii');%
cur_erc_ima = cur_struct.vol;
mask_index = find(cur_erc_ima==1);


export_table = NaN(length(sub_pool)*4*12, 4);
counter = 1;
for sub_ith = 1:length(sub_pool)
    cur_sub = sub_pool(sub_ith);
    for sess = 2:2:8
        % access raw table
        mypath_time_record =   [mypath, '/sub', num2str(cur_sub), '_mri_record_subj_vector_mean_testing_para6_1_35.txt'];
        timeFile = fopen(mypath_time_record,'rt');
        table_time = textscan(timeFile,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s');
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

        cur_struct = MRIread([mypath, '/liujia_formal_sub', num2str(cur_sub),'/periodic_2501_testing_subj_vector_mean_6_fieldmap_s', num2str(sess), '.feat/stats/standard_pe1.nii.gz']);
        old_ima = cur_struct.vol;
        
        % %
        % cur_index = find(mask~=0);
        % cur_mean = mean(old_ima(cur_index));
        % cur_std = std(old_ima(cur_index));
        % old_ima(cur_index) = (old_ima(cur_index))/cur_std;
        % old_ima = smooth3(old_ima,"gaussian",7);


        beta_list = old_ima(mask_index);
        beta_list(find(beta_list==0))=[];
        
        cos_value_continuous= table_mat(:, 16); 
        
        temp_matrix = NaN(length(beta_list),36);
        for ith_beta = 1:length(beta_list)
            temp_matrix(ith_beta, :) = beta_list(ith_beta)*cos_value_continuous;
        end
        
        pred_list = mean(temp_matrix, 1)';
        
        angle_matrix = table_mat(:,17);
        info_matrix = [pred_list, angle_matrix];
        
        angle_list = unique(angle_matrix);
        
        for ith_angle = 1:length(angle_list)
            export_table(counter, 1) = cur_sub;
            export_table(counter, 2) = sess;
            export_table(counter, 3) = angle_list(ith_angle);
            
            signal_list = info_matrix(find(info_matrix(:,2)==angle_list(ith_angle)), 1);
            
            export_table(counter, 4) = mean(signal_list);
            counter = counter + 1;
            ['sub', num2str(cur_sub), '-sess', num2str(sess), '-angle', num2str(angle_list(ith_angle))]
        end
    end
end

export_table2 = NaN(length(sub_pool), 12);
angle_pool = 0:30:330;
for sub_ith = 1:length(sub_pool)
    sub = sub_pool(sub_ith);
    for ith_angle = 1:length(angle_pool)
        export_table2(sub_ith, ith_angle) = mean(export_table(find(export_table(:,1)==sub & export_table(:,3)==angle_pool(ith_angle)), 4));
    end
end

export_table2(isnan(export_table2(:,1)), :) = [];

% export_table2 = [export_table2(:,12), export_table2(:, 1:11)];
fileID = fopen(['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/txt_barchart_6_fold_effect_2025.txt'],'w');
for ith = 1:length(export_table2(:,1))
    fprintf(fileID,'%1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\n',export_table2(ith,:));
end
fclose(fileID);








