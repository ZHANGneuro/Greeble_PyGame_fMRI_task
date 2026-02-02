

% modulation index

mypath = '/Users/bo/Documents/data_liujia_lab/manuscript_gridcell3hz/analysis_liuP1_greeble';

timeFile = fopen([mypath, '/MRI_result_sinusoid/mean_orientation_para3_subj_sub1_35_Vector_Mean.txt'],'rt');
table_time = textscan(timeFile,'%s %s %s');
fclose(timeFile);
data_fhpc = zeros(length(table_time{1}), length(table_time));
for ith_col = 2:length(table_time)
    for ith_row = 1:length(table_time{1})
        data_fhpc(ith_row, ith_col) = str2double(table_time{ith_col}{ith_row});
    end
end
data_fhpc(:,3) = data_fhpc(:,3);
% data_fhpc(:,3) = data_fhpc(:,3)*3;
% data_fhpc(:,3) = mod(data_fhpc(:,3), 2*pi);
data_fhpc(:,3) = mod(data_fhpc(:,3), 2*pi/3);

timeFile = fopen([mypath, '/MRI_result_sinusoid/mean_orientation_para6_subj_sub1_35_Vector_Mean.txt'],'rt');
table_time = textscan(timeFile,'%s %s %s');
fclose(timeFile);
data_ferc = zeros(length(table_time{1}), length(table_time));
for ith_col = 2:length(table_time)
    for ith_row = 1:length(table_time{1})
        data_ferc(ith_row, ith_col) = str2double(table_time{ith_col}{ith_row});
    end
end
% data_ferc(:,3) = data_ferc(:,3)*6;
data_ferc(:,3) = data_ferc(:,3);
% data_ferc(:,3) = mod(data_ferc(:,3), 2*pi);
data_ferc(:,3) = mod(data_ferc(:,3), pi/3);


export_table2 = [data_fhpc(:,3), data_ferc(:,3)];

fileID = fopen(['/Users/bo/Documents/data_liujia_lab/manuscript_gridcell3hz/analysis_liuP1_greeble/MRI_result_sinusoid/txt_fig4a.txt'],'w');
for ith = 1:length(export_table2(:,1))
    fprintf(fileID,'%1.4f\t %1.4f\n',export_table2(ith,:));
end
fclose(fileID);

phi_EC = data_ferc(:,3);
phi_HPC = data_fhpc(:,3);
r_obs = circ_corrcc(phi_EC, phi_HPC)

N = 33;
n_perm  = 15000;
minskip = 1; maxskip = N-1;
r_null = zeros(n_perm,1);

for k = 1:n_perm
    s = randi([minskip, maxskip], 1, 1);
    hpc_shift = phi_HPC([ (s+1):N, 1:s ]);
    r_null(k) = circ_corrcc(phi_EC, hpc_shift);
end
p_two_tailed = (sum(abs(r_null) >= abs(r_obs)) + 1) / (n_perm + 1)
