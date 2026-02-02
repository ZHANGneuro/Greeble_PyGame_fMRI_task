
#!/usr/bin/env bash
set -euo pipefail
export SUBJECTS_DIR=/Applications/freesurfer/7.3.2/subjects

mri_dir=/Users/bo/Desktop/grid_cell_model/raw_meg_data
subjects=("19" "20" "21" "22" "23" "24" "25")            # 想并行几个就写几个
max_jobs=7                      # 同时跑多少个 recon-all

running_jobs=0

for sub in "${subjects[@]}"; do
    t1_file="${mri_dir}/T1_S${sub}.nii.gz"

    if [[ -f "$t1_file" ]]; then
        echo "Found MRI: $t1_file"

        recon-all -subjid "meg_sub${sub}" -i "$t1_file" -all &
        ((running_jobs++))

        if (( running_jobs >= max_jobs )); then
            wait -n        
            ((running_jobs--))
        fi
    else
        echo "MRI file not found for subject $sub: $t1_file"
    fi
done

wait
echo "All recon-all jobs finished."