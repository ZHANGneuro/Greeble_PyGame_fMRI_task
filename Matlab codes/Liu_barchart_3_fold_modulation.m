

%% predicted
clear;
mypath = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble';
sub_pool = {'01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20'};
% sub_pool = {'11', '12', '13', '14', '15', '16', '17', '18', '19', '20'};

cur_struct = MRIread([mypath,'/mask/mask_HPC_aal.nii']);
cur_erc_ima = cur_struct.vol;
mask_index = find(cur_erc_ima>0);

% cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_ERC_harddraw_2mm.nii');
% cur_erc_ima = cur_struct.vol;
% mask_index = find(cur_erc_ima==1);

% cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_ERC_harddraw_2mm_r.nii');
% cur_erc_ima = cur_struct.vol;
% mask_index = find(cur_erc_ima==1);

% sub_pool_num = 11:20;
sub_pool_num = 1:20;

export_table = NaN(10*4*12, 4);
counter = 1;
for sub = sub_pool_num
    cur_sub = sub_pool{sub};
    for sess = 2:2:8
        % access raw table
        % mypath_time_record =   [mypath, '/sub', num2str(sub), '_mri_record_no_calibration_sinusoid_testing_hpcOused.txt'];
        % timeFile = fopen(mypath_time_record,'rt');
        % table_time = textscan(timeFile,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s');
        % fclose(timeFile);

        mypath_time_record =   [mypath, '/sub', num2str(sub), '_mri_record_no_calibration_sinusoid_testing_for_anathpc_aal_fixtrial.txt'];
        timeFile = fopen(mypath_time_record,'rt');
        table_time = textscan(timeFile,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s');
        fclose(timeFile);
        
        % %keyword
        % roi_str_cell = extractBetween(mypath_time_record, 'testing_', 'Oused');
        % roi_str = roi_str_cell{1};

        %keyword
        % roi_str_cell = extractBetween(mypath_time_record, 'testing_for_', '_3fold');
        % roi_str = roi_str_cell{1};

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

        cur_struct = MRIread([mypath, '/liujia_formal_sub', cur_sub,'/periodic_2403_testing_3_fieldmap_anathpc_aal_fixtrial_s', num2str(sess), '.feat/stats/standard_pe1.nii.gz']);
        cur_beta_brain = cur_struct.vol;
        
        beta_list = cur_beta_brain(mask_index);
        beta_list(find(beta_list==0))=[];
        
        % cos_value_continuous= table_mat(:, 18); % 21 for 6, 18 for 3

        cos_value_continuous= table_mat(:, 16); % 21 for 6, 18 for 3
        
        temp_matrix = NaN(length(beta_list),36);
        for ith_beta = 1:length(beta_list)
            temp_matrix(ith_beta, :) = beta_list(ith_beta)*cos_value_continuous;
        end
        
        pred_list = mean(temp_matrix, 1)';
        
        angle_matrix = table_mat(:,3);
        info_matrix = [pred_list, angle_matrix];
        
        angle_list = unique(angle_matrix);
        
        for ith_angle = 1:length(angle_list)
            export_table(counter, 1) = sub;
            export_table(counter, 2) = sess;
            export_table(counter, 3) = angle_list(ith_angle);
            
            signal_list = info_matrix(find(info_matrix(:,2)==angle_list(ith_angle)), 1);
            
            export_table(counter, 4) = mean(signal_list);
            counter = counter + 1;
            ['sub', num2str(sub), '-sess', num2str(sess), '-angle', num2str(angle_list(ith_angle))]
        end
    end
end

export_table2 = NaN(10, 12);
angle_pool = 0:30:330;
for sub = sub_pool_num
    for ith_angle = 1:length(angle_pool)
        export_table2(sub, ith_angle) = mean(export_table(find(export_table(:,1)==sub & export_table(:,3)==angle_pool(ith_angle)), 4));
    end
end

export_table2(isnan(export_table2(:,1)), :) = [];
% export_table2 = [export_table2(:,12), export_table2(:, 1:11)];

fileID = fopen([mypath, '/fig_MRI_fig_2/txt_barchart_3_fold_effect_anatHPC_aal_g12_0.txt'],'w');
for ith = 1:length(export_table2(:,1))
    fprintf(fileID,'%1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\n',export_table2(ith,:));
end
fclose(fileID);










