# Experiment directory structure

Empty runtime directories are preserved with `.gitkeep`. Download or generate their contents on the server; existing ignore rules exclude the data itself.

```text
QCA/
  datasets/LongVideoBench/
  datasets/LongVideoBench_smoke/
  datasets/Video-MME/data/
  datasets/Video-MME/videomme/
  datasets/Video-MME_smoke/
  models/Qwen3-VL-8B-Instruct/
  cache/huggingface/
  cache/torch/
  cache/pip/
  envs/
  features/full/LongVideoBench/blip/features/
  features/full/LongVideoBench/blip/itm/
  features/smoke/LongVideoBench/blip/features/
  features/smoke/LongVideoBench/blip/itm/
  features/videomme_full/Video-MME/blip/features/
  features/videomme_full/Video-MME/blip/itm/
  features/videomme_smoke/Video-MME/blip/features/
  features/videomme_smoke/Video-MME/blip/itm/
  keyframes/full/
  keyframes/smoke/
  keyframes/videomme_full/
  results/qwen3_full/
  results/qwen3_smoke/
  results/videomme_full/
  results/videomme_smoke/
  logs/
  tmp/
```

`datasets`: video and annotations; `models`: inference weights; `cache`: downloaded model/package caches; `envs`: Conda environments; `features`: BLIP features and ITM scores; `keyframes`: selected original frame indices; `results`: predictions; `logs`: runtime logs; `tmp`: temporary files.
