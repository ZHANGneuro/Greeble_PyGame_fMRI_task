


%%
for ith_freq = 3:7
    keyword = 'vector';
    root_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/periodic_2501_testing_',num2str(ith_freq),'_fieldmap_',keyword,'_mean/'];
    mask = MRIread('/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/mask/mask_MTL_bigger_full2.nii'); %mask_nowm_withsubc mask_wholebrain mask_MTL_bigger_full2.nii
    mask = mask.vol;
    % num_sub=[1:35];
    num_sub=[1:28, 30, 32, 33, 34, 35];
    ima_4d = zeros(109, 91, 91, length(num_sub));
    for ith = 1:length(num_sub)
        cur_sub = num_sub(ith);
        image_struct = MRIread([root_path, 'freq',num2str(ith_freq),'_sub',num2str(cur_sub),'.nii']);
        old_ima = image_struct.vol;
        new_ima = old_ima;
        new_ima(:) = 0;
        cur_index = find(mask~=0);
        cur_mean = mean(old_ima(cur_index));
        cur_std = std(old_ima(cur_index));
        % old_ima(cur_index) = (old_ima(cur_index)-cur_mean)/cur_std;
        old_ima(cur_index) = (old_ima(cur_index))/cur_std;
        % old_ima = smooth3(old_ima,"gaussian",7);
        ima_4d(:,:,:, ith) = old_ima;
    end
    image_struct.vol = ima_4d;
    MRIwrite(image_struct, [root_path, ['4d_freq2025.nii']]);

end





erc_r_struct = MRIread('/Users/bo/Documents/brainmask/mask_hpc_fun_sinusoid.nii'); % mask_hpc_fun_fft mask_HPC_2mm mask_hpc_fun_sinusoid
erc_r_ima = erc_r_struct.vol;
mask_index = find(erc_r_ima==1);

%% export txt
root_path_3 = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/periodic_2501_testing_3_fieldmap_vector_mean/';
root_path_4 = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/periodic_2501_testing_4_fieldmap_vector_mean/';
root_path_5 = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/periodic_2501_testing_5_fieldmap_vector_mean/';
root_path_6 = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/periodic_2501_testing_6_fieldmap_vector_mean/';
root_path_7 = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/periodic_2501_testing_7_fieldmap_vector_mean/';
brain_dir_3 = dir(fullfile(root_path_3, '4d_freq2025*'));
brain_dir_3 = strcat(root_path_3,{brain_dir_3.name}');
brain_dir_4 = dir(fullfile(root_path_4, '4d_freq2025*'));
brain_dir_4 = strcat(root_path_4,{brain_dir_4.name}');
brain_dir_5 = dir(fullfile(root_path_5, '4d_freq2025*'));
brain_dir_5 = strcat(root_path_5,{brain_dir_5.name}');
brain_dir_6 = dir(fullfile(root_path_6, '4d_freq2025*'));
brain_dir_6 = strcat(root_path_6,{brain_dir_6.name}');
brain_dir_7 = dir(fullfile(root_path_7, '4d_freq2025*'));
brain_dir_7 = strcat(root_path_7,{brain_dir_7.name}');

imgs_strct_3 = MRIread(brain_dir_3{1});
imgs_strct_4 = MRIread(brain_dir_4{1});
imgs_strct_5 = MRIread(brain_dir_5{1});
imgs_strct_6 = MRIread(brain_dir_6{1});
imgs_strct_7 = MRIread(brain_dir_7{1});
ima_3 = imgs_strct_3.vol;
ima_4 = imgs_strct_4.vol;
ima_5 = imgs_strct_5.vol;
ima_6 = imgs_strct_6.vol;
ima_7 = imgs_strct_7.vol;

size_ima = size(ima_5);
num_sub = size_ima(4);

export_txt = zeros(num_sub, 5);
for ith_sub = 1:num_sub
    cur_3 = ima_3(:,:,:, ith_sub);
    cur_4 = ima_4(:,:,:, ith_sub);
    cur_5 = ima_5(:,:,:, ith_sub);
    cur_6 = ima_6(:,:,:, ith_sub);
    cur_7 = ima_7(:,:,:, ith_sub);
    export_txt(ith_sub, 1) = mean(cur_3(mask_index));
    export_txt(ith_sub, 2) = mean(cur_4(mask_index));
    export_txt(ith_sub, 3) = mean(cur_5(mask_index));
    export_txt(ith_sub, 4) = mean(cur_6(mask_index));
    export_txt(ith_sub, 5) = mean(cur_7(mask_index));
end
mean_vector = mean(export_txt, 1);
std_vector = std(export_txt, [], 1)/sqrt(num_sub);

[ H , P ] = ttest(export_txt, 0, 'Dim', 1, 'Tail','both');

fileID = fopen('/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/bar_3_fold_para34567.txt','w');
for ith = 1:num_sub
    fprintf(fileID,'%1.4f\t %1.4f\t %1.4f\t %1.4f\t %1.4f\n',export_txt(ith,:));
end
fclose(fileID);





