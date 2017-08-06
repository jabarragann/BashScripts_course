
#!/bin/bash
#Script explaining ForLoops



for i in 1 2 3
do 
	echo $i
done



for i in {1..20}
do 
	echo -n "$i "

done

echo 


for (( i=1; i<=10; i++  ))
do 
	echo -n  $i
done
echo

arr1=("apple" "banana" "cherry")

for i in ${arr[@]}
do 
	echo $i
done

printf "\n\n\n"

declare -A arr2
arr2["name"]="Scott"
arr2["id"]="1234"

for i in "${!arr2[@]}"
do
	echo "$i: ${arr2[$i]}"
done

echo "For loops and command substituttion"

for i in $(ls)
do 
	echo "$i"
done
