#!/bin/bash

#script


echo "This will archive and compress in one line"
echo "do it with gzip"

tar -cvzf OneStepGzip.tgz ManyFiles

echo "Now do it with bzip"

tar -cvjf OneStepBzip.tb2 ManyFiles
