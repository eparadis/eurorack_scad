#!/bin/sh

OPENSCAD="/Volumes/Aux Disk/Extra/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"

# front view, orthogonal
"$OPENSCAD" --colorscheme "Tomorrow Night" --projection o --viewall --autocenter --camera -1,-1,-1,90,0,0,-1 -o $1_front.png $1.scad
