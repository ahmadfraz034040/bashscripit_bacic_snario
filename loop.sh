#!/bin/bash

files="file1.doc file2.doc file3.doc"

for file in $files
do 
        touch $file
done
  echo "file created succssfully"
