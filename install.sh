#!/bin/bash
if [[ -d /home/batan/lcmydot/images ]]; then
rm -r /home/batan/lcmydot/images
fi
for X in $(ls /home/batan/lcmydot/*); do
	if [[ -f /home/batan/.$(echo $X|rev|sed 's![/].*$!!g'|rev) ]]; then
		mv /home/batan/.$(echo $X|rev|sed 's![/].*$!!g'|rev) /home/batan/.$(echo $X|rev|sed 's![/].*$!!g'|rev).org
	fi
	cp $X /home/batan/.$(echo $X|rev|sed 's![/].*$!!g'|rev)
done

