
#!/bin/bash
#Script explaining InputDuringExecution



echo "What is your name?"

read name

echo  What is your password?

read -s pass


read -p "What's is your favorit animal?" animal

echo name: $name, pass: $pass, animal: $animal


select option in "Cat" "Dog" "Bird" "quit"
do 
	
	case $option in 
		Cat) echo "Cats like to sleep.";;
		Dog) echo "Dogs like to play catch.";;
		quit) break ;;
		*) echo "I am no sure what you mean";;
	esac
done
