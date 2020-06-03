#!/bin/bash
while true
do
	ansible-playbook playbooks/init_web.yml playbooks/splunk_forwarder_install_web.yml 1>/dev/null 2>/dev/null
	sleep 60
done
