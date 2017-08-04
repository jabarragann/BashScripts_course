#!/bin/bash


#concatenating strings

a="hello "
b="World"

c=$a$b

echo $c

#string length 

echo ${#a}

#substring 

d=${c:4}
echo $d


echo "Get between the third and fith character"
e=${c:3:5}
echo $e

echo "Counting from the end of the string"
echo ${c: -4}

echo ${c: -4:3}

#replacing strings

fruit="apple banana banana cherry"
echo ${fruit/banana/durian}
echo ${fruit//banana/durian}

#replace only if the needed substring is at the beginning of the string 
echo ${fruit/#apple/durian}

#replace only if the needed substring is at the end of the string
echo ${fruit/%cherry/durian}

