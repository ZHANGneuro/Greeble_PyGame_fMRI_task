


cur_file_path ='/Users/bo/Desktop/MRI_Scanning_sub18/bold_run1';
dicm2nii(cur_file_path, cur_file_path, 1);
X = dicominfo('/Users/bo/Desktop/temp_MRI/bold_run1/sms_bold_run1-00001.dcm');



%% T1
% sub_pool = {'01', '02', '03', '04', '05', '06', '07', '08', '09', '10'};
% sub_pool = {'11', '12', '13', '14', '15', '16', '17', '18', '19', '20'};
sub_pool = {'21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35'};
for ith_sub = 1:length(sub_pool)
    cur_sub = sub_pool{ith_sub};
    cur_file_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/Raw_MRI_backup/LJZB', cur_sub,'/T1_MPRAGE_SAG_ISO_MWW_0003'];
    cur_dir = dir(fullfile(cur_file_path, '/*.IMA'));
    cur_file_list =  strcat(cur_file_path, '/',{cur_dir.name}');
    output_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_raw_t1/sub', cur_sub, '_t1.nii.gz'];
    dicm2nii(cur_file_path, output_path, 1);
end

% %% T1 folder to image
% root_path = ['/Users/bo/Documents/data_liujia_lab/task_greeble_exp/pilot_beh_mri_results/MRI_raw_bold_4s_all_session/'];
% each_cluster_dir = dir(fullfile(root_path, 'sub*'));
% cluster_pool =  strcat(root_path, {each_cluster_dir.name}');
% for ith_sub = 1:10
%     for ith_sess = 1:8
%         cur_file_list = cluster_pool(find(contains(cluster_pool, ['sub', num2str(ith_sub)]) & contains(cluster_pool, ['sess', num2str(ith_sess)])  ));
%         for ith_file = 1:length(cur_file_list)
%             cur_file_path = cur_file_list{ith_file};
%             get_tr = strsplit(cur_file_path, 'TR');
%             ith_tr = get_tr{2};
%             source_file = [cur_file_path, '/sms_bold_run', num2str(ith_sess),'.nii.gz'];
%             des_file = [root_path, '/bold_sub', num2str(ith_sub), '_s', num2str(ith_sess), '_tr', ith_tr, '.nii.gz'];
%             copyfile(source_file, des_file);
%         end
%     end
% end



%% bold dcm to nii
root_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_raw_bold_4d/'];
% sub_pool = {'01', '02', '03', '04', '05', '06', '07', '08', '09', '10'};
% sub_pool = {'11', '12', '13', '14', '15', '16', '17', '18', '19', '20'};
sub_pool = {'21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35'};
for ith_sub = 1:length(sub_pool)
    for ith_sess = 1:8
        cur_sub = sub_pool{ith_sub};
        cur_file_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/Raw_MRI_backup/LJZB', cur_sub,'/SMS_BOLD_RUN', num2str(ith_sess)];
        cur_dir = dir(fullfile(cur_file_path, '/*.IMA'));
        cur_file_list =  strcat(cur_file_path, '/',{cur_dir.name}');
        output_path = [root_path, 'sub', cur_sub, '_s', num2str(ith_sess)];
        dicm2nii(cur_file_list, output_path, 1);
    end
end


%% bold folder to image
root_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_raw_bold_4d/'];
% sub_pool = {'11', '12', '13', '14', '15', '16', '17', '18', '19', '20'};
sub_pool = {'21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35'};
for ith_sub = 1:length(sub_pool)
    for ith_sess = 1:8
        cur_sub = sub_pool{ith_sub};
        cur_file_path = [root_path, 'sub', cur_sub,'_s', num2str(ith_sess), '/sms_bold_run', num2str(ith_sess), '.nii.gz'];
        des_file = [root_path, 'sub', cur_sub, '_s', num2str(ith_sess), '.nii.gz'];
        copyfile(cur_file_path, des_file);
    end
end




% root_path = ['/Users/bo/Documents/data_liujia_lab/task_greeble_exp/pilot_beh_mri_results/MRI_raw_bold_4s_all_session_spm/'];
% each_cluster_dir = dir(fullfile(root_path, 'bold*'));
% cluster_pool =  strcat(root_path, {each_cluster_dir.name}');
% for ith_file = 1:length(cluster_pool)
%     
%     cur_file_path = cluster_pool{ith_file};
%     get_file_first_part = strsplit(cur_file_path, '_tr');
%     file_first_part = get_file_first_part{1};
%     
%     get_tr = strsplit(get_file_first_part{2}, '.');
%     value_tr = get_tr{1};
%     
%     if length(value_tr)==1
%         export_tr = ['00', num2str(value_tr)];
%         des_path = [file_first_part, '_tr', export_tr, '.nii'];
%         movefile(cur_file_path, des_path);
%     end
%     if length(value_tr)==2
%         export_tr = ['0', num2str(value_tr)];
%         des_path = [file_first_part, '_tr', export_tr, '.nii'];
%         movefile(cur_file_path, des_path);
%     end
% end


%%
% root_path = ['/Users/bo/Documents/data_liujia_lab/task_greeble_exp/pilot_beh_mri_results/'];
% each_cluster_dir = dir(fullfile(root_path, 'LJZ*'));
% cluster_pool =  strcat(root_path, {each_cluster_dir.name}');
% for ith_cluster = 1:length(cluster_pool)
%     curr_dir = cluster_pool{ith_cluster};
%     sub_dir = dir(fullfile(curr_dir, '*sms_bold_run*'));
%     sub_pool =  strcat(sub_dir(1).folder, '/',{sub_dir.name}');
%     
%     export_cell = cell(8, 2);
%     for ith_sess = 1:length(sub_pool)
%         cur_path = sub_pool{ith_sess};
%         curr_ima_strct = MRIread([cur_path, '/sms_bold_run', num2str(ith_sess),'.nii.gz']);
%         export_cell{ith_sess, 1} = curr_ima_strct;
%         export_cell{ith_sess, 2} = [cur_path, '/sms_bold_run', num2str(ith_sess),'.nii.gz'];
%     end
%     
%     export_struct = export_cell{1};
%     export_ima = export_struct.vol;
%     for ith_ima = 2:length(export_cell)
%         export_ima = cat(4, export_ima, export_cell{ith_ima}.vol);
%     end
%     export_struct.vol = export_ima;
%     MRIwrite(export_struct, [curr_dir, '/combined_4d_bold_sub', num2str(ith_cluster), '.nii.gz']);
% end



% fieldmap mag
root_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/Raw_MRI_backup/'];
each_cluster_dir = dir(fullfile(root_path, 'LJZB*'));
cluster_pool =  strcat(root_path, {each_cluster_dir.name}');
for ith_cluster = 1:length(cluster_pool)
    curr_dir = cluster_pool{ith_cluster};
    sub_num = strsplit(curr_dir, "LJZB");
    sub_dir = dir(fullfile(curr_dir, '*GRE_FIELD_MAPPING_SMS_1*'));
    sub_pool =  strcat(sub_dir(1).folder, '/',{sub_dir.name}');
    cur_path = sub_pool{1};
    out_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_fieldmap_mag/', 'sub', sub_num{2}, '_fieldmap_mag'];
    dicm2nii(cur_path, out_path, 1)
    cur_path
    out_path
end

% fieldmap pha
root_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/Raw_MRI_backup/'];
each_cluster_dir = dir(fullfile(root_path, 'LJZB*'));
cluster_pool =  strcat(root_path, {each_cluster_dir.name}');
for ith_cluster = 1:length(cluster_pool)
    curr_dir = cluster_pool{ith_cluster};
    sub_num = strsplit(curr_dir, "LJZB");
    sub_dir = dir(fullfile(curr_dir, '*GRE_FIELD_MAPPING_SMS_2*'));
    sub_pool =  strcat(sub_dir(1).folder, '/',{sub_dir.name}');
    cur_path = sub_pool{1};
    out_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_fieldmap_pha/', 'sub', sub_num{2}, '_fieldmap_pha'];
    dicm2nii(cur_path, out_path, 1)
    cur_path
    out_path
end


%% bold folder to image, mag
root_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_fieldmap_mag/'];
% sub_pool = {'11', '12', '13', '14', '15', '16', '17', '18', '19', '20'};
sub_pool = {'21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35'};
for ith_sub = 1:length(sub_pool)
    cur_sub = sub_pool{ith_sub};
    cur_file_path = [root_path, 'sub', cur_sub,'_fieldmap_mag/gre_field_mapping_sms.nii.gz'];
    des_file = [root_path, 'sub', cur_sub, '_fieldmap_mag.nii.gz'];
    copyfile(cur_file_path, des_file);
end


%% bold folder to image, pha
root_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_fieldmap_pha/'];
% sub_pool = {'11', '12', '13', '14', '15', '16', '17', '18', '19', '20'};
sub_pool = {'21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35'};
for ith_sub = 1:length(sub_pool)
    cur_sub = sub_pool{ith_sub};
    cur_file_path = [root_path, 'sub', cur_sub,'_fieldmap_pha/gre_field_mapping_sms_phase.nii.gz'];
    des_file = [root_path, 'sub', cur_sub, '_fieldmap_pha.nii.gz'];
    copyfile(cur_file_path, des_file);
end



