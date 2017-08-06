
#!/bin/bash
#Script explaining Functions


function numberThings 
{
	i=1
	for f in $@; do 
		echo $i: $f
		((i++))
	done
}

function greet 
{
	echo "Hi there $1"

}


echo "And now, a greeting "
greet Juan

numberThings $(ls)

