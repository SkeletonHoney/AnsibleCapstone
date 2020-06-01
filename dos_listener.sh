#!/bin/bash
while true
do
	# Search for DOS attack
	SEARCH=$(python search.py "search HTTP OR SYN NOT 403 earliest_time=-15s | stats count by clientip | where count > 50" \
		| grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' \
		| sed 's/^/Require not ip /')
	if [ ! -z "$SEARCH" ]
	then
		# Check if result is already contained in blacklist
		QUERY=$(grep -- "$SEARCH" ./playbooks/config/web/blacklist.conf)
		if [ -z "$QUERY" ]
		then
			# Add new rule to blacklist.conf and publish
			echo "$SEARCH" >> ./playbooks/config/web/blacklist.conf
			ansible-playbook ./playbooks/update_blacklist.yml 1> /dev/null 2> /dev/null
		fi
	fi
	sleep 5 
done
