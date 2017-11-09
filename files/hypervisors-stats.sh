#! /usr/bin/env bash

source /root/openrc

# Usage of the whole compute nodes
openstack hypervisor stats show -f shell --prefix openstack.hypervisors.usage.total.|gawk '{gsub("\"","") ; gsub("="," ") ; print $0,systime()}'

