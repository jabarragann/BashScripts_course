#!/bin/bash

#script


tar -c -f files.tar ManyFiles

echo "Now compress"

echo "Compres with gzip"
gzip files.tar

tar -c -f files.tar ManyFiles

echo "Bzip2 is better, it have a higher compression rate"
bzip2 files.tar
