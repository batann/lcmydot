#!/bin/bash
for X in $(ls /home/batan/lcmydot/*); do
	if [[ -f /home/batan/.$X ]]; then
		mv /home/batan/.$X /home/batan/.$X.org
	fi
	cp /home/batan/lcmydot/$X /home/batan/.$X
done

