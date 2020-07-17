#!/bin/sh

# original first
gm compare -metric rmse $1.png $2.png | tail -n 1 | awk '{print $3}'
