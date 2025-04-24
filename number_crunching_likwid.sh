#!/bin/bash
#SBATCH -p test
#SBATCH --exclusive

module load likwid

g++ -O3 number_crunching_likwid.cpp -o number_crunching_likwid -llikwid
likwid-perfctr -g MEMORY,FLOPS_DP ./number_crunching_likwid 10000 > number_crunching_likwid.out

