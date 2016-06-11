import os
import sys
import pprint
files = os.listdir(str(sys.argv[1]))
# print files

util = range(1,9)
long_cnt = []
long_time = []
mod_cnt = []
mod_time = []
i=0
targets = ["bimo","heavy","uni-medium","light"]
for target in targets:
	target_f_long=[]
	target_f_mod=[]

	long_cnt.append([])
	long_time.append([])
	mod_cnt.append([])
	mod_time.append([])

	for file in files:
		file = str(sys.argv[1]) +'/'+file
		if target in file and 'long' in file:
			target_f_long.append(file)
		if target in file and 'moderate' in file:
			target_f_mod.append(file)	




	for file in target_f_long:
		print file
		with open(file, "r") as ins:
			for line in ins:
				if 'num' in line:
					long_cnt[i].append(int(line.split(':')[1]))
				if 'overhead' in line:
					long_time[i].append(int(line.split(':')[1]))





	for file in target_f_mod:
		print file
		with open(file, "r") as ins:
			for line in ins:
				if 'num' in line:
					mod_cnt[i].append(int(line.split(':')[1]))
				if 'overhead' in line:
					mod_time[i].append(int(line.split(':')[1]))


	i+=1

events_count = []
for x in range(0,len(targets)):
	events_count.append(long_cnt[x])
	events_count.append(mod_cnt[x])
events_time = []
for x in range(0,len(targets)):
	events_time.append(long_time[x])
	events_time.append(mod_time[x])

print "events count"
for x in events_count:
	print x 
print "events time"
for x in events_time:
	print x 
