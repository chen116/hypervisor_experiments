import sys

infile = str(sys.argv[1])
print infile
do_sch_count = 0
do_sch_time = 0
with open(infile, "r") as ins:
  for line in ins:
    if '2800e(' in line and ' [ 63 ' in line:  # it is 63 because in xen/common/schdule.c i put 99 for tracing which is 63 in hex
      do_sch_count += 1
      do_sch_time += int(line.split()[-2],16)
f = open(str(sys.argv[2]), 'w')
f.write('-total num of scheduling:'+ str(do_sch_count)+'\n')
f.write('-total overhead:'+ str(do_sch_time)+'\n')
print ('\ntotal num of scheduling:'+ str(do_sch_count))
print ('total overhead:'+ str(do_sch_time)+'\n')


f.close()

