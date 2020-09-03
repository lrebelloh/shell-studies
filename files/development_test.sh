#!/bin/bash

function teste() {
	if [ "$1" = "start" ]; then
		echo $1
	else 
		echo $@
	fi
}
