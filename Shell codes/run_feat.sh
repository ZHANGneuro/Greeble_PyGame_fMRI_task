#!/bin/bash

#/mnt/hgfs/zhang_bo/fmri_script/bash
#/Users/boo/Desktop/fmri_script/bash
fsf_list=(/Users/bo/Documents/script_bash/template_osci2025/fsf_*)

for i in "${fsf_list[@]}"; do
  (
    feat $i
  )&
  if (( $(wc -w <<<$(jobs -p)) % 2 == 0 )); then wait; fi
done






