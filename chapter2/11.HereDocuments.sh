#!/bin/bash

#Here documents


cat << EndOfText

this is a 
multiline
text string 
EndOfText


cat <<- EndOfText

	this is a 
multiline
	text string 
EndOfText


