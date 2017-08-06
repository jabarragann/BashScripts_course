#!/bin/bash

#Create all the files of the chapter 

names=("IfStatement" "WhileAndUntilLoops" "ForLoops" "Case" "Functions" "Arguments" "Flags" "InputDuringExecution" "EnsuringResponse" "FinalChallenge")

for var in $(seq 10)
do 
	file=$(printf "%02d."${names[(($var-1))]}".sh" $var)

	cat <<-F1N1SH > $file

	#!/bin/bash
	#Script explaining ${names[(($var-1))]}
	
	F1N1SH

	chmod +x $file
done 
