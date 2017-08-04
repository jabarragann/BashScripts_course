#!/bin/bash


#comparing expressions script

echo 0 "Is true"
echo 1 "Is False"
[[ "cat" == "cat" ]]
echo $?


[[ "cat" == "dog" ]]
echo $?


#
#Numeric comparations
#less than -lt
#greater than -gt 
#less than or equal to  -le
#-ge
#equal -eq
#not equal -ne


[[ 20 -lt  100 ]]
echo $?


#show if a string is null     -z 
#show if a string is not null -n

echo "Bash has the following logic operators || && !"


a=""
b="cat"
[[ -z $a && -n $b ]]


echo "[[ -z $a && -n $b ]] is " $?


