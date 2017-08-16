#!/bin/bash

#script to create many files

for i in {1..30}
do 

	cat <<- FIN32 > ManyFiles/file$i.txt

	Hello i am a Here document.
	My name is $i.
	Do you want to read my content
	FIN32

done 

echo "Finished script"
