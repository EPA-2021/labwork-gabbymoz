#!/bin/bash

cnt=`ps -ef | wc -l`

if [ "$cnt" -gt "$1" ];
then
  echo "number of processes exceeded"
fi
