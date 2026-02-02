


keyword = 'vector';
ith_freq=7;

export_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/periodic_2501_testing_',num2str(ith_freq),'_fieldmap_',keyword,'_mean/'];

% export_path = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/periodic_2501_testing_',num2str(ith_freq),'_vector/'];

% info_pool = {'01', '02','03', '04','05', '06','07', '08','09', '10','11', '12','13', '14','15', '16','17', '18','19', '20'};
% info_pool = {'21', '22','23', '24','25', '26','27', '28','29', '30','31', '32','33', '34','35'};
info_pool = 1:35;

for ith_sub = 1:length(info_pool)
    cur_sub_str = num2str(info_pool(ith_sub));

    path_s1 = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/liujia_formal_sub',cur_sub_str,'/periodic_2501_testing_subj_',keyword,'_mean_',num2str(ith_freq),'_fieldmap_s2.feat/stats/standard_pe1.nii.gz'];
    path_s2 = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/liujia_formal_sub',cur_sub_str,'/periodic_2501_testing_subj_',keyword,'_mean_',num2str(ith_freq),'_fieldmap_s4.feat/stats/standard_pe1.nii.gz'];
    path_s3 = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/liujia_formal_sub',cur_sub_str,'/periodic_2501_testing_subj_',keyword,'_mean_',num2str(ith_freq),'_fieldmap_s6.feat/stats/standard_pe1.nii.gz'];
    path_s4 = ['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/liujia_formal_sub',cur_sub_str,'/periodic_2501_testing_subj_',keyword,'_mean_',num2str(ith_freq),'_fieldmap_s8.feat/stats/standard_pe1.nii.gz'];

    s1_struct = MRIread(path_s1);
    s2_struct = MRIread(path_s2);
    s3_struct = MRIread(path_s3);
    s4_struct = MRIread(path_s4);
    s1_ima = s1_struct.vol;
    s2_ima = s2_struct.vol;
    s3_ima = s3_struct.vol;
    s4_ima = s4_struct.vol;
    ave_r_brain = (s1_ima + s2_ima + s3_ima +s4_ima)./4;
    temp_struc  = s1_struct;
    temp_struc.vol = ave_r_brain;
    MRIwrite(temp_struc,[export_path, 'freq',num2str(ith_freq),'_sub', cur_sub_str,'.nii']);
    % end
end


