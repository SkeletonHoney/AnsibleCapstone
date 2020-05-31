#!/bin/bash
while true
do
	ansible-playbook playbooks/init_web.yml
	ansible-playbook playbooks/splunk_forwarder_install_web.yml
	sleep 60
done
