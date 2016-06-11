#/bin/bash

RTSPIN="/root/liblitmus/rtspin"
BASE_TASK="/root/liblitmus/mytools/myapp"
RELEASETS="/root/liblitmus/release_ts"
ST_TRACE="/root/ft_tools/st_trace"
RTLAUNCH="/root/liblitmus/rt_launch"
SPIN_PIDS=""
#RAW_DATA="/root/task_sets_raw/"
RAW_DATA="/root/task_sets_raw/"
NEW_DATA="/root/hpec_2016/tracing/task_sets_hyper_ovm"
#NEW_DATA="/root/experiment-scripts/task_sets_VaryUtil/"
#NEW_DATA="/root/experiment-scripts/task_sets_VaryUtil/"
#PDist="uni-long"
#PDist="uni-moderate"
#PDist="uni-short"
PROG=$1
Dist=$2
Duration=$3
PDist=$4
util=$5
rep=$6
declare -a NEW_SPIN_PIDS

#Util=`echo $Dist | cut -d'_' -f 2`
#Rep=`echo $Dist | cut -d'_' -f 3`
#SchedNames="GSN-EDF
#C-EDF"
SchedNames="GSN-EDF"

for sched in $SchedNames
do
  # for util in 0.4 1 1.4 2 2.4 3 3.4 4


echo "Starting st_trace"
${ST_TRACE} -s mk &
ST_TRACE_PID="$!"
echo "st_trace pid: ${ST_TRACE_PID}"
sleep 1

echo "Switching to $sched plugin"
echo "$sched" > /proc/litmus/active_plugin
sleep 1

#read wcet and period from the dist file
filename="$NEW_DATA""/""$Dist""_""$PDist""_""$util""_""$rep"
data=$(cat $filename)
num_tasks=$(cat $filename | wc -l)
#echo $data
#echo $num_tasks
c=0
n=0
for task in ${data[@]};
do
  let "rem= $c % 2"
  if [ "$rem" -eq 0 ]
  then
    #wcet[$n]=$task
    wcet[$n]=$(echo "scale=3; $task * 0.001" | bc)
  else
    #period[$n]=$task
    period[$n]=$(echo "scale=3; $task * 0.001" | bc)
    n=`expr $n + 1`
  fi
  c=`expr $c + 1`
done

echo "Setting up rtspin processes"
for nt in `seq 1 $num_tasks`;
do
  #$PROG ${wcet[`expr $nt - 1`]} ${period[`expr $nt - 1`]} $Duration -w &
  $BASE_TASK ${wcet[`expr $nt - 1`]} ${period[`expr $nt - 1`]} $Duration &
  #$RTSPIN ${wcet[`expr $nt - 1`]} ${period[`expr $nt - 1`]} $Duration &
  #numactl --physcpubind=8-15 --membind=0 --cpunodebind=0 $PROG ${wcet[`expr $nt - 1`]} ${period[`expr $nt - 1`]} $Duration -w &
  #numactl --physcpubind=8-15 $PROG ${wcet[`expr $nt - 1`]} ${period[`expr $nt - 1`]} $Duration -w &
  SPIN_PIDS="$SPIN_PIDS $!"
  NEW_SPIN_PIDS[`expr $nt - 1`]="$!"
done
sleep 1

#echo "catting log"
#cat /dev/litmus/log > log.txt &
#LOG_PID="$!"
#sleep 1
echo "Doing release..."
$RELEASETS

echo "Waiting for rtspin processes..."
# wait ${SPIN_PIDS}

for i in "${NEW_SPIN_PIDS[@]}"
do
  wait $i
done
unset NEW_SPIN_PIDS

echo "Done wait, sleeping"
sleep 1
echo "Killing log"
kill ${LOG_PID}
sleep 1
echo "Sending SIGUSR1 to st_trace"
kill -USR1 ${ST_TRACE_PID}
echo "Waiting for st_trace..."
wait ${ST_TRACE_PID}
sleep 1

rm /dev/shm/*.bin 
#mv log.txt run-data/"$sched"_$rep/
sleep 1
echo "Done! Collect your logs."


done
echo "DONE!"

 
