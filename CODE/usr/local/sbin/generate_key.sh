#!/bin/bash

# Generate key to give to Samantha for more time

time=`date +%s`
file=$(expr $time / 10000)

echo $file

