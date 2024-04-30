#!/bin/bash

# Set paths
ADNI_DIR="/home/swethalenkala/Documents/ADNI3"
REG_DIR="/home/swethalenkala/Documents/AFFINE_REGISTRATION"
MAT_DIR="/home/swethalenkala/Documents/MAT"
MNI152_PATH="/home/swethalenkala/fsl/data/standard/MNI152_T1_2mm.nii.gz"

# Set FSL path (assuming it's in your PATH, adjust if needed)
FSL_DIR=" /home/swethalenkala/fsl"

# Iterate over files in ADNI_DIR
size=$(ls -1 $ADNI_DIR | wc -l)
index=0

for file in $ADNI_DIR/*; do
    index=$((index+1))

    # Init path variables
    reg_input_file_path="$file"
    filename=$(basename -- "$file")
    reg_output_file_path="$REG_DIR/${filename}"
    mat_out_file_path="$MAT_DIR/${filename%.nii}.mat"

    # Run FLIRT command
    start=$(date +"%T")
    $FSL_DIR/bin/flirt -in $reg_input_file_path -ref $MNI152_PATH -out $reg_output_file_path -omat $mat_out_file_path -dof 12 -interp trilinear
    end=$(date +"%T")

    echo "$index out of $size took $start to $end"
done

