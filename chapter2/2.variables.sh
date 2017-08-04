#!/bin/bash

#script using variables

a=hello

declare -i d=23         #integer
declare -r e=456        #read only
declare -l f="LOLcats"  #lolcats
declare -u g="LOLcats"  #LOLCATS


echo $d
echo $e
echo $f
echo $g


#Built in variables

echo $HOME
echo $PWD

echo $MACHTYPE "Machine type MACHTYPE"
echo $HOSTNAME
echo "Bash version: " $BASH_VERSION
echo $SECONDS  "--> SECONDS  return the number of seconds the bash session has run"
echo "The name of the script is: " $0
echo
echo "finish!"

	

