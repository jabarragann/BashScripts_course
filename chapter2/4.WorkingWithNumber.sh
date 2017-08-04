#!/bin/bash


#working with numbers example


d=20

e=$((d+2))

echo $e
((e++))
echo $e
((e--))
echo $e 
echo 
echo 
((e*=3))
echo $e 
((e/=3))
echo $e

echo "floating point numbers" 
g=$(echo 1/3 | bc -l)
echo $g
echo "Finish"

