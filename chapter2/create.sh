
#!/bin/bash

#script to create a file with especified name a make it executable


touch $1
chmod +x $1

echo "#!/bin/bash" > $1

ls -la
