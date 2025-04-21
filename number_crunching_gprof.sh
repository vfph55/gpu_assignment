#!/bin/bash
#SBATCH -p test
#SBATCH --exclusive

module load gcc

g++ -pg -o3 number_crunching number_crunching.cpp

mkdir -p gprof_results
for k in {1..2};
do
    N=$((k * 10000))
    echo "Running for N = $N"
    ./number_crunching $N
    gprof number_crunching gmon.out > gprof_results/gprof_results_k${k}.txt
done
# the largest input data set
cp gprof_results/gprof_results_k10.txt number_crunching_gprof.out

