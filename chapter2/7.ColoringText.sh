#!/bin/bash


#escape sequences

echo -e '\033[34;42mColor Text\033[0m'


echo -e '\033[1;31;40m I am awesome!! \033[0m'


#Writing an error message 


BoldRed="\033[1;31;40m"
red="\033[31;40m"
none ="\033[0m"


echo -e "\033[1;31;40mERROR: \033[0m\033[31;40m this is an error. \033[0m "

echo -e $BoldRed"Error: "$none$red"this is an error"$none



##Tput styles

echo "Tput Styles"

flashred=$(tput setab 0; tput setaf 1; tput blink)
red=$(tput setab 0; tput setaf 1;)
none=$(tput sgr0)

echo -e $flashRed"ERROR: "$none$red"this is an error"$none

