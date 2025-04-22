#!/bin/bash
#SBATCH -p test
#SBATCH --exclusive

g++ -O3 -DLIKWID_PERFMON -I${LIKWID_INCLUDE} -L${LIKWID_LIB} -llikwid number_crunching_likwid.cpp -o number_crunching_likwid
likwid-perfctr -C 0 -g MEMORY,FLOPS_DP ./number_crunching_likwid 10000 > number_crunching_likwid.out
