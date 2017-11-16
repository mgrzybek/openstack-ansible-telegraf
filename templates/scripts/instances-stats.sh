#! /usr/bin/env bash

source /root/openrc

# Number of instances per tenant
for tenant in $(openstack project list --format=value|tr ' ' ':') ; do
	tenant_id=$(echo $tenant|awk -F: '{print $1}')
	tenant_name=$(echo $tenant|awk -F: '{print $2}')

	instances=$(openstack server list --project $tenant_id --format value -c ID|wc -l)
	echo "openstack.tenants.$tenant_name.instances $instances" | gawk '{print $0" "systime()}'
done

