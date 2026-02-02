

% 
% %% find peak & make sphere
% ima_struct = MRIread('/Users/bo/Documents/data_liujia_lab/task_greeble/pilot_beh_mri_results/MRI_results/periodic_testing_6_fieldmap_cali_clustere_corrp_tstat1.nii.gz');
% cur_ima = ima_struct.vol;
% 
% t_ima_struct = MRIread('/Users/bo/Documents/data_liujia_lab/task_greeble/pilot_beh_mri_results/MRI_results/periodic_testing_6_fieldmap_cali_tstat1.nii.gz');
% cur_t_ima = t_ima_struct.vol;
% 
% erc_mask_struct = MRIread('/Users/bo/Documents/brainmask/mask_ERC_harddraw_2mm.nii');
% erc_mask_ima = erc_mask_struct.vol;
% index_mask = find(erc_mask_ima>0);
% 
% index_cluster = find(cur_ima==max(cur_ima(:)));
% 
% [erc_cluster_overlap_index, pos]=intersect(index_mask,index_cluster);
% cluter_t_value_list = cur_t_ima(erc_cluster_overlap_index);
% 
% peak_list = find(cluter_t_value_list==max(cluter_t_value_list));
% peak_whole_brain_index = erc_cluster_overlap_index(peak_list(1));
% 
% [d1, d2, d3] = ind2sub(size(cur_t_ima), peak_whole_brain_index);
% 
% spherec_coordinate = sphericalRelativeRoi(5,[2 2 2]);
% spherec = repmat([d1, d2, d3], size(spherec_coordinate,1), 1) + spherec_coordinate;
% [row_ind, col_ind] = find(spherec(:,1) < 1 | spherec(:,2) < 1 | spherec(:,3) < 1 | spherec(:,1)>d1 | spherec(:,2)>d2 | spherec(:,3)>d3);
% spherec (row_ind, :) = [];
% 
% empty_ima = cur_ima;
% empty_ima(:)=0;
% for voxel =  1:length(spherec(:,1))
%     empty_ima(spherec(voxel,1),spherec(voxel,2),spherec(voxel,3)) = 1;
% end
% ima_struct.vol = empty_ima;
% MRIwrite(ima_struct, ['/Users/bo/Desktop/sphere_brain.nii']);





%% peak g123 sinusoid 6fold
mask_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/periodic_2501_testing_6_fieldmap_vector_mean/thres_35_clusterm_corrp_tstat1.nii.gz';
mask_struct = MRIread(mask_path);
mask_ima = mask_struct.vol;
mask_erc_struct = MRIread('/Users/bo/Documents/brainmask/mask_ERC_harddraw_2mm.nii');
mask_erc_ima = mask_erc_struct.vol;

idx = find(mask_ima>0.95 & mask_erc_ima==1);

t_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/periodic_2501_testing_6_fieldmap_vector_mean/thres_35_tstat1.nii.gz';
t_struct = MRIread(t_path);
t_ima = t_struct.vol;

[fir_di, sec_di, thi_di] = size(t_ima);
[d1, d2, d3] = ind2sub([fir_di, sec_di, thi_di],find(t_ima==max(t_ima(idx)))); % -1
voxel_array = [d2;d1;d3;2]-1;
t_struct.vox2ras * voxel_array

%% cohen d
mask_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/periodic_2501_testing_6_fieldmap_vector_mean/thres_35_clusterm_corrp_tstat1.nii.gz';
mask_struct = MRIread(mask_path);
mask_ima = mask_struct.vol;

idx = find(mask_ima>0.95);

path_4d = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/periodic_2501_testing_6_fieldmap_vector_mean/4d_freq2025.nii';
ima_4d_struct = MRIread(path_4d);
ima_4d = ima_4d_struct.vol;
ima_4d = reshape(ima_4d, 109*91*91, 33);
ima_4d = ima_4d(idx, :);

mean_ima = mean(ima_4d, 1);

mean(mean_ima)/std(mean_ima)










%% peak g123 sinusoid 3fold
mask_path = '/Users/bo/Documents/brainmask/mask_HPC_2mm.nii';
t_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/periodic_2501_testing_3_fieldmap_vector_mean/corr__tstat1.nii.gz';

mask_struct = MRIread(mask_path);
mask_ima = mask_struct.vol;
idx = find(mask_ima==1);

t_struct = MRIread(t_path);
t_ima = t_struct.vol;

[fir_di, sec_di, thi_di] = size(t_ima);
[d1, d2, d3] = ind2sub([fir_di, sec_di, thi_di],find(t_ima==max(t_ima(idx)))); % -1
voxel_array = [d2;d1;d3;2]-1;
t_struct.vox2ras * voxel_array

%% cohen d
% mask_result_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/periodic_2501_testing_3_fieldmap_vector_mean/unc_1_35_freq2025.nii';
mask_result_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/periodic_2501_testing_3_fieldmap_vector_mean/corr__binary_wr_c20r.nii.gz';
mask_result = MRIread(mask_result_path).vol;

mask_hpc_struct = MRIread('/Users/bo/Documents/brainmask/mask_HPC_2mm.nii');
mask_hpc_ima = mask_hpc_struct.vol;
idx = find(mask_hpc_ima==1 & mask_result==1);

path_4d = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/periodic_2501_testing_3_fieldmap_vector_mean/4d_freq2025.nii';
ima_4d_struct = MRIread(path_4d);
ima_4d = ima_4d_struct.vol;
ima_4d = reshape(ima_4d, 109*91*91, 33);
ima_4d = ima_4d(idx, :);

mean_ima = mean(ima_4d, 1);

mean(mean_ima)/std(mean_ima)









%% peak g123 fft bin10 3fold
mask_hpc_path = '/Users/bo/Documents/brainmask/mask_HPC_2mm.nii';
mask_hpc_struct = MRIread(mask_hpc_path);
mask_hpc_ima = mask_hpc_struct.vol;
idx_hpc = find(mask_hpc_ima~=1);
cur_thres = 15.9;

mask_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g123_freq3_ws0_clustere_corrp_tstat1_binary_wr_c8r.nii.gz';
mask_struct = MRIread(mask_path);
mask_ima = mask_struct.vol;
idx = find(mask_ima==1);

t_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g123_freq3_ws0_tstat1.nii.gz';
t_struct = MRIread(t_path);
t_ima = t_struct.vol;
t_ima(idx_hpc) = 0;

[fir_di, sec_di, thi_di] = size(t_ima);
max_t = max(t_ima(idx));
max_t-cur_thres
[d1, d2, d3] = ind2sub([fir_di, sec_di, thi_di],find(t_ima==max_t)); % -1 15.7
voxel_array = [d2;d1;d3;2]-1;
t_struct.vox2ras * voxel_array

%% cohen d 
mask_result_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g123_freq3_ws0_clustere_corrp_tstat1_binary_wr_c8r.nii.gz';
mask_result = MRIread(mask_result_path).vol;
idx_result = find(mask_result==1);

mask_hpc_struct = MRIread('/Users/bo/Documents/brainmask/mask_HPC_2mm.nii');
mask_hpc_ima = mask_hpc_struct.vol;


path_4d = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/o4D_bin10_g123_freq3_ws0_thres15.9.nii.gz';
ima_4d_struct = MRIread(path_4d);
ima_4d = ima_4d_struct.vol;
ima_4d = reshape(ima_4d, 109*91*91, 33);

mean_brain = mean(ima_4d, 2);
se_brain = std(ima_4d, 0, 2)/sqrt(33);
stat_brain = mean_brain./se_brain;
stat_brain(isnan(stat_brain))=0;

(mean(stat_brain(idx_result))-cur_thres)/std(stat_brain(idx_result))




% %% peak g123 fft bin10 6fold
% mask_path = '/Users/bo/Documents/brainmask/mask_ERC_harddraw_2mm.nii';
% mask_struct = MRIread(mask_path);
% mask_ima = mask_struct.vol;
% idx_non = find(mask_ima~=1);
% cur_thres = 15.9;
% 
% mask_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g123_freq6_ws0_clustere_corrp_tstat1_binary_wr_c8r.nii.gz';
% mask_struct = MRIread(mask_path);
% mask_ima = mask_struct.vol;
% idx_erc = find(mask_ima==1);
% 
% t_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g123_freq6_ws0_tstat1.nii.gz';
% t_struct = MRIread(t_path);
% t_ima = t_struct.vol;
% t_ima(idx_non) = 0;
% 
% [fir_di, sec_di, thi_di] = size(t_ima);
% max_t = max(t_ima(idx_erc));
% max_t-cur_thres
% [d1, d2, d3] = ind2sub([fir_di, sec_di, thi_di],find(t_ima==max_t)); % -1 15.7
% voxel_array = [d2;d1;d3;2]-1;
% t_struct.vox2ras * voxel_array
% 
% %% cohen d 
% mask_result_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g123_freq6_ws0_clustere_corrp_tstat1_binary_wr_c8r.nii.gz';
% mask_result = MRIread(mask_result_path).vol;
% idx_result = find(mask_result==1);
% 
% % mask_hpc_struct = MRIread('/Users/bo/Documents/brainmask/mask_HPC_2mm.nii');
% % mask_hpc_ima = mask_hpc_struct.vol;
% 
% path_4d = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/o4D_bin10_g123_freq6_ws0_thres15.9.nii.gz';
% ima_4d_struct = MRIread(path_4d);
% ima_4d = ima_4d_struct.vol;
% ima_4d = reshape(ima_4d, 109*91*91, 33);
% 
% mean_brain = mean(ima_4d, 2);
% se_brain = std(ima_4d, 0, 2)/sqrt(33);
% stat_brain = mean_brain./se_brain;
% stat_brain(isnan(stat_brain))=0;
% 
% (mean(stat_brain(idx_result))-cur_thres)/std(stat_brain(idx_result))






%% peak g123 fft bin20 3fold
mask_hpc_path = '/Users/bo/Documents/brainmask/mask_HPC_2mm.nii';
mask_hpc_struct = MRIread(mask_hpc_path);
mask_hpc_ima = mask_hpc_struct.vol;
idx_hpc = find(mask_hpc_ima~=1);
cur_thres = 15.7;

mask_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin20_g123_freq3_ws0_clusterm_corrp_tstat1_binary_wr_c10r.nii.gz';
mask_struct = MRIread(mask_path);
mask_ima = mask_struct.vol;
idx = find(mask_ima==1);

t_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/cur_result_bin20_g123_freq3_ws0.nii.gz';
t_struct = MRIread(t_path);
t_ima = t_struct.vol;
t_ima(idx_hpc) = 0;

[fir_di, sec_di, thi_di] = size(t_ima);
max_t = max(t_ima(idx));
max_t-cur_thres
[d1, d2, d3] = ind2sub([fir_di, sec_di, thi_di],find(t_ima==max_t)); % -1 15.7
voxel_array = [d2;d1;d3;2]-1;
t_struct.vox2ras * voxel_array

%% cohen d 
mask_result_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin20_g123_freq3_ws0_clusterm_corrp_tstat1_binary_wr_c10r.nii.gz';
mask_result = MRIread(mask_result_path).vol;
% idx_result = find(mask_result==1);

mask_hpc_struct = MRIread('/Users/bo/Documents/brainmask/mask_HPC_2mm.nii');
mask_hpc_ima = mask_hpc_struct.vol;
idx_result = find(mask_result==1);

path_4d = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/o4D_bin20_g123_freq3_ws0_thres15.7.nii.gz';
ima_4d_struct = MRIread(path_4d);
ima_4d = ima_4d_struct.vol;
ima_4d = reshape(ima_4d, 109*91*91, 33);

mean_brain = mean(ima_4d, 2);
se_brain = std(ima_4d, 0, 2)/sqrt(33);
stat_brain = mean_brain./se_brain;
stat_brain(isnan(stat_brain))=0;

(mean(stat_brain(idx_result))-cur_thres)/std(stat_brain(idx_result))








%% peak g1 fft bin10 3fold
mask_hpc_path = '/Users/bo/Documents/brainmask/mask_HPC_2mm.nii';
mask_hpc_struct = MRIread(mask_hpc_path);
mask_hpc_ima = mask_hpc_struct.vol;
idx_hpc = find(mask_hpc_ima~=1);
cur_thres = 11.7;

mask_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g1_freq3_ws0_clusterm_corrp_tstat1_binary_wr_c10r.nii.gz';
mask_struct = MRIread(mask_path);
mask_ima = mask_struct.vol;
idx = find(mask_ima==1);

t_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/cur_result_bin10_g1_freq3_ws0.nii.gz';
t_struct = MRIread(t_path);
t_ima = t_struct.vol;
t_ima(idx_hpc) = 0;

[fir_di, sec_di, thi_di] = size(t_ima);
max_t = max(t_ima(idx));
max_t-cur_thres
[d1, d2, d3] = ind2sub([fir_di, sec_di, thi_di],find(t_ima==max_t)); % -1 
voxel_array = [d2;d1;d3;2]-1;
t_struct.vox2ras * voxel_array

%% cohen d 
mask_result_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g1_freq3_ws0_clusterm_corrp_tstat1_binary_wr_c10r.nii.gz';
mask_result = MRIread(mask_result_path).vol;
% idx_result = find(mask_result==1);

mask_hpc_struct = MRIread('/Users/bo/Documents/brainmask/mask_HPC_2mm.nii');
mask_hpc_ima = mask_hpc_struct.vol;
idx_result = find(mask_result==1);

path_4d = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/o4D_bin10_g1_freq3_ws0_thres11.7.nii.gz';
ima_4d_struct = MRIread(path_4d);
ima_4d = ima_4d_struct.vol;
ima_4d = reshape(ima_4d, 109*91*91, 10);

mean_brain = mean(ima_4d, 2);
se_brain = std(ima_4d, 0, 2)/sqrt(10);
stat_brain = mean_brain./se_brain;
stat_brain(isnan(stat_brain))=0;

(mean(stat_brain(idx_result))-cur_thres)/std(stat_brain(idx_result))






%% peak g2 fft bin10 3fold
mask_hpc_path = '/Users/bo/Documents/brainmask/mask_HPC_2mm.nii';
mask_hpc_struct = MRIread(mask_hpc_path);
mask_hpc_ima = mask_hpc_struct.vol;
idx_hpc = find(mask_hpc_ima~=1);
cur_thres = 11.6;

mask_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g2_freq3_ws0_clusterm_corrp_tstat1_binary_wr_c10r.nii.gz';
mask_struct = MRIread(mask_path);
mask_ima = mask_struct.vol;
idx = find(mask_ima==1);

t_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/cur_result_bin10_g2_freq3_ws0.nii.gz';
t_struct = MRIread(t_path);
t_ima = t_struct.vol;
t_ima(idx_hpc) = 0;

[fir_di, sec_di, thi_di] = size(t_ima);
max_t = max(t_ima(idx));
max_t-cur_thres
[d1, d2, d3] = ind2sub([fir_di, sec_di, thi_di],find(t_ima==max_t)); % -1 
voxel_array = [d2;d1;d3;2]-1;
t_struct.vox2ras * voxel_array

%% cohen d 
mask_result_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g2_freq3_ws0_clusterm_corrp_tstat1_binary_wr_c10r.nii.gz';
mask_result = MRIread(mask_result_path).vol;
% idx_result = find(mask_result==1);

mask_hpc_struct = MRIread('/Users/bo/Documents/brainmask/mask_HPC_2mm.nii');
mask_hpc_ima = mask_hpc_struct.vol;
idx_result = find(mask_result==1);

path_4d = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/o4D_bin10_g2_freq3_ws0_thres11.6.nii.gz';
ima_4d_struct = MRIread(path_4d);
ima_4d = ima_4d_struct.vol;
ima_4d = reshape(ima_4d, 109*91*91, 10);

mean_brain = mean(ima_4d, 2);
se_brain = std(ima_4d, 0, 2)/sqrt(10);
stat_brain = mean_brain./se_brain;
stat_brain(isnan(stat_brain))=0;

(mean(stat_brain(idx_result))-cur_thres)/std(stat_brain(idx_result))




%% peak g3 fft bin10 3fold
mask_hpc_path = '/Users/bo/Documents/brainmask/mask_HPC_2mm.nii';
mask_hpc_struct = MRIread(mask_hpc_path);
mask_hpc_ima = mask_hpc_struct.vol;
idx_hpc = find(mask_hpc_ima~=1);
cur_thres = 11.9;

mask_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g3_freq3_ws0_clusterm_corrp_tstat1_binary_wr_c10r.nii.gz';
mask_struct = MRIread(mask_path);
mask_ima = mask_struct.vol;
idx = find(mask_ima==1);

t_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/cur_result_bin10_g3_freq3_ws0.nii.gz';
t_struct = MRIread(t_path);
t_ima = t_struct.vol;
t_ima(idx_hpc) = 0;

[fir_di, sec_di, thi_di] = size(t_ima);
max_t = max(t_ima(idx));
max_t-cur_thres
[d1, d2, d3] = ind2sub([fir_di, sec_di, thi_di],find(t_ima==max_t)); % -1 
voxel_array = [d2;d1;d3;2]-1;
t_struct.vox2ras * voxel_array

%% cohen d 
mask_result_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g3_freq3_ws0_clusterm_corrp_tstat1_binary_wr_c10r.nii.gz';
mask_result = MRIread(mask_result_path).vol;
% idx_result = find(mask_result==1);

mask_hpc_struct = MRIread('/Users/bo/Documents/brainmask/mask_HPC_2mm.nii');
mask_hpc_ima = mask_hpc_struct.vol;
idx_result = find(mask_result==1);

path_4d = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/o4D_bin10_g3_freq3_ws0_thres11.9.nii.gz';
ima_4d_struct = MRIread(path_4d);
ima_4d = ima_4d_struct.vol;
ima_4d = reshape(ima_4d, 109*91*91, 13);

mean_brain = mean(ima_4d, 2);
se_brain = std(ima_4d, 0, 2)/sqrt(13);
stat_brain = mean_brain./se_brain;
stat_brain(isnan(stat_brain))=0;

(mean(stat_brain(idx_result))-cur_thres)/std(stat_brain(idx_result))













%% peak g1 fft bin10 6fold
mask_hpc_path = '/Users/bo/Documents/brainmask/mask_ERC_harddraw_2mm.nii';
mask_hpc_struct = MRIread(mask_hpc_path);
mask_hpc_ima = mask_hpc_struct.vol;
idx_hpc = find(mask_hpc_ima~=1);
cur_thres = 11.9;

mask_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g1_freq6_ws0_clusterm_corrp_tstat1_binary_wr_c10r.nii.gz';
mask_struct = MRIread(mask_path);
mask_ima = mask_struct.vol;
idx = find(mask_ima==1);

t_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/cur_result_bin10_g1_freq6_ws0.nii.gz';
t_struct = MRIread(t_path);
t_ima = t_struct.vol;
t_ima(idx_hpc) = 0;

[fir_di, sec_di, thi_di] = size(t_ima);
max_t = max(t_ima(idx));
max_t-cur_thres
[d1, d2, d3] = ind2sub([fir_di, sec_di, thi_di],find(t_ima==max_t)); % -1 
voxel_array = [d2;d1;d3;2]-1;
t_struct.vox2ras * voxel_array

%% cohen d 
mask_result_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g1_freq6_ws0_clusterm_corrp_tstat1_binary_wr_c10r.nii.gz';
mask_result = MRIread(mask_result_path).vol;
% idx_result = find(mask_result==1);

mask_hpc_struct = MRIread('/Users/bo/Documents/brainmask/mask_HPC_2mm.nii');
mask_hpc_ima = mask_hpc_struct.vol;
idx_result = find(mask_result==1);

path_4d = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/o4D_bin10_g1_freq6_ws0_thres11.9.nii.gz';
ima_4d_struct = MRIread(path_4d);
ima_4d = ima_4d_struct.vol;
ima_4d = reshape(ima_4d, 109*91*91, 10);

mean_brain = mean(ima_4d, 2);
se_brain = std(ima_4d, 0, 2)/sqrt(10);
stat_brain = mean_brain./se_brain;
stat_brain(isnan(stat_brain))=0;

(mean(stat_brain(idx_result))-cur_thres)/std(stat_brain(idx_result))






%% peak g2 fft bin10 6fold
mask_hpc_path = '/Users/bo/Documents/brainmask/mask_ERC_harddraw_2mm.nii';
mask_hpc_struct = MRIread(mask_hpc_path);
mask_hpc_ima = mask_hpc_struct.vol;
idx_hpc = find(mask_hpc_ima~=1);
cur_thres = 11.2;

mask_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g2_freq6_ws0_clusterm_corrp_tstat1_binary_wr_c10r.nii.gz';
mask_struct = MRIread(mask_path);
mask_ima = mask_struct.vol;
idx = find(mask_ima==1);

t_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/cur_result_bin10_g2_freq6_ws0.nii.gz';
t_struct = MRIread(t_path);
t_ima = t_struct.vol;
t_ima(idx_hpc) = 0;

[fir_di, sec_di, thi_di] = size(t_ima);
max_t = max(t_ima(idx));
max_t-cur_thres
[d1, d2, d3] = ind2sub([fir_di, sec_di, thi_di],find(t_ima==max_t)); % -1 
voxel_array = [d2;d1;d3;2]-1;
t_struct.vox2ras * voxel_array

%% cohen d 
mask_result_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g2_freq6_ws0_clusterm_corrp_tstat1_binary_wr_c10r.nii.gz';
mask_result = MRIread(mask_result_path).vol;
% idx_result = find(mask_result==1);

mask_hpc_struct = MRIread('/Users/bo/Documents/brainmask/mask_ERC_harddraw_2mm.nii');
mask_hpc_ima = mask_hpc_struct.vol;
idx_result = find(mask_result==1);

path_4d = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/o4D_bin10_g2_freq6_ws0_thres11.2.nii.gz';
ima_4d_struct = MRIread(path_4d);
ima_4d = ima_4d_struct.vol;
ima_4d = reshape(ima_4d, 109*91*91, 10);

mean_brain = mean(ima_4d, 2);
se_brain = std(ima_4d, 0, 2)/sqrt(10);
stat_brain = mean_brain./se_brain;
stat_brain(isnan(stat_brain))=0;

(mean(stat_brain(idx_result))-cur_thres)/std(stat_brain(idx_result))




%% peak g3 fft bin10 6fold
mask_hpc_path = '/Users/bo/Documents/brainmask/mask_ERC_harddraw_2mm.nii';
mask_hpc_struct = MRIread(mask_hpc_path);
mask_hpc_ima = mask_hpc_struct.vol;
idx_hpc = find(mask_hpc_ima~=1);
cur_thres = 11.7;

mask_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g3_freq6_ws0_clusterm_corrp_tstat1_binary_wr_c10r.nii.gz';
mask_struct = MRIread(mask_path);
mask_ima = mask_struct.vol;
idx = find(mask_ima==1);

t_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/cur_result_bin10_g3_freq6_ws0.nii.gz';
t_struct = MRIread(t_path);
t_ima = t_struct.vol;
t_ima(idx_hpc) = 0;

[fir_di, sec_di, thi_di] = size(t_ima);
max_t = max(t_ima(idx));
max_t-cur_thres
[d1, d2, d3] = ind2sub([fir_di, sec_di, thi_di],find(t_ima==max_t)); % -1 
voxel_array = [d2;d1;d3;2]-1;
t_struct.vox2ras * voxel_array

%% cohen d 
mask_result_path = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g3_freq6_ws0_clusterm_corrp_tstat1_binary_wr_c10r.nii.gz';
mask_result = MRIread(mask_result_path).vol;
% idx_result = find(mask_result==1);

mask_hpc_struct = MRIread('/Users/bo/Documents/brainmask/mask_HPC_2mm.nii');
mask_hpc_ima = mask_hpc_struct.vol;
idx_result = find(mask_result==1);

path_4d = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/o4D_bin10_g3_freq6_ws0_thres11.7.nii.gz';
ima_4d_struct = MRIread(path_4d);
ima_4d = ima_4d_struct.vol;
ima_4d = reshape(ima_4d, 109*91*91, 13);

mean_brain = mean(ima_4d, 2);
se_brain = std(ima_4d, 0, 2)/sqrt(13);
stat_brain = mean_brain./se_brain;
stat_brain(isnan(stat_brain))=0;

(mean(stat_brain(idx_result))-cur_thres)/std(stat_brain(idx_result))
