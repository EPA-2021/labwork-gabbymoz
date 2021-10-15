#!/bin/bash

cnt =`more /proc/cpuinfo |grep”processor”| wc -l`

echo $cnt