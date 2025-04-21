#!/bin/bash

# 解释这个代码，删除批注，简化代码，跟gpt比较
# Compile with LIKWID support
g++ -std=c++11 -O3 -DLIKWID_PERFMON -I${LIKWID_INCLUDE} -L${LIKWID_LIB} -llikwid number_crunching_likwid.cpp -o number_crunching_likwid

# Run with LIKWID (N = 10^4)
N=10000
likwid-perfctr -C 0 -g MEM_DP -m ./number_crunching_likwid $N > number_crunching_likwid.out 2>&1

# Alternative: Measure FLOPS_DP instead of MEM_DP
# likwid-perfctr -C 0 -g FLOPS_DP -m ./number_crunching_likwid $N > number_crunching_likwid.out 2>&1