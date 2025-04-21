#!/bin/bash
#SBATCH -p test
module load gcc
g++ number_crunching.cpp -o number_crunching
./number_crunching