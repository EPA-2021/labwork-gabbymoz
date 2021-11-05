#!/bin/bash

#################################
## this is a function in bash
## notice it has no parentheses
#################################
start_server() {
  echo "start_server() called..."
  gcloud compute instances create-with-container banking-vm \
    --container-image=eu.gcr.io/epa-flite-2021/unreliablebanking:latest
    --zone europe-west1-c \
    --tags=http-server, https-server
}

teardown_server() {
  echo "teardown_server() called..."
  gcloud compute instances delete instance-1 banking-vm \
    --container-image=eu.gcr.io/epa-flite-2021/unreliablebanking:latest
    --zone europe-west1-c \
    --tags=http-server, https-server 
  echo "server removed"
}

restart_server() {
  echo "restartdown_server() called..."
  gcloud compute instances update-container banking-vm \
    --container-image=eu.gcr.io/epa-flite-2021/unreliablebanking:latest
    --zone europe-west1-c \
    --tags=http-server, https-server
  echo "server restarted"
}

if [ "$1" == "start" ]; then
#################################
## notice we don’t use the 
## parentheses when calling the
## function 
#################################
    start_server

    elif [ "$1" == "teardown" ]; then
        teardown_server

    elif [ "$1" == "restart" ]; then
        restart_server

fi
