#!/bin/bash
#SBATCH -p test
#SBATCH --exclusive

module load gcc

#g++ -pg -O3 number_crunching.cpp -o number_crunching
g++ -pg -O2 number_crunching.cpp -o number_crunching

mkdir -p gprof_results
#for k in {4..5};
#do
#    N=$((k * 10000))
#    echo "Running for N = $N"
#    ./number_crunching $N
#    gprof number_crunching gmon.out > gprof_results/gprof_results_k${k}.txt
#done

k=4
N=$((k * 10000))
echo "Running for N = $N"
./number_crunching $N
gprof number_crunching gmon.out > gprof_results/gprof_results_k${k}.txt


# the largest input data set
cp gprof_results/gprof_results_k10.txt number_crunching_gprof.out

