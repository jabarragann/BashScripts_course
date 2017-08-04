#!/bin/bash

#command substitution tutorial


d=$(pwd)
 
echo $d


echo "Getting the response time of a server"


a=$(ping -c 1 www.google.com | grep 'bytes from' | cut -d = -f 4)

echo "The ping was $a"

