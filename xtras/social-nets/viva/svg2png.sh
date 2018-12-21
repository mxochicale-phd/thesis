#!/bin/bash
#usage
# sh svg2png.sh filename

ifile=$1
inkscape --export-png $ifile.png $ifile.svg


