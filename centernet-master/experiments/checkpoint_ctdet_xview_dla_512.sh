#!/bin/bash
if [[ -f log.txt ]]; then
    rm log.txt
fi
# exec &>> log.txt

cd ../src
##
## train
python main.py \
    ctdet \
    --exp_id checkpoint_dla \
    --arch checkpointdla_34 \
    --dataset xview \
    --input_res 512 \
    --batch_size 32 \
    --num_epochs 100 \
    --lr_step 45,60 \
    --gpus 1 \
    --not_cuda_benchmark

#
# test
python \
    test.py ctdet \
    --exp_id checkpoint_dla \
    --dataset xview \
    --input_res 512 \
    --arch checkpointdla_34 \
    --resume \
    --gpus 1

##
## flip test
python test.py \
    ctdet \
    --exp_id checkpoint_dla \
    --dataset xview \
    --input_res 512 \
    --arch checkpointdla_34 \
    --resume \
    --flip_test \
    --gpus 1

##
## multi-scale
## TODO: Add multi-scale eval test
cd -