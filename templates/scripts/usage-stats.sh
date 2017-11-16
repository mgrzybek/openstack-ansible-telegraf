#! /usr/bin/env bash

source /root/openrc

# Get general usage stats (4 weeks by default)
openstack usage list --format csv | \
	fgrep -v Project | \
	gawk -F, '{gsub("\"","") ; print "openstack.tenants."$1".usage.instances "$2,systime()"\nopenstack.tenants."$1".usage.ram-mb-hours "$3,systime()"\nopenstack.tenants."$1".usage.cpu-hours "$4,systime()"\nopenstack.tenants."$1".usage.disks-gb-hours "$5,systime()}'
