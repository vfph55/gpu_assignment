#!/bin/bash
#SBATCH -p shared

module purge
module load gcc likwid

g++ -O3 -DLIKWID_PERFMON number_crunching_likwid.cpp -o number_crunching_likwid -llikwid

> number_crunching_likwid.out

echo " floating point performance:" >> number_crunching_likwid.out
likwid-perfctr -m -g FLOPS_DP ./number_crunching_likwid 10000 >> number_crunching_likwid.out
#likwid-perfctr -g FLOPS_DP -C 0 -m ./number_crunching_likwid 10000 2>> number_crunching_likwid.out 
echo -e "\n" >> number_crunching_likwid.out

echo " memory performance:" >> number_crunching_likwid.out
#likwid-perfctr -g L3 ./number_crunching_likwid 10000 > l3_bandwidth.out
#likwid-perfctr -g CACHE ./number_crunching_likwid 10000 > cache_hits.out
likwid-perfctr -m -g MEM ./number_crunching_likwid 10000 >> number_crunching_likwid.out
#likwid-perfctr -g MEM -C 0 -m ./number_crunching_likwid 10000 2>> number_crunching_likwid.out 
