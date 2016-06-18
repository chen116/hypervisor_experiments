import os
import sys
import pprint
files = os.listdir(str(sys.argv[1]))
# print files

util = range(1,9)
long_cnt = {}
long_time = {}
mod_cnt = {}
mod_time = {}


targets = ["bimo","heavy","uni-medium","light"]

target_f_long=[]
target_f_mod=[]

for target in targets:
	long_cnt[target]=[]
	long_time[target]=[]	
	mod_cnt[target]=[]
	mod_time[target]=[]
	target_f_long=[]
	target_f_mod=[]



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
					long_cnt[target].append(int(line.split(':')[1]))
				if 'overhead' in line:
					long_time[target].append(int(line.split(':')[1]))





	for file in target_f_mod:
		print file
		with open(file, "r") as ins:
			for line in ins:
				if 'num' in line:
					mod_cnt[target].append(int(line.split(':')[1]))
				if 'overhead' in line:
					mod_time[target].append(int(line.split(':')[1]))



print "moderate period total scheduling time:"
for key in mod_time:
	print key + ' with moderate period:'
	print mod_time[key]
print ''
print "long period total scheduling time:"
for key in long_time:
	print key + ' with long period:'
	print long_time[key]
print ''
print "moderate period total scheduling events count:"
for key in mod_cnt:
	print key + ' with moderate period:'
	print mod_cnt[key]
print ''
print "long period total scheduling events count:"
for key in long_cnt:
	print key + ' with long period:'
	print long_cnt[key]
