
declare -a Dist=("bimo-medium" "uni-medium" "uni-light" "uni-heavy")
declare -a PDist=("uni-moderate" "uni-long")
declare -a Util=("1" "2" "3" "4" "5" "6" "7" "8")
declare -a Rep=("0")
#declare -a Rep=("0" "1" "2" "3" "4" "5")

for pDist in "${PDist[@]}"
do
	for dist in "${Dist[@]}"
	do
	  for util in "${Util[@]}"
	  do
	    for rep in "${Rep[@]}"
	    do
	    	
ssh root@192.168.122.45 '/usr/bin/screen -S test -p 0 -X stuff "bash ~/hypervisor_experiments/overhead_tracing/run_bench_Array_granular.sh myapp '"$dist"' 10 '"$pDist"' '"$util"' '"$rep"' $(printf \\r)"'

sleep 5
infile="hi"
domU=$1
mkdir -p ./run-data 
rawfile="./run-data/xen_raw"
tracefile="./run-data/""$dist""_""$pDist""_""$util""_""$rep"
rm ${rawfile}
rm ${tracefile}

echo "start recording....."
xentrace -D -e 0x2800e -S 256 -T 10 ${rawfile}
xenalyze --dump-all ${rawfile} > ${tracefile}

#fileee="run-data/""$dist""_uni-moderate""_""$util""_""$rep"
fileee="run-data/python_""$dist""_""$pDist""_""$util""_""$rep"
echo ${fileee}
python sched_overhead_mea.py ${tracefile} ${fileee}
rm ${rawfile}


sleep 10
done
done
done
done
