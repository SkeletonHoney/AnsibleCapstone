#!/bin/bash
#while true
#do
# Search for DOS attack
SEARCH=$(python search.py "search HTTP OR SYN earliest_time=-50m | stats count by clientip" \
	| grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' \
	| sed 's/^/Require not ip /')
if [ ! -z "$SEARCH" ]
then
	echo "Search found attacker"
	# Check if result is already contained in blacklist
	QUERY=$(grep -- "$SEARCH" ./playbooks/config/web/blacklist.conf)
	if [ -z "$QUERY" ]
	then
		echo "Adding to blacklist"
		# Add new rule to blacklist.conf and publish
		echo "$SEARCH" >> ./playbooks/config/web/blacklist.conf
		ansible-playbook ./playbooks/update_blacklist.yml
	fi
fi
#done
