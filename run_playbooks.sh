#!/bin/bash
ansible-playbook playbooks/init_bastion.yml
ansible-playbook playbooks/init_web.yml
ansible-playbook playbooks/init_db.yml
ansible-playbook playbooks/splunk_forwarder_install_bastion.yml
ansible-playbook playbooks/splunk_forwarder_install_web.yml
ansible-playbook playbooks/splunk_forwarder_install_db.yml
