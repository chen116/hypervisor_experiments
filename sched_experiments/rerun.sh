# parameters: 1. application name 2. util distribution 3. duration (sec) 4. period distribution
./run_bench_Array_granular.sh myapp uni-light 10 uni-moderate && \
./run_bench_Array_granular.sh myapp uni-medium 10 uni-moderate && \
./run_bench_Array_granular.sh myapp uni-heavy 10 uni-moderate && \
./run_bench_Array_granular.sh myapp bimo-medium 10 uni-moderate && \
./run_bench_Array_granular.sh myapp bimo-medium 10 uni-longRTXen && \
./run_ratio.sh myapp && date && echo "all done"
