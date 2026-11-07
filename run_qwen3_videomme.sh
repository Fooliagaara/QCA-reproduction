#!/usr/bin/env bash
set -euo pipefail

source /home/xmu/anaconda3/etc/profile.d/conda.sh
conda activate /data/QCA/envs/qwen3

unset LD_LIBRARY_PATH
export PYTHONNOUSERSITE=1
export HF_HOME=/data/QCA/cache/huggingface
export HF_HUB_OFFLINE=1
export TRANSFORMERS_OFFLINE=1

OUT=/data/QCA/results/videomme_full
mkdir -p "$OUT" /data/QCA/logs

PIDS=()
for GPU in {0..7}; do
    CUDA_VISIBLE_DEVICES="$GPU" \
    python -u /data/QCA/qwen3-vl/qwen3_videomme.py \
        --model_path /data/QCA/models/Qwen3-VL-8B-Instruct \
        --video_dir /data/QCA/datasets/Video-MME/data \
        --gt_file /data/QCA/datasets/Video-MME/videomme/test_anns.csv \
        --keyframe_path /data/QCA/keyframes/videomme_full \
        --output_dir "$OUT" \
        --output_name "output_name_chunk${GPU}" \
        --num_chunks 8 \
        --chunk_idx "$GPU" \
        > "/data/QCA/logs/qwen3_videomme_chunk${GPU}.log" 2>&1 &
    PIDS+=("$!")
done

STATUS=0
for PID in "${PIDS[@]}"; do
    wait "$PID" || STATUS=1
done

if [ "$STATUS" -ne 0 ]; then
    echo "有分块失败，请检查日志，暂不评分。"
    exit 1
fi

echo "八个分块推理全部结束。"