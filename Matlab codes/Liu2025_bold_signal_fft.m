
% generate
for ith_bin = [10, 20]

    if ith_bin==10
        angle_list = 0:10:350;
    end
    if ith_bin==15
        angle_list = 0:15:345;
    end
    if ith_bin==20
        angle_list = 0:20:340;
    end

    sub_pool = [1:28, 30, 32, 33, 34, 35];

    % cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_MTL_bigger.nii');
    % cur_mtl_ima = cur_struct.vol;
    % mask_index = find(cur_mtl_ima==1);
    % count_voxel = length(mask_index);

    cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_wholebrain.nii');
    cur_erc_ima = cur_struct.vol;
    mask_index = find(cur_erc_ima==1);
    count_voxel = length(mask_index);
    

    for ith_sub = 1:length(sub_pool)
        cur_sub = sub_pool(ith_sub);
        file_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/liujia_formal_sub',num2str(cur_sub),'/oscill_fieldmap_subj_bin',num2str(ith_bin),'.feat/stats/'];
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

        % %load a sample
        % ima_struct = MRIread(pe_dir{1});
        % sample_ima = ima_struct.vol;
        % index_non_zero =find(sample_ima~=0);
        % [d1, d2, d3] = ind2sub(size(sample_ima), index_non_zero);
        % count_voxel = length(d1);

        export_cell = NaN(count_voxel, length(pe_dir));
        for ith_pe = 1:length(pe_dir)
            cur_struct = MRIread(pe_dir{ith_pe});
            cur_ima = cur_struct.vol;
            cur_ima(find(cur_ima==0))= NaN;
            mean_cur_brain = mean(cur_ima(find(~isnan(cur_ima))));
            sd_cur_brain = std(cur_ima(find(~isnan(cur_ima))));
            z_cur_ima = (cur_ima-mean_cur_brain)/sd_cur_brain;
            export_cell(:, ith_pe) = z_cur_ima(mask_index);
            [num2str(ith_sub), '-', num2str(ith_pe)]
        end

        fileID = fopen(['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/MRI_results_formal/bold_angle_perio_bin', num2str(ith_bin), '_sub', num2str(cur_sub),'_subj_z_wb.txt'],'w');
        for ith = 1:length(export_cell(:,1))
            fprintf(fileID, [repmat('%s ', 1, length(angle_list)-1), '%s\n'] ,export_cell(ith,:));
        end
        fclose(fileID);
    end
end



%% export fft value as brain
cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_wholebrain.nii');
cur_mtl_ima = cur_struct.vol;
mask_index = find(cur_mtl_ima==1);
sub_pool = [1:28, 30, 32, 33, 34, 35];
for cur_bin = [10]
    for ith_ws = [0]
        for ith_sub = 1:length(sub_pool)
            cur_sub = sub_pool(ith_sub);

            if cur_bin == 10 
                path_rawData_record = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/MRI_results_formal/fft_value_wb_bin',num2str(cur_bin),'_sub', num2str(cur_sub),'_wb_win_size_',num2str(ith_ws),'_subj.txt'];
                rawFile = fopen(path_rawData_record,'rt');
                fft_table = textscan(rawFile, repmat('%s ', 1, 18));
                fclose(rawFile);
            end

            % if cur_bin ==20
            %     path_rawData_record = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/MRI_results_formal/fft_value_wb_bin',num2str(cur_bin),'_sub', num2str(cur_sub),'_wb_win_size_',num2str(ith_ws),'_subj.txt'];
            %     rawFile = fopen(path_rawData_record,'rt');
            %     fft_table = textscan(rawFile, repmat('%s ', 1, 9));
            %     fclose(rawFile);
            % end

            % load tempalte
            file_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/liujia_formal_sub',num2str(cur_sub),'/oscill_fieldmap_subj_bin',num2str(cur_bin),'.feat/stats/'];
            pe_dir = dir(fullfile(file_path, 'standard_pe*'));
            pe_dir =  strcat(file_path, {pe_dir.name}');
            cur_struct = MRIread(pe_dir{1});
            template_ima = cur_struct.vol;

            for ith_fre = [4,7]
                empty_brain = template_ima;
                empty_brain(:) = 0;
                empty_brain(mask_index) = str2double(fft_table{ith_fre});
                cur_struct.vol = empty_brain;
                MRIwrite(cur_struct, ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj/bin_',num2str(cur_bin), '_sub', num2str(cur_sub), '_freq', num2str(ith_fre-1), '_ws', num2str(ith_ws),'.nii.gz']);
                [num2str(ith_sub), ' - ', num2str(ith_fre)]
            end
        end
    end
end




%% mean for each hz
target_fold = 'new_stat_fft_subj';
init_threshold = 0.975;
cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_wholebrain.nii'); % mask_wholebrain mask_MTL_smaller
cur_mtl_ima = cur_struct.vol;
mask_index = find(cur_mtl_ima==1);
group_list = ["g123"];
for ith_group = 1:length(group_list)
    cur_group = char(group_list(ith_group));

    if strcmp(cur_group,'g1')
        sub_pool = 1:10;
    end
    if strcmp(cur_group,'g2')
        sub_pool = 11:20;
    end
    if strcmp(cur_group,'g3')
        sub_pool = [21:28, 30, 32, 33, 34, 35];
    end
    if strcmp(cur_group,'g123')
        sub_pool = [1:28, 30, 32, 33, 34, 35];
    end
    for cur_bin = [10]
        for ith_ws = [0]
            for ith_fre = [4,7]
                fft_threshold_list = [];
                empty_4d_brain = zeros(109, 91, 91, length(sub_pool));
                counter = 1;
                for ith_sub = sub_pool
                    file_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/',target_fold,'/bin_', num2str(cur_bin),'_sub', num2str(ith_sub), '_freq', num2str(ith_fre-1), '_ws', num2str(ith_ws),'.nii.gz'];
                    cur_struct = MRIread(file_path);
                    cur_ima = cur_struct.vol;

                    cur_ima(isnan(cur_ima))=0;
                    cur_ima(mask_index) = (cur_ima(mask_index))./std(cur_ima(mask_index));
                    cur_ima = smooth3(cur_ima,"gaussian",7);

                    empty_4d_brain(:,:,:,counter) = cur_ima;
                    counter = counter + 1;
                end
                
                mean_brain = mean(empty_4d_brain, 4);
                se_brain = std(empty_4d_brain, 0, 4)/sqrt(length(sub_pool));
                stat_brain = mean_brain./se_brain;
                stat_brain(isnan(stat_brain))=0;

                sort_mag = sort(stat_brain(find(stat_brain~=0)));
                get_valie = round(sort_mag( round(length(sort_mag)*init_threshold) ), 1);
                % fft_threshold_list = [fft_threshold_list; get_valie];
                % fileID = fopen(['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/',target_fold,'/cur_result_thres_',cur_group, '_freq', num2str(ith_fre-1), '_ws', num2str(ith_ws),'.txt'],'w');
                % for ith = 1:length(fft_threshold_list)
                %     fprintf(fileID,'%s\n',fft_threshold_list(ith));
                % end
                % fclose(fileID);

                %
                final_ima = zeros(size(stat_brain));
                nvox = length(stat_brain(:));
                C=6;
                cc = arrayfun(@(x) bwconncomp(bsxfun(@gt,stat_brain,x),C), get_valie);
                ima_1d = zeros(nvox,1);
                array_for_numVoxel_eachCluster = cellfun(@numel,cc.PixelIdxList);
                for each_cluster = 1:cc.NumObjects
                    if array_for_numVoxel_eachCluster(each_cluster)>10
                        indexes = cc.PixelIdxList{each_cluster};
                        ima_1d(cc.PixelIdxList{each_cluster}) = stat_brain(indexes);
                    end
                end
                final_ima(:)=ima_1d;

                %
                cur_struct.vol = empty_4d_brain;
                MRIwrite(cur_struct, ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/',target_fold,'/o4D_bin',num2str(cur_bin),'_',cur_group,'_freq', num2str(ith_fre-1), '_ws', num2str(ith_ws),'_thres', num2str(get_valie),'.nii.gz']);

                cur_struct.vol = final_ima;
                MRIwrite(cur_struct, ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/',target_fold,'/cur_result_bin', num2str(cur_bin),'_', cur_group,'_freq', num2str(ith_fre-1), '_ws', num2str(ith_ws),'.nii.gz']);

            end

        end

    end
end

