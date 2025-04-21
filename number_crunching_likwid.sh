#!/bin/bash

g++ -O3 -DLIKWID_PERFMON number_crunching_likwid.cpp -o number_crunching_likwid -llikwid

likwid-perfctr -C 0 -g MEMORY,FLOPS_DP ./number_crunching_likwid 10000