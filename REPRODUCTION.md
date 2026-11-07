# QCA reproduction snapshot

Source: https://github.com/hktk07/QCA

Snapshot of reproduction code from xmu20:/data/QCA, saved 2026-11-07.

Results with Qwen3-VL-8B-Instruct and 64 selected frames:

| Dataset | Questions | Accuracy |
| --- | ---: | ---: |
| LongVideoBench validation | 1337 | 67.84% |
| Video-MME without subtitles | 2700 | 69.19% |

Feature extraction uses the separate `qca` environment; inference uses `/data/QCA/envs/qwen3`. Paths in scripts reflect the original server and must be adjusted on other systems.

LAVIS requires modifying `lavis/models/blip_models/blip_image_text_matching.py` so the ITM branch returns `(itm_output, image_embeds)`.

Video-MME predictions were recovered from complete inference logs because the original inference script omitted output writes. Check the write/flush logic before future runs. Evaluation must parse JSON with `json.loads`, not `eval`.

Datasets, downloaded weights, environments, caches, features, logs and prediction files are excluded. This is a source snapshot, not a claim that all scripts have been cleaned or all paper settings exactly matched.
