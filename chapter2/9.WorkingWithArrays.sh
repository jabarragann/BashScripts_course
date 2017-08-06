#!/bin/bash

#working with arrays examples


a=()
b=("apple" "banana" "cherry")
echo ${b[2]}

b[5]="kiwi"
b+=("mango")

echo ${b[@]}

echo ${b[-1]}


#bash dictionary--only in bash 3 or later versions 

declare -A myarray
myarray[color]=blue

myarray["office building"]="HQ west"


echo ${myarray["office building"]} is ${myarray[color]}


