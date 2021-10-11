#!/bin/bash

Cnt=$(grep processor /proc/cpuinfo | wc –l) 
Echo "The CPU count is: $cnt" 

