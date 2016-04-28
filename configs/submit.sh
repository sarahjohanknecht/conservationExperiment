#!/usr/bin/bash

for file in $1*.qsub
do
    qsub $file
done 