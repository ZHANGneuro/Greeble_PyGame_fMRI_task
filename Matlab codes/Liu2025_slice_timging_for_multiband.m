


%
dicome_header = dicominfo(['/Users/bo/Desktop/' ...
    'MRI_examplar_image/bold/sms_bold_run1-00001.dcm']);


slice_timging = dicome_header.Private_0019_1029;
slice_timging = slice_timging * 0.001;
slice_timging = slice_timging/2;

%
dicome_header = dicominfo(['/Users/bo/Documents/data_liujia_lab/analysis_liuP1_greeble/Raw_MRI_backup/LJZB22/SMS_BOLD_RUN2/OMT-MENG_FAN_JIE_022.MR.THU_LIUJIA.0007.0010.2024.12.03.10.50.26.73200.736253239.IMA']);


slice_timging = dicome_header.Private_0019_1029;
slice_timging = slice_timging * 0.001;
slice_timging = slice_timging/2;
slice_timging = slice_timging-0.5;


slice_timging = (slice_timging-min(slice_timging))/(max(slice_timging)-min(slice_timging))


