#!/bin/bash
#JSUB -q aiai
#JSUB -gpgpu 1
#JSUB -e error.%J
#JSUB -o output.%J
#JSUB -n 1
source /apps/software/anaconda3/etc/profile.d/conda.sh
conda activate /apps/data/ai/envs/YOLO
pip install ./env_supply/certifi-2021.10.8-py2.py3-none-any.whl
pip install ./env_supply/future-0.18.2.tar.gz
# pip install ./env_supply/Pillow-9.1.0-cp38-cp38-win_amd64.whl
pip install ./env_supply/thop-0.0.31.post2005241907-py3-none-any.whl
# pip install ./env_supply/numpy-1.22.3-cp38-cp38-win_amd64.whl
python main.py --dir_data ./data --save './pretrained' --resume './pretrained/model_best.pth.tar'
python vggprune.py --dir_data ./data --model './pretrained/model_best.pth.tar' --save './prune'
python main_finetune.py --dir_data ./data --refine './prune/pruned.pth.tar' --save './refine'
python test.py --dir_data ./data --baseline './pretrained/model_best.pth.tar' --pruned './prune/pruned.pth.tar' --finetune './refine/finetune_model_best.pth.tar'