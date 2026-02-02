

%%  load activity
clear;
mypath = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble';
sub_pool = [1:28, 30, 32, 33, 34, 35];

cur_struct = MRIread('/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/brainmask/mask_HPC_2mm.nii');
cur_erc_ima = cur_struct.vol;
mask_index = find(cur_erc_ima==1);


export_table = NaN(1, 4);
counter = 1;
for sub_ith = 1:length(sub_pool)
    cur_sub = sub_pool(sub_ith);
    for sess = 2:2:8
        % access raw table
        mypath_time_record =   [mypath, '/sub', num2str(cur_sub), '_mri_record_subj_vector_mean_testing_para3_1_35_bin10.txt'];
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

        cur_struct = MRIread([mypath, '/liujia_formal_sub', num2str(cur_sub),'/periodic_2501_testing_subj_vector_mean_3_fieldmap_s', num2str(sess), '.feat/stats/standard_pe1.nii.gz']);
        old_ima = cur_struct.vol;

        beta_list = old_ima(mask_index);
        beta_list(find(beta_list==0))=[];

        cos_value_continuous= table_mat(:, 16); 

        temp_matrix = NaN(length(beta_list),36);
        for ith_beta = 1:length(beta_list)
            temp_matrix(ith_beta, :) = beta_list(ith_beta)*cos_value_continuous;
        end

        pred_list = mean(temp_matrix, 1)';
        angle_matrix = table_mat(:,17);

        angle_list = unique(angle_matrix);

        for ith_angle = 1:length(angle_list)
            export_table(counter, 1) = cur_sub;
            export_table(counter, 2) = sess;
            export_table(counter, 3) = angle_list(ith_angle);
            export_table(counter, 4) = mean(pred_list(find(angle_matrix==angle_list(ith_angle))));
            counter = counter + 1;
            ['sub', num2str(cur_sub), '-sess', num2str(sess), '-angle', num2str(angle_list(ith_angle))]
        end
    end
end

export_table2 = NaN(33, 36);
for sub_ith = 1:length(sub_pool)
    cur_sub = sub_pool(sub_ith);
    cur_table = export_table(find(export_table(:,1)==cur_sub),:);

    angle_list = 0:10:350;
    for ith_angle = 1:length(angle_list)
        cur_angle = angle_list(ith_angle);
        cur_idx = find(cur_table(:,3)==cur_angle);
        if isempty(cur_idx)
            export_table2(sub_ith, ith_angle) =  0;
        else
            export_table2(sub_ith, ith_angle) =  mean(cur_table(cur_idx,4));
        end
    end
end



% fft
angle_list = 0:10:350;
sub_pool = [1:28, 30, 32, 33, 34, 35];

export_table2 = NaN(33, 36);
% cur_struct = MRIread('/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/MRI_results_FFT/new_stat_fft_subj_wide_mtl/Corr_bin10_g123_freq3_ws0_clustere_corrp_tstat1_binary_wr_c8r.nii.gz');
cur_struct = MRIread('/Users/bo/Documents/brainmask/mask_HPC_2mm.nii');
cur_erc_ima = cur_struct.vol;
mask_index = find(cur_erc_ima==1);
ith_bin=10;

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

    for ith_pe = 1:length(pe_dir)
        cur_struct = MRIread(pe_dir{ith_pe});
        cur_ima = cur_struct.vol;
        cur_ima(find(cur_ima==0))= NaN;
        mean_cur_brain = mean(cur_ima(find(~isnan(cur_ima))));
        sd_cur_brain = std(cur_ima(find(~isnan(cur_ima))));
        z_cur_ima = (cur_ima-mean_cur_brain)/sd_cur_brain;
        export_table2(ith_sub, ith_pe) = mean(z_cur_ima(mask_index));
    end
end




% load beh
curFile = fopen('/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/fig_main_beh/behavior_waves2025.txt','rt');
table_beh = textscan(curFile,repmat('%s', 1, 36));
fclose(curFile);
% reassign to new cell
table_reassign_beh = NaN(length(table_beh{1}), length(table_beh));
for ith_col = 1:length(table_beh)
    for ith_row = 1:length(table_beh{1})
        table_reassign_beh(ith_row, ith_col) = str2num(table_beh{ith_col}{ith_row});
    end
end




% data_table = export_table2;
ith_fre = 3;
freq_gap = 0.1;

plv_pool = [];
for ith_sub = 1:33
    
    neural_signal = export_table2(ith_sub,:);
    beh_signal = table_reassign_beh(ith_sub,:);
    srate = 36;
    
    neural_signal = eegfilt(neural_signal,srate, ith_fre-freq_gap, ith_fre+freq_gap, srate, round(srate/3)-1, 0, 'fir1');
    beh_signal = eegfilt(beh_signal,srate, ith_fre-freq_gap, ith_fre+freq_gap, srate, round(srate/3)-1, 0, 'fir1');

    phase_neural = angle(hilbert(neural_signal));
    phase_beh = angle(hilbert(beh_signal));
    plv = abs(sum(exp(i*(phase_neural-phase_beh)))/length(neural_signal));
    plv_pool = [plv_pool, plv];
end
mean(plv_pool)
std(plv_pool)

pli_list_shuf = [];
for ith_sub = 1:33
    neural_signal = export_table2(ith_sub,:);
    beh_signal = table_reassign_beh(ith_sub,:);

    numsurrogate=length(neural_signal);
    numpoints=length(neural_signal);
    
    minskip=1;
    maxskip=numpoints-1;
    skip1=ceil(numpoints.*rand(numsurrogate*2,1));
    skip1(find(skip1>maxskip))=[];
    skip1(find(skip1<minskip))=[];
    skip1=skip1(1:numsurrogate,1);
    skip2=ceil(numpoints.*rand(numsurrogate*2,1));
    skip2(find(skip2>maxskip))=[];
    skip2(find(skip2<minskip))=[];
    skip2=skip2(1:numsurrogate,1);
    surrogate_m = zeros(numsurrogate,1);
    for ith=1:numsurrogate
        surrogate_wave1= [neural_signal(skip1(ith):end) neural_signal(1:skip1(ith)-1)];
        % surrogate_wave2= [beh_signal(skip2(ith):end) beh_signal(1:skip2(ith)-1)];
        surrogate_wave1 = eegfilt(surrogate_wave1,srate, ith_fre-freq_gap, ith_fre+freq_gap, srate, round(srate/3)-1, 0, 'fir1');
        beh_signal = eegfilt(beh_signal,srate, ith_fre-freq_gap, ith_fre+freq_gap, srate, round(srate/3)-1, 0, 'fir1');
        phase_neural = angle(hilbert(surrogate_wave1));
        phase_beh = angle(hilbert(beh_signal));
        surrogate_m(ith, 1) = abs(sum(exp(i*(phase_neural-phase_beh)))/length(shuf_neural));
    end
    pli_list_shuf = [pli_list_shuf  mean(surrogate_m)];
end
mean(pli_list_shuf)
std(pli_list_shuf)




[h, p, ci, stats] = ttest(plv_pool, pli_list_shuf);  % 默认配对 t 检验


export_table = [plv_pool', pli_list_shuf'];

fileID = fopen(['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/fig_main_beh/plv_distribution.txt'],'w');
for ith = 1:length(pli_list_shuf)
    fprintf(fileID,'%1.4f\t %1.4f\n', export_table(ith, :));
end
fclose(fileID);













