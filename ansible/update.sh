#!/bin/sh

flutter build web
ansible-playbook -i inventory main_update.yml
