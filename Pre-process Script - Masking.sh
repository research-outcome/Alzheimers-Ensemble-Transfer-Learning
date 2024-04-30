#!/bin/bash

REG_DIR="/home/swethalenkala/Documents/AFFINE_REGISTRATION"
MNI152_MASK_PATH="/home/swethalenkala/fsl/data/standard/MNI152_T1_2mm_brain_mask.nii.gz"
SKS_MASK_DIR="/home/swethalenkala/Documents/MASK_DIR"

# Get the number of files in REG_DIR
size=$(ls "$REG_DIR" | wc -l)

# Set up FSL environment (assuming FSL is installed)
source /home/swethalenkala/fsl

# Loop through files in REG_DIR
for file in "$REG_DIR"/*
do
    # Get the file name without the path
    filename=$(basename "$file")

    # Set up input and output file paths
    sk_input_file_path="$REG_DIR/$filename"
    sk_output_file_path="$SKS_MASK_DIR/$filename"

    # Run FSL ApplyMask
    fslmaths "$sk_input_file_path" -mas "$MNI152_MASK_PATH" "$sk_output_file_path"

    echo "Processed file: $filename"
done

echo "Processing complete for $size files."
EOF
