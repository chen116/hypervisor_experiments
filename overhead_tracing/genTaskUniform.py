#!/usr/bin/env python

# **********************************************************************
# This generates task sets with a uniform number of tasks. Used for 
# hypervisor overhead measurements
# 
# TO CHANGE OUTPUT: 
# 	Please change main at bottom of file
# 
# **********************************************************************

import sys
import random
import copy
import pprint

from schedcat.model.serialize import write
from schedcat.generator.tasksets import mkgen, \
																				NAMED_UTILIZATIONS, \
																				NAMED_PERIODS

from schedcat.util.time import ms2us


def generate_taskset_files(util_name, period_name, cap, number):
	generator = mkgen(NAMED_UTILIZATIONS[util_name],
										NAMED_PERIODS[period_name])
	generated_sets = []
	for i in range(number):
			taskset = generator(max_util=cap, squeeze=True, time_conversion=ms2us)
			filename = "{0}_{1}_{2}_{3}".format(util_name,
																					period_name, cap, i)
			tempFile = open(filename,"w")
			for task in taskset:
					tempFile.write(str(task.cost)+" "+str(task.period)+"\n")
			tempFile.close()
			generated_sets.append(filename)
	return generated_sets

def generate_uniform_task_number(util_name, cap, number):
	period_name = "uni-moderate"
	generator = mkgen(NAMED_UTILIZATIONS[util_name],
										NAMED_PERIODS[period_name])
	generated_moderate_sets = []
	generated_long_sets = []
	filenames = []


	for i in range(number):
		genModerateTaskset = generator(max_util=cap, squeeze=True, time_conversion=ms2us)
		long_filename = "{0}_{1}_{2}_{3}".format(util_name,
																	"uni-long", cap, i)
		moderate_filename = "{0}_{1}_{2}_{3}".format(util_name,
																	"uni-moderate", cap, i)
		longTaskset = []
		moderateTaskset = []

		longTempFile = open(long_filename,"w")
		moderateTempFile = open(moderate_filename,"w")
		for moderateTask in genModerateTaskset:
			# Generate corresponding long period task with same utilization
			longTask = copy.deepcopy(moderateTask)
			longTask.period = ms2us(NAMED_PERIODS["uni-long"]())
			longTask.deadline = longTask.period
			longTask.cost = int(longTask.period * moderateTask.utilization())

			# Store tasks
			longTaskset.append(longTask)
			moderateTaskset.append(moderateTask)

			# Write tasks to files
			longTempFile.write(str(longTask.cost)+" "+str(longTask.period)+"\n")
			moderateTempFile.write(str(moderateTask.cost)+" "+str(moderateTask.period)+"\n")

		longTempFile.close()
		moderateTempFile.close()

		filenames.append(long_filename)
		filenames.append(moderate_filename)

		generated_moderate_sets.append(moderateTaskset)
		generated_long_sets.append(longTaskset)

	print >> sys.stderr, "Generated long task sets: "
	print >> sys.stderr, pprint.pformat(generated_long_sets, indent=2)
	print >> sys.stderr, ""
	print >> sys.stderr, "Generated moderate task sets: "
	print >> sys.stderr, pprint.pformat(generated_moderate_sets, indent=2)

	print >> sys.stderr, ""
	print >> sys.stderr, "Generated filenames"
	print >> sys.stderr, filenames


if __name__ == "__main__":
	# print "Hello stdout!"
	# print >> sys.stderr, "Hello stderr"
	generate_uniform_task_number("uni-heavy", 2, 1)
	generate_uniform_task_number("uni-medium", 2, 1)
	generate_uniform_task_number("uni-light", 2, 1)
	generate_uniform_task_number("bimo-medium", 2, 1)









