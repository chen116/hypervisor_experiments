#!/usr/bin/env python

# File: cartsFuncs.py
# Author: Geoffrey Tran gtran@isi.edu

# This file contains useful functions for interfacing with CARTS from Python. 

import xml.etree.ElementTree as ET
import xml
import copy
import subprocess
import os
import pprint
import numpy
import time
import datetime
import json
import sys
import glob
from pprint import pprint
carted = 0
arg_index = 0


INPUTFILE = ""
for arg in sys.argv:
	if(arg=='-carted'):
		carted=1

# from termcolor import colored

CARTS_TEMPLATE_FILE = 'template.xml'
TASKS_FILE_DIR = '../sched_experiments/task_sets_icloud_granular/'

CARTS_INPUT_FILE = './input_carts/'
CARTS_OUTPUT_FILE = './output_carts/'
CARTS_LOCATION = 'Carts.jar'
CARTS_MODEL = "MPR"


if not os.path.exists(TASKS_FILE_DIR):
    os.makedirs(TASKS_FILE_DIR)
if not os.path.exists(CARTS_OUTPUT_FILE):
    os.makedirs(CARTS_OUTPUT_FILE)
if not os.path.exists(CARTS_INPUT_FILE):
    os.makedirs(CARTS_INPUT_FILE)

taskset_files_names=[]
output_files_names=[]


def read_CARTS_Output():
	try: 
		os.remove(CARTS_OUTPUT_FILE+"/cart_stdout")
		os.remove(CARTS_OUTPUT_FILE+"/cart_stderr")
	except:
		print "remove cart_stdout or cart_stderr fail"
	
	if(carted):
		os.chdir(CARTS_OUTPUT_FILE)
		for file in glob.glob("*"+INPUTFILE+"*"):
			output_files_names.append(file)
	schd = {}
	schd['hm']={}
	schd['lm']={}
	schd['mm']={}
	schd['bm']={}
	schd['bl']={}

	for files in output_files_names:
		
		vm_required_cpus_list = []
		tree = ET.parse(files)
		root = tree.getroot()
		VMs = root.findall('component')
		vmParamDict = {}
		for index,item in enumerate(VMs):
			# print colored('Processing %s'%item.attrib['name'],'green')
			VCPU_budgets = []
			VCPU_periods = []
			VCPU_deadlines = []
			VCPU_data = item.find('processed_task')
			for index2,item2 in enumerate(VCPU_data):
				VCPU_budgets.append(item2.attrib['execution_time'])
				VCPU_periods.append(item2.attrib['period'])
				VCPU_deadlines.append(item2.attrib['deadline'])
			# print VCPU_budgets,VCPU_periods,VCPU_deadlines
			vmParamDict[item.attrib["name"]]=[VCPU_budgets,VCPU_periods,VCPU_deadlines]

# vmParamDict in function read_CARTS_Output() gives you each vcpu's 'execution_time' , 'period' , 'deadline'
# now you can operate on vmParamDict with file names to get the information you want
# the code below print out you if each taskset file can satisfy the total task utilization
# for example:
# the output:
# {'bl': {'0.2': [1.0, 25],
#     	}
# }
# tells you that for all 25 bimo-medium light task utilization with total util of 0.2, 1*100% of the tasksets file is able to run with 1VCPU according to CARTS outputfiles

		avg=0
		for i in range(0,len(vmParamDict['vm1'][0])):
			avg+=float(vmParamDict['vm1'][0][i])/float(vmParamDict['vm1'][1][i])
		vm_required_cpus_list.append(avg)
		util_dist = files.split("_")[1]
		period = files.split("_")[2]
		util_rate = (files.split("_")[3])

		util_thres = 4.0

		if("bimo-medium" in util_dist and "long" in period):
			if(util_rate not in schd["bl"]):
				schd["bl"][util_rate]=[]
			if(vm_required_cpus_list[0]>util_thres):
				schd["bl"][util_rate].append(0)
			else:
				schd["bl"][util_rate].append(1)

		if("bimo-medium" in util_dist and "mod" in period):
			if(util_rate not in schd["bm"]):
				schd["bm"][util_rate]=[]
			if(vm_required_cpus_list[0]>util_thres):
				schd["bm"][util_rate].append(0)
			else:
				schd["bm"][util_rate].append(1)
		if("light" in util_dist):
			if(util_rate not in schd["lm"]):
				schd["lm"][util_rate]=[]
			if(vm_required_cpus_list[0]>util_thres):
				schd["lm"][util_rate].append(0)
			else:
				schd["lm"][util_rate].append(1)
		if("uni-medium" in util_dist):
			if(util_rate not in schd["mm"]):
				schd["mm"][util_rate]=[]
			if(vm_required_cpus_list[0]>util_thres):
				schd["mm"][util_rate].append(0)
			else:
				schd["mm"][util_rate].append(1)

		if("heavy" in util_dist):
			if(util_rate not in schd["hm"]):
				schd["hm"][util_rate]=[]
			if(vm_required_cpus_list[0]>util_thres):
				schd["hm"][util_rate].append(0)
			else:
				schd["hm"][util_rate].append(1)


		# print files +': ' +str(vm_required_cpus_list[0])
	for udist in schd:
		for rate in schd[udist]:

			#schd[udist][rate] = float(sum(schd[udist][rate]))/len(schd[udist][rate]) + len(schd[udist][rate])*10
			iter_cnt = len(schd[udist][rate])
			schd_bility = float(sum(schd[udist][rate]))/len(schd[udist][rate]) 
			schd[udist][rate] = []
			schd[udist][rate].append(schd_bility)
			schd[udist][rate].append(iter_cnt)

			# float(sum(schd[udist][rate]))/len(schd[udist][rate]) + len(schd[udist][rate])*10
			
			#print rate
	pprint(schd)


def read_tasksets():

	# {bimo-medium/uni-light/uni-medium/uni-heavy}_{uni-moderate/uni-long}_{0.2-8.4}_{0-24}
	util=[]
	periods=[]

	util = ["bimo-medium","uni-light","uni-medium","uni-heavy"]
	periods = ["uni-moderate"]


	for ui in util:
		for pi in periods:
			util_rate = numpy.linspace(0.2,8.4,42)
			# util_rate = numpy.linspace(8.2,8.2,1)
			for ur in util_rate:
				iteration = numpy.linspace(0,24,25)
				# iteration = numpy.linspace(0,0,1)
				# processing 1 file now
				for it in iteration:
					it = int(it)
					if ur-int(ur)<0.0001:
						ur=int(ur)
					fname = ui+'_'+pi+'_'+str(ur)+'_'+str(it)
					input_taskset_file = fname
					tree = ET.parse(CARTS_TEMPLATE_FILE)
					root = tree.getroot()
					rtDict = {}
					rtDict['vm1'] = []
					component = copy.deepcopy(root[0])
			  		root.append(component)
			  		component.attrib['name'] = 'vm1'
			  		component.tag = 'component'
					with open(TASKS_FILE_DIR+fname,'r') as f:
						for line in f:
							if len(line.split())==2:
								e = line.split()[0]
								p = line.split()[1]
								rtDict['vm1'].append([e,p])
					# print rtDict

					for index,item in enumerate(rtDict['vm1']):


						task = copy.deepcopy(component[0])
						# print task
						component.append(task)
						task.attrib['e'] = str((item[0]))
						task.attrib['p'] = str((item[1]))
						task.attrib['d'] = str((item[1]))
						task.attrib['name'] = 't'+str(index)
						task.tag = "task"
						# Here, delete the first task, as it is the template
					component.remove(component.find('oldTask'))

					# Here, delete the first component, as it is the placeholder
					root.remove(root.find('oldComponent'))



					# Write to file

					tree.write(CARTS_INPUT_FILE+input_taskset_file+".xml")	
					taskset_files_names.append(input_taskset_file+".xml")	

def run_CARTS_all():
	# for the_file in os.listdir(CARTS_OUTPUT_FILE):
	# 	file_path = os.path.join(CARTS_OUTPUT_FILE, the_file)
	# 	os.unlink(file_path)


	# print "start CARTS:"
	# # print taskset_files_names
	cart_stdout = open(CARTS_OUTPUT_FILE+"/cart_stdout", 'w')
	cart_stderr = open(CARTS_OUTPUT_FILE+"/cart_stderr", 'w')


	for xml_file_name in taskset_files_names:
		ts=time.time()
		print datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d %H:%M:%S')+" : "+CARTS_INPUT_FILE+xml_file_name
		if os.path.isfile(CARTS_OUTPUT_FILE+ 'out_'+xml_file_name):
			print CARTS_OUTPUT_FILE+ 'out_'+xml_file_name + " exsists"
		else:
			cart_stderr.write(xml_file_name +'\n')
			cart_stderr.flush()
			subprocess.check_call([
				"java",
				"-jar",
				CARTS_LOCATION,
				CARTS_INPUT_FILE+xml_file_name,
				CARTS_MODEL, 
				CARTS_OUTPUT_FILE+ 'out_'+xml_file_name
				],stderr = cart_stderr, stdout = cart_stdout)
			output_files_names.append(CARTS_OUTPUT_FILE+ 'out_'+xml_file_name);
			try: 
				os.remove("Ak_max.log")
				os.remove("run.log")
			except:
				print "remove Ak_max.log or run.log fail"
	cart_stdout.close()
	cart_stderr.close()
	try: 
		os.remove(CARTS_OUTPUT_FILE+"/cart_stdout")
		os.remove(CARTS_OUTPUT_FILE+"/cart_stderr")
	except:
		print "remove cart_stdout or cart_stderr fail"




if __name__ == "__main__":
	from pprint import pprint
	
	if(carted==0):
		read_tasksets()
		run_CARTS_all()

	else:

		read_CARTS_Output()

