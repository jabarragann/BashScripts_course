
#!/bin/bash
#Script explaining Case



a=$1

case $a in 
	cat) echo "Feline";;
	dog|puppy) echo "Canine";;
	*) echo "No match"

esac
