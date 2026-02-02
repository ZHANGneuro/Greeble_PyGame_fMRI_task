

%% vector mean fold 6
clear;
mask_b = MRIread('/Users/bo/Documents/brainmask/mask_ERC_harddraw_2mm.nii');
mask_b_ima = mask_b.vol;
mask_b_index = find(mask_b_ima>0);

name_pool = {'periodic_2501_subj_training_6_fieldmap_s'};
sub_pool=[1:28, 30, 32, 33, 34, 35];
output_table = cell(length(name_pool)*length(sub_pool), 3);
output_table_ori = zeros(611, length(sub_pool));
counter = 1;
for ith_type = 1:length(name_pool)
    cur_type = name_pool{ith_type};
    get_para = extractBetween(cur_type, 'training_', '_fieldmap');
    para_int = str2num(get_para{1});
    for ith_sub = 1:length(sub_pool)
        sub = sub_pool(ith_sub);
        angle_xx = zeros(109, 91, 91);
        angle_yy = zeros(109, 91, 91);
        for sess = 1:2:8 %1:2:8 2:2:8
            sin_ima_strct = MRIread(['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/liujia_formal_sub', num2str(sub),'/', cur_type, num2str(sess),'.feat/stats/standard_pe1.nii.gz']);
            cos_ima_strct = MRIread(['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/liujia_formal_sub', num2str(sub),'/', cur_type, num2str(sess),'.feat/stats/standard_pe2.nii.gz']);
            sin_ima = sin_ima_strct.vol;
            cos_ima = cos_ima_strct.vol;
            ori_ima = atan2(sin_ima, cos_ima);
            angle_xx = angle_xx + cos(ori_ima);
            angle_yy = angle_yy + sin(ori_ima);
        end
        mean_ima = atan2(angle_yy, angle_xx);

        angle_list = mean_ima(mask_b_index);
        output_table_ori(:, ith_sub) = angle_list;
        cos_xx = 0;
        sin_yy = 0;
        for ith = 1:length(angle_list)
            cos_xx = cos_xx + cos(angle_list(ith));
            sin_yy = sin_yy + sin(angle_list(ith));
        end
        mean_angle = atan2(sin_yy, cos_xx);
        
        output_table{counter, 1} = cur_type;
        output_table{counter, 2} = sub;
        output_table{counter, 3} = mean_angle/para_int;
        counter = counter + 1;
%         polarhistogram(mean_ima(mask_b_index),100,'BinWidth',0.3);
%         title(['Para', num2str(para_int), ' sub', sub, '.png']);
%         fig = gcf;
%         fig.PaperUnits = 'inches';
%         fig.PaperPosition = [0 0 4 3];
%         print(['/Users/bo/Documents/data_liujia_lab/exp_greeble/MRI_results_desktop/grid_ori_plot_fieldmap_no_cali/hpc_para', num2str(para_int), ' sub', sub, '.png'],'-dpng','-r0')
    end
end

fid = fopen(['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/mean_orientation_para',num2str(para_int),'_subj_sub1_35_Vector_Mean.txt'],'w');
for print_it = 1:length(output_table(:,1))
    fprintf(fid,'%s\t %d\t %1.4f\n', output_table{print_it,:});
end
fclose(fid);





%% vector mean fold 3
clear;
mask_b = MRIread('/Users/bo/Documents/brainmask/mask_HPC_2mm.nii');
mask_b_ima = mask_b.vol;
mask_b_index = find(mask_b_ima>0);

name_pool = {'periodic_2501_subj_training_3_fieldmap_s'};
sub_pool =[1:28, 30, 32, 33, 34, 35];
output_table = cell(length(name_pool)*length(sub_pool), 3);
counter = 1;
for ith_type = 1:length(name_pool)
    cur_type = name_pool{ith_type};
    get_para = extractBetween(cur_type, 'training_', '_fieldmap');
    para_int = str2num(get_para{1});
    for ith_sub = 1:length(sub_pool)
        sub = sub_pool(ith_sub);
        angle_xx = zeros(109, 91, 91);
        angle_yy = zeros(109, 91, 91);
        for sess = 1:2:8 %1:2:8 2:2:8
            sin_ima_strct = MRIread(['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/liujia_formal_sub', num2str(sub),'/', cur_type, num2str(sess),'.feat/stats/standard_pe1.nii.gz']);
            cos_ima_strct = MRIread(['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/liujia_formal_sub', num2str(sub),'/', cur_type, num2str(sess),'.feat/stats/standard_pe2.nii.gz']);
            sin_ima = sin_ima_strct.vol;
            cos_ima = cos_ima_strct.vol;
            ori_ima = atan2(sin_ima, cos_ima);
            angle_xx = angle_xx + cos(ori_ima);
            angle_yy = angle_yy + sin(ori_ima);
        end
        mean_ima = atan2(angle_yy, angle_xx);

        angle_list = mean_ima(mask_b_index);
        cos_xx = 0;
        sin_yy = 0;
        for ith = 1:length(angle_list)
            cos_xx = cos_xx + cos(angle_list(ith));
            sin_yy = sin_yy + sin(angle_list(ith));
        end
        mean_angle = atan2(sin_yy, cos_xx);
        
        output_table{counter, 1} = cur_type;
        output_table{counter, 2} = sub;
        output_table{counter, 3} = mean_angle/para_int;
        counter = counter + 1;
%         polarhistogram(mean_ima(mask_b_index),100,'BinWidth',0.3);
%         title(['Para', num2str(para_int), ' sub', sub, '.png']);
%         fig = gcf;
%         fig.PaperUnits = 'inches';
%         fig.PaperPosition = [0 0 4 3];
%         print(['/Users/bo/Documents/data_liujia_lab/exp_greeble/MRI_results_desktop/grid_ori_plot_fieldmap_no_cali/hpc_para', num2str(para_int), ' sub', sub, '.png'],'-dpng','-r0')
    end
end

fid = fopen(['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_result_sinusoid/mean_orientation_para',num2str(para_int),'_subj_sub1_35_Vector_Mean.txt'],'w');
for print_it = 1:length(output_table(:,1))
    fprintf(fid,'%s\t %d\t %1.4f\n', output_table{print_it,:});
end
fclose(fid);




