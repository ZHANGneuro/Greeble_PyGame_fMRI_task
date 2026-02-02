

%% bin10
mypath = '/Users/bo/Documents/data_liujia_lab/manuscript_gridcell3hz/analysis_liuP1_greeble';

fold1 = 3;
fold2 = 12;

num_bin = 9;

timeFile = fopen([mypath, '/MRI_result_sinusoid/txt_barchart_',num2str(fold1),'_fold_effect_2025.txt'],'rt');
table_time = textscan(timeFile,'%s %s %s');
fclose(timeFile);
data_fhpc = zeros(length(table_time{1}), length(table_time));
for ith_col = 1:length(table_time)
    for ith_row = 1:length(table_time{1})
        data_fhpc(ith_row, ith_col) = str2num(table_time{ith_col}{ith_row});
    end
end
timeFile = fopen([mypath, '/MRI_result_sinusoid/txt_barchart_',num2str(fold2),'_fold_effect_2025.txt'],'rt');
table_time = textscan(timeFile,'%s %s %s');
fclose(timeFile);
data_ferc = zeros(length(table_time{1}), length(table_time));
for ith_col = 1:length(table_time)
    for ith_row = 1:length(table_time{1})
        data_ferc(ith_row, ith_col) = str2num(table_time{ith_col}{ith_row});
    end
end

ith_fre_low = fold1;
ith_fre_high = fold2;

freq_gap = 0.05;
g12_export_txt=[];


value_array = zeros(33, num_bin);
counter = 1;
for ith_sub = [1:28, 30, 32:35]

    fhpc_sub = data_fhpc(find(data_fhpc(:,1)==ith_sub), :);
    ferc_sub = data_ferc(find(data_ferc(:,1)==ith_sub), :);
    fhpc_srate = length(fhpc_sub(:,3));
    ferc_srate = length(ferc_sub(:,3));

    % % 1) 带通到目标折数（建议保留你原来的 FIR 配置）
    fhpc = eegfilt(fhpc_sub(:,3)', fhpc_srate, ith_fre_low-freq_gap, ith_fre_low+freq_gap, fhpc_srate, round(fhpc_srate/3)-1, 0, 'fir1');
    ferc = eegfilt(ferc_sub(:,3)', ferc_srate, ith_fre_high-freq_gap, ith_fre_high+freq_gap, ferc_srate, round(ferc_srate/3)-1, 0, 'fir1');

    % fhpc = fhpc_sub(:,3)';
    % ferc = ferc_sub(:,3)';

    % 2) 希尔伯特：HPC相位，EC振幅
    phi = angle(hilbert(fhpc));     % φ_HPC(t)
    A   = abs(hilbert(ferc));       % A_EC(t)

    % phi = mod(phi, 2*pi)-pi;
    
    % 3) 相位分箱（示例：四箱）
    edges = linspace(-pi, pi, num_bin+1);
    [~,~,bin] = histcounts(phi, edges);
    
    % 4) 逐箱 MI：先平均复数，再取模长
    MI = nan(1,num_bin);
    for b = 1:num_bin
        idx = (bin==b);
        if any(idx)
            % M = mean(A(idx));
            % MI(b) = M;
            M = mean(A(idx) .* exp(1i * phi(idx)));
            MI(b) = abs(M);
            
        end
    end
    
    % 5) 置换：环形平移 A（或 φ），K 次
    K = 5000;
    MI_surr = nan(K,num_bin);
    N = numel(phi);
    for k = 1:K
        s = randi([1, N-1],1);
        Ashift = A([s+1:end, 1:s]);
        % Ashift = A(randperm(length(A)));
        for b = 1:num_bin
            idx = (bin==b);
            if any(idx)
                M = mean(Ashift(idx) .* exp(1i * phi(idx)));
                MI_surr(k,b) = abs(M);
                % M = mean(Ashift(idx));
                % MI_surr(k,b) = M;
            end
        end
    end
    
    % 6) 与置换比较（每个箱得到一个单侧/双侧 p 值）
    g12_export_txt = [g12_export_txt; [MI-mean(MI_surr, 1)]];
    % g12_export_txt = [g12_export_txt; [MI-mean(MI_surr, 1)]./std(MI_surr, 1)];
    % g12_export_txt = [g12_export_txt; MI];

    counter = counter + 1;
end

mean(g12_export_txt, 1)
std(g12_export_txt, 1)/sqrt(33)

% [h,p,ci,stats] = ttest(g12_export_txt(:,2), (g12_export_txt(:,1)+g12_export_txt(:,3))/2);
% p
% 
% [h,p,ci,stats] = ttest(g12_export_txt(:,2));
% p


[h,p,ci,stats] = ttest(g12_export_txt(:,2), (g12_export_txt(:,1)+g12_export_txt(:,2)+g12_export_txt(:,4)+g12_export_txt(:,5))/4);
p

[h,p,ci,stats] = ttest(g12_export_txt(:,5));
p


fid = fopen([mypath, '/MRI_result_sinusoid/coupling_z_records_g123_fold',num2str(fold1), num2str(fold2),'.txt'],'w');
for n = 1:length(g12_export_txt(:,1))
    fprintf(fid,'%f\t %f\t %f\t %f\t %f\t %f\t %f\t %f\t %f\n', g12_export_txt(n,:));
end
fclose(fid);




