
% modulation index

%% without filter
mypath = '/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble';
timeFile = fopen([mypath, '/MRI_results_formal/txt_barchart_3_fold_effect_anathpc_g12_conti_organized_0.txt'],'rt');
table_time = textscan(timeFile,'%s %s %s');
fclose(timeFile);
data_fhpc = zeros(length(table_time{1}), length(table_time));
for ith_col = 1:length(table_time)
    for ith_row = 1:length(table_time{1})
        data_fhpc(ith_row, ith_col) = str2num(table_time{ith_col}{ith_row});
    end
end
timeFile = fopen([mypath, '/MRI_results_formal/txt_barchart_6_fold_effect_anatErc_g12_conti_organized.txt'],'rt');
table_time = textscan(timeFile,'%s %s %s');
fclose(timeFile);
data_ferc = zeros(length(table_time{1}), length(table_time));
for ith_col = 1:length(table_time)
    for ith_row = 1:length(table_time{1})
        data_ferc(ith_row, ith_col) = str2num(table_time{ith_col}{ith_row});
    end
end

ith_fre_low = 3;
ith_fre_high = 6;
freq_gap = 1;
phase_for_plot = [];
list_amplitude = [];
list_phase = [];
surrogate_plot = [];
z_for_plot = [];
shuff_for_plot = [];
sub_id_plot = [];
value_array = zeros(20, 4);
for ith_sub = 1:20
    fhpc_sub = data_fhpc(find(data_fhpc(:,1)==ith_sub), :);
    ferc_sub = data_ferc(find(data_ferc(:,1)==ith_sub), :);
    fhpc_srate = length(fhpc_sub(:,3));
    ferc_srate = length(ferc_sub(:,3));

    fhpc_sub_filt_norm=fhpc_sub(:,3)';
    ferc_sub_filt_norm=ferc_sub(:,3)';

    fhpc_sub_filtered = eegfilt(fhpc_sub(:,3)',fhpc_srate, ith_fre_low-freq_gap, ith_fre_low+freq_gap, fhpc_srate, round(fhpc_srate/3)-1, 0, 'fir1');
    ferc_sub_filtered = eegfilt(ferc_sub(:,3)',ferc_srate, ith_fre_high-freq_gap, ith_fre_high+freq_gap, ferc_srate, round(ferc_srate/3)-1, 0, 'fir1');
    fhpc_sub_filt_norm = fhpc_sub_filtered;
    ferc_sub_filt_norm = ferc_sub_filtered;

    export_txt = [fhpc_sub(:,2) fhpc_sub_filt_norm'  ferc_sub_filt_norm'];
    fid = fopen([mypath, '/fig_MRI_fig_3_results_hpcerc_locking/filtered_sub',num2str(ith_sub), '_filtered.txt'],'w');
    for n = 1:length(export_txt(:,1))
        fprintf(fid,'%d\t   %f\t  %f\n',export_txt(n,:));
    end
    fclose(fid);

    % phase_mod = angle(hilbert(fhpc_sub_filt_norm)).^2;
    % phase_mod = angle(hilbert(fhpc_sub_filt_norm));
    % phase_mod = mod(phase_mod,2*pi);

    cur_signal = hilbert(fhpc_sub_filt_norm);
    imag_s = imag(cur_signal);
    real_s = real(cur_signal);
    phase_mod = atan2(imag_s, real_s);

    amplitude = abs(hilbert(ferc_sub_filt_norm));
    
    list_amplitude = [list_amplitude amplitude];
    list_phase = [list_phase phase_mod];
    % amplitude = (amplitude-mean(amplitude))/std(amplitude);
    
    z_abs = abs(amplitude.*exp(i*phase_mod));
    z_for_plot = [z_for_plot z_abs];

    z = amplitude.*exp(i*phase_mod);
    phase_each = angle(z);
    phase_for_plot = [phase_for_plot phase_each];

    m_raw = mean(z);
    
    numsurrogate=length(z);
    numpoints=fhpc_srate;
    minskip=1;
    maxskip=numpoints-1;
    skip=ceil(numpoints.*rand(numsurrogate*2,1));
    skip(find(skip>maxskip))=[];
    skip(find(skip<minskip))=[];
    skip=skip(1:numsurrogate,1);

    surrogate_m = zeros(numsurrogate,1);
    for ith=1:numsurrogate
        surrogate_amplitude= [amplitude(skip(ith):end) amplitude(1:skip(ith)-1)];
        surrogate_m(ith, 1) = abs(mean(surrogate_amplitude.*exp(i*phase_mod)));
    end


    surrogate_plot = [surrogate_plot;surrogate_m];

    [surrogate_mean,surrogate_std]=normfit(surrogate_m);
    
    m_norm_length=(abs(m_raw)-surrogate_mean)/surrogate_std;
    m_norm_phase=angle(m_raw);
    m_norm=m_norm_length*exp(i*m_norm_phase);

    sub_id_plot = [sub_id_plot repmat(ith_sub, 1, length(z_abs))];

    value_array(ith_sub,1) = mean(z_abs);
    value_array(ith_sub,2) = surrogate_mean;
    value_array(ith_sub,3) = angle(m_raw);
    value_array(ith_sub,4) = abs(m_raw);
end

fid = fopen([mypath, '/fig_MRI_fig_3_results_hpcerc_locking/coupling_z_records_g12_bar.txt'],'w');
for n = 1:length(value_array(:,1))
    fprintf(fid,'%f\t  %f\t  %f\t  %f\n', value_array(n,:));
end
fclose(fid);


g12_export_txt = [sub_id_plot', phase_for_plot',  z_for_plot', list_amplitude', list_phase'];

fid = fopen([mypath, '/fig_MRI_fig_3_results_hpcerc_locking/coupling_z_records_g12.txt'],'w');
for n = 1:length(g12_export_txt(:,1))
    fprintf(fid,'%f\t  %f\t %f\t %f\t %f\n', g12_export_txt(n,:));
end
fclose(fid);



