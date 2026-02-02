
% generate

cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_HPC_2mm.nii');
cur_hpc_ima = cur_struct.vol;
mask_index = find(cur_hpc_ima>0);



% cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_ERC_harddraw_2mm.nii');
% cur_erc_ima = cur_struct.vol;
% mask_index = find(cur_erc_ima==1);
%
% cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_Occipital_Inf.nii');
% cur_erc_ima = cur_struct.vol;
% mask_index = find(cur_erc_ima==1);
%
% cur_struct = MRIread('/Users/bo/Desktop/hpc_mask.nii');
% cur_hpc_focus_ima = cur_struct.vol;
% mask_index = find(cur_hpc_focus_ima==1);
%
% cur_struct = MRIread('/Users/bo/Documents/brainmask/erc_mask.nii');
% cur_erc_focus_ima = cur_struct.vol;
% mask_index = find(cur_erc_focus_ima==1);

% cur_struct = MRIread('/Users/bo/Documents/brainmask/Hippocampus_p_r.nii');
% cur_hpc_ima = cur_struct.vol;
% mask_index = find(cur_hpc_ima==1);

% cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_MTL_bigger.nii');
% cur_mtl_ima = cur_struct.vol;
% mask_index = find(cur_mtl_ima==1);

% cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_ParaHippocampal.nii');
% cur_phc_ima = cur_struct.vol;
% mask_index = find(cur_phc_ima==1);

% cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_erc_and_HPC_r.nii');
% cur_hpc_erc_ima = cur_struct.vol;
% mask_index = find(cur_hpc_erc_ima==1);

% erc_r_struct = MRIread('/Users/bo/Documents/brainmask/mask_ERC_harddraw_2mm_r.nii');
% erc_r_ima = erc_r_struct.vol;
% mask_index = find(erc_r_ima==1);
%
% hpc_r_struct = MRIread('/Users/bo/Documents/brainmask/Hippocampus_a_r.nii');
% hpc_r_ima = hpc_r_struct.vol;
% mask_index = find(hpc_r_ima==1);

% hpc_r_struct = MRIread('/Users/bo/Documents/brainmask/mask_HPC_2mm_R.nii');
% hpc_r_ima = hpc_r_struct.vol;
% mask_index = find(hpc_r_ima==1);

% cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_MTL_bigger.nii');
% cur_mtl_ima = cur_struct.vol;
% mask_index = find(cur_mtl_ima==1);



% angle_list = 0:20:340;
% angle_list = 0:10:350;
angle_list = 0:15:345;


for ith_type = 1:2
%     if ith_type == 1
%         sub_pool = {'01', '02', '03', '04', '05', '06', '07', '08', '09', '10'};
% %         cur_struct = MRIread('/Users/bo/Documents/data_liujia_lab/exp_greeble/mask/mask_erc_fun_grid_g1.nii');
%         cur_struct = MRIread('/Users/bo/Documents/data_liujia_lab/exp_greeble/mask/mask_2mm_single_30_hbt.nii');
%         cur_erc_ima = cur_struct.vol;
%         mask_index = find(cur_erc_ima==1);
%     end
%     if ith_type == 2
%         sub_pool = {'11', '12', '13', '14', '15', '16', '17', '18', '19', '20'};
% %         cur_struct =
% %         MRIread('/Users/bo/Documents/data_liujia_lab/exp_greeble/mask/mask_erc_fun_grid_g2.nii');
%         cur_struct = MRIread('/Users/bo/Documents/data_liujia_lab/exp_greeble/mask/mask_2mm_single_30_hbt.nii');
%         cur_erc_ima = cur_struct.vol;
%         mask_index = find(cur_erc_ima==1);
%     end

    if ith_type == 1
        sub_pool = {'01', '02', '03', '04', '05', '06', '07', '08', '09', '10'};
%         cur_struct = MRIread('/Users/bo/Documents/data_liujia_lab/exp_greeble/mask/mask_erc_fun_grid_g1.nii');
        cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_wholebrain.nii');
        cur_erc_ima = cur_struct.vol;
        mask_index = find(cur_erc_ima==1);
    end
    if ith_type == 2
        sub_pool = {'11', '12', '13', '14', '15', '16', '17', '18', '19', '20'};
        cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_wholebrain.nii');
        cur_erc_ima = cur_struct.vol;
        mask_index = find(cur_erc_ima==1);
    end
    
    count_voxel = length(mask_index);
    
    for ith_sub = 1:length(sub_pool)
        cur_sub = sub_pool{ith_sub};
        file_path = ['/Users/bo/Documents/data_liujia_lab/exp_liu_p1_greeble/liujia_formal_sub',cur_sub,'/oscill_fieldmap_obj.feat/stats/'];
        % file_path = ['/Users/bo/Documents/data_liujia_lab/exp_greeble/liujia_formal_sub',cur_sub,'/oscill_fieldmap_obj_bin10.feat/stats/'];
        pe_dir = dir(fullfile(file_path, 'standard_pe*'));
        pe_dir =  strcat(file_path, {pe_dir.name}');
        
        sort_index_pool = [];
        for ith_file = 1:length(pe_dir)
            cur_pe = extractBetween(pe_dir{ith_file}, 'stats/standard_pe', '.nii.gz');
            cur_pe = str2double(cur_pe{1});
            sort_index_pool = [sort_index_pool, cur_pe];
        end
        [I, M] = sort(sort_index_pool, 'ascend');
        pe_dir = pe_dir(M);
        pe_dir = pe_dir(1:length(angle_list));
        
        %     %load a sample
        %     ima_struct = MRIread(pe_dir{1});
        %     sample_ima = ima_struct.vol;
        %     index_non_zero =find(sample_ima~=0);
        %     [d1, d2, d3] = ind2sub(size(sample_ima), index_non_zero);
        %     count_voxel = length(d1);
        
        export_cell = NaN(count_voxel, length(pe_dir));
        for ith_pe = 1:length(pe_dir)
            cur_struct = MRIread(pe_dir{ith_pe});
            cur_ima = cur_struct.vol;
            cur_ima(find(cur_ima==0))= NaN;
            mean_cur_brain = mean(cur_ima(find(~isnan(cur_ima))));
            sd_cur_brain = std(cur_ima(find(~isnan(cur_ima))));
            z_cur_ima = (cur_ima-mean_cur_brain)/sd_cur_brain;
            %         export_cell(:, ith_pe) = z_cur_ima(index_non_zero);
            export_cell(:, ith_pe) = z_cur_ima(mask_index);
            [num2str(ith_sub), '-', num2str(ith_pe)]
        end
        
        fileID = fopen(['/Users/bo/Documents/data_liujia_lab/exp_liu_p1_greeble/MRI_results_formal/bold_angle_perio_bin', num2str(360/length(angle_list)), '_sub', num2str(str2double(cur_sub)),'_obj_wb.txt'],'w');
        for ith = 1:length(export_cell(:,1))
            fprintf(fileID, [repmat('%s ', 1, length(angle_list)-1), '%s\n'] ,export_cell(ith,:));
        end
        fclose(fileID);
    end
end




% cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_MTL_bigger.nii');
cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_wholebrain.nii');
cur_mtl_ima = cur_struct.vol;
mask_index = find(cur_mtl_ima==1);
%% export fft value as brain
% sub_pool = {'01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20'};
% sub_pool = {'01', '02', '03', '04', '05', '06', '07', '08', '09', '10'};
% sub_pool = {'11', '12', '13', '14', '15', '16', '17', '18', '19', '20'};
sub_pool = {'01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20'};
for ith_ws = [1, 2, 4]
    for ith_sub = 1:length(sub_pool)
        cur_sub = sub_pool{ith_sub};
        
        path_rawData_record = ['/Users/bo/Documents/data_liujia_lab/exp_liu_p1_greeble/MRI_results_formal/fft_value_bin15_sub', num2str(str2double(cur_sub)),'_freq3_wb_win_size_',num2str(ith_ws),'.txt'];
        rawFile = fopen(path_rawData_record,'rt');
        fft_table = textscan(rawFile, repmat('%s ', 1, 12));
        fclose(rawFile);
        
        % load tempalte
        file_path = ['/Users/bo/Documents/data_liujia_lab/exp_liu_p1_greeble/liujia_formal_sub',cur_sub,'/oscill_fieldmap_obj.feat/stats/'];
        pe_dir = dir(fullfile(file_path, 'standard_pe*'));
        pe_dir =  strcat(file_path, {pe_dir.name}');
        cur_struct = MRIread(pe_dir{1});
        template_ima = cur_struct.vol;
        
        for ith_fre = [4]
            empty_brain = template_ima;
            empty_brain(:) = 0;
            empty_brain(mask_index) = str2double(fft_table{ith_fre});
            cur_struct.vol = empty_brain;
            MRIwrite(cur_struct, ['/Users/bo/Documents/data_liujia_lab/exp_liu_p1_greeble/MRI_results_formal/stat_fft_win_size15_wb/sub', num2str(str2double(cur_sub)), '_freq', num2str(ith_fre-1), '_ws', num2str(ith_ws),'.nii.gz']);
            [num2str(ith_sub), ' - ', num2str(ith_fre)]
        end
    end
end




%% mean for each hz
group_label = 'g12';
init_threshold = 0.99;
if strcmp(group_label,'g1')
    sub_pool = 1:10;
end
if strcmp(group_label,'g2')
    sub_pool = 11:20;
end
if strcmp(group_label,'g12')
    sub_pool = 1:20;
end

cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_nowm_withsubc.nii');
cur_mtl_ima = cur_struct.vol;
mask_remove_index = find(cur_mtl_ima==0);

for ith_ws = [2]
    fft_threshold_list = [];
    for ith_fre = [1,4,7]
        cur_freq = ith_fre-1;
        empty_4d_brain = zeros(109, 91, 91, length(sub_pool));
        counter = 1;
        for ith_sub = sub_pool
            file_path = ['/Users/bo/Documents/data_liujia_lab/exp_liu_p1_greeble/MRI_results_formal/stat_fft_win_size15_wb/sub', num2str(ith_sub), '_freq', num2str(cur_freq), '_ws', num2str(ith_ws),'.nii.gz'];
            cur_struct = MRIread(file_path);
            cur_ima = cur_struct.vol;
            empty_4d_brain(:,:,:,counter) = cur_ima;
            counter = counter + 1;
        end
        % cur_struct.vol = empty_4d_brain;
        % MRIwrite(cur_struct, ['/Users/bo/Documents/data_liujia_lab/exp_liu_p1_greeble/MRI_results_formal/stat_fft_win_size15_wb/o4D_',group_label,'_freq', num2str(cur_freq), '_ws', num2str(ith_ws),'.nii.gz']);
        
        mean_brain = mean(empty_4d_brain, 4);
        se_brain = std(empty_4d_brain, 0, 4)/sqrt(length(sub_pool));
        stat_brain = mean_brain./se_brain;
        stat_brain(isnan(stat_brain))=0;
        stat_brain(mask_remove_index)=0;

        sort_mag = sort(stat_brain(find(~isnan(stat_brain))));
        get_valie = sort_mag( round(length(sort_mag)*init_threshold) );
        fft_threshold_list = [fft_threshold_list; get_valie];

        final_ima = zeros(size(stat_brain));
        nvox = length(stat_brain(:));
        C=6;
        cc = arrayfun(@(x) bwconncomp(bsxfun(@gt,stat_brain,x),C), get_valie);
        ima_1d = zeros(nvox,1);
        array_for_numVoxel_eachCluster = cellfun(@numel,cc.PixelIdxList);
        for each_cluster = 1:cc.NumObjects
            if array_for_numVoxel_eachCluster(each_cluster)>25
                indexes = cc.PixelIdxList{each_cluster};
                ima_1d(cc.PixelIdxList{each_cluster}) = stat_brain(indexes);
            end
        end
        final_ima(:)=ima_1d;

        cur_struct.vol = final_ima;

        MRIwrite(cur_struct, ['/Users/bo/Documents/data_liujia_lab/exp_liu_p1_greeble/MRI_results_formal/stat_fft_win_size15_wb/stat_result_', group_label,'_freq', num2str(ith_fre-1), '_ws', num2str(ith_ws),'.nii.gz']);
        

    end
    % fileID = fopen(['/Users/bo/Documents/data_liujia_lab/exp_liu_p1_greeble/MRI_results_formal/stat_fft_win_size15_wb/init_threshold_', num2str(init_threshold), '_',group_label ,'_ws', num2str(ith_ws) ,'.txt'],'w');
    % for ith = 1:length(fft_threshold_list)
    %     fprintf(fileID,'%s\n',fft_threshold_list(ith));
    % end
    % fclose(fileID);
end







%% test t val
group_label = 'g1';
init_threshold = 0.99;
if strcmp(group_label,'g1')
    sub_pool = 1:10;
end
if strcmp(group_label,'g2')
    sub_pool = 11:20;
end
if strcmp(group_label,'g12')
    sub_pool = 1:20;
end

cur_struct = MRIread('/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/mask/mask_nowm_withsubc.nii');
cur_mtl_ima = cur_struct.vol;
mask_remove_index = find(cur_mtl_ima==0);

for ith_ws = [2]
    fft_threshold_list = [];
    for ith_fre = [4,7]
        cur_freq = ith_fre-1;
        empty_4d_brain = zeros(109, 91, 91, length(sub_pool));
        counter = 1;
        for ith_sub = sub_pool
            file_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/stat_fft_win_size15_wb/sub', num2str(ith_sub), '_freq', num2str(cur_freq), '_ws', num2str(ith_ws),'.nii.gz'];
            cur_struct = MRIread(file_path);
            cur_ima = cur_struct.vol;
            cur_ima(find(isnan(cur_ima))) = 0;
            % cur_index = find(cur_ima~=0);

            % mean_value = mean(cur_ima(cur_index));
            % cur_ima(cur_index) = cur_ima(cur_index)-mean_value;
            empty_4d_brain(:,:,:,counter) = cur_ima;
            counter = counter + 1;
        end
        % cur_struct.vol = empty_4d_brain;
        % MRIwrite(cur_struct, ['/Users/bo/Documents/data_liujia_lab/exp_liu_p1_greeble/MRI_results_formal/stat_fft_win_size15_wb/o4D_',group_label,'_freq', num2str(cur_freq), '_ws', num2str(ith_ws),'.nii.gz']);
        
        mean_brain = mean(empty_4d_brain, 4);
        se_brain = std(empty_4d_brain, 0, 4)/sqrt(length(sub_pool));

        cur_index = find(cur_ima~=0);
        mean_value = mean(mean_brain(cur_index));

        %
        mean_brain(cur_index) = mean_brain(cur_index);
        stat_brain = mean_brain./se_brain;

        mean_value = nanmean(stat_brain(:));

        stat_brain(isnan(stat_brain))=0;

        stat_brain(mask_remove_index)=0;

        sort_mag = sort(stat_brain(find(~isnan(stat_brain))));
        get_valie = sort_mag( round(length(sort_mag)*init_threshold) );
        fft_threshold_list = [fft_threshold_list; mean_value];
%         fft_threshold_list = [fft_threshold_list; get_valie];

        final_ima = zeros(size(stat_brain));
        nvox = length(stat_brain(:));
        C=6;
        cc = arrayfun(@(x) bwconncomp(bsxfun(@gt,stat_brain,x),C), get_valie);
        ima_1d = zeros(nvox,1);
        array_for_numVoxel_eachCluster = cellfun(@numel,cc.PixelIdxList);
        for each_cluster = 1:cc.NumObjects
            if array_for_numVoxel_eachCluster(each_cluster)>25
                indexes = cc.PixelIdxList{each_cluster};
                ima_1d(cc.PixelIdxList{each_cluster}) = stat_brain(indexes);
            end
        end
        final_ima(:)=ima_1d;

        cur_struct.vol = stat_brain;

        % MRIwrite(cur_struct, ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_formal/stat_fft_win_size15_wb/stat_result_', group_label,'_freq', num2str(ith_fre-1), '_ws', num2str(ith_ws),'.nii.gz']);
        
    end
    % fileID = fopen(['/Users/bo/Documents/data_liujia_lab/exp_liu_p1_greeble/MRI_results_formal/stat_fft_win_size15_wb/init_threshold_', num2str(init_threshold), '_',group_label ,'_ws', num2str(ith_ws) ,'.txt'],'w');
    % for ith = 1:length(fft_threshold_list)
    %     fprintf(fileID,'%s\n',fft_threshold_list(ith));
    % end
    % fclose(fileID);
end







