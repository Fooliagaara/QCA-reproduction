#!/usr/bin/env bash
set -euo pipefail

source /home/xmu/anaconda3/etc/profile.d/conda.sh
conda activate qca

unset LD_LIBRARY_PATH
export PYTHONNOUSERSITE=1
export TORCH_HOME=/data/QCA/cache/torch
export HF_HOME=/data/QCA/cache/huggingface
export HF_HUB_OFFLINE=1
export TRANSFORMERS_OFFLINE=1

GPUS=(0 1 2 3 4 5 6 7)
CHUNKS=${#GPUS[@]}
mkdir -p /data/QCA/logs

PIDS=()
for IDX in "${!GPUS[@]}"; do
    CUDA_VISIBLE_DEVICES="${GPUS[$IDX]}" \
    python -u /data/QCA/blip_feature_ITM_score.py \
        --dataset_name LongVideoBench \
        --dataset_path /data/QCA/datasets/LongVideoBench \
        --extract_feature_model blip \
        --output_dir /data/QCA/features/full \
        --device cuda \
        --min_frames 128 \
        --batch_size 4 \
        --num_workers 2 \
        --num_chunks "$CHUNKS" \
        --chunk_id "$IDX" \
        > "/data/QCA/logs/blip_chunk${IDX}.log" 2>&1 &

    PIDS+=("$!")
    echo "启动分块 $IDX，使用 GPU ${GPUS[$IDX]}，PID=$!"
done

STATUS=0
for IDX in "${!PIDS[@]}"; do
    if wait "${PIDS[$IDX]}"; then
        echo "分块 $IDX 完成"
    else
        echo "分块 $IDX 失败，请检查日志"
        STATUS=1
    fi
done

exit "$STATUS"