
#!/bin/bash

#reading and writing text files


echo "Some Text " > file.txt


echo "Some more text to the end of file.txt" >> file.txt


cat file.txt


#looping a file
i=1

while read f; do 

	echo "Line $i: $f"
	((i++))
done < file.txt
