
#Brace  expansion

#Create Various Files
touch {apple,banana}

#create five files
touch file_file{1..5}

#create files with a zero padded at the beginning
touch file_{01..20..2}


#Echo the numbers 1 to 5 
echo {1..10}

#Echo alphabet letters
echo {A..Z}

#combining brace expressions.
touch {banana,cherry}_{1..4}{a..b}

