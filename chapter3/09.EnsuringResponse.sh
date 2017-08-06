
#!/bin/bash
#Script explaining EnsuringResponse



if [[ $# -lt 3 ]]; then 

	cat <<- EOM
	This command requieres three aruments:
	username, userid, and fivorit number.
	EOM

else 
	#the program goes here 
	echo "Username: $1"
	echo "UserID: $2"
	echo "Favorite Number: $3"
fi


read -p "Animal:" a
while [[ -z "$a" ]] 
do 

	read -p "I need an answer" a
done

echo "$a was selected"

echo "Now using regular expressions:"

read -p "What year? [nnnn] " a

while [[ ! $a =~ ^[0-9]{4}$ ]]; do

	read -p "A year is needed [nnnn] " a
done 

echo "Select year: $a" 

