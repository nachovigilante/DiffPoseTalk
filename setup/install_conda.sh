#!/usr/bin/env bash

export CONDA_ENV_NAME=diffposetalk
echo $CONDA_ENV_NAME

conda env create -n $CONDA_ENV_NAME -f environment.yml

eval "$(conda shell.bash hook)"
conda activate $CONDA_ENV_NAME