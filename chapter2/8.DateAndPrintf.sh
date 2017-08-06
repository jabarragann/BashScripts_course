
#!/bin/bash


#date and printf script

date

date +"%d-%m-%Y"

date +"%H-%M-%S"

echo "Explore date manual, man date"


#printf 

echo "Now printf"


printf "Name: \t%s\nID:\t%04d\n" "Scott" "12"



echo "example"


today=$(date +"%d-%m-%Y")
time1=$(date +"%H-%M-%S")

# -v option assigns the string to a variable

printf -v d "Current User:\t%s\nDate:\t\t%s @ %s\n" $USER $today $time1
echo "$d"
