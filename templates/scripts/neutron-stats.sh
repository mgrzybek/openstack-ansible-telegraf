#! /usr/bin/env bash

source /root/openrc

# TODO: Public IPs usage
# openstack floating ip list

# TODO: Public IPs usage per tenant
# openstack.tenants.ID.floating_ips.available
# openstack.tenants.ID.floating_ips.used

for tenant in $(openstack project list --format=value|tr ' ' ':') ; do
        tenant_id=$(echo $tenant|awk -F: '{print $1}')
        tenant_name=$(echo $tenant|awk -F: '{print $2}')

	# Network usage rate per tenant
	for net in $(openstack network list --column ID --format value --project $tenant_id) ; do
		openstack ip availability show $net --format=yaml -c network_name -c total_ips -c used_ips | \
			awk '{gsub(": ", "=") ; print}'| \
			tr '\n' ' '| \
			gawk '{print $0,systime()}' | \
			perl -ne '/network_name=(\w+) total_ips=(\d+) used_ips=(\d+)  (\d+)/ ; print("$1.total_ips $2 $4\n$1.used_ips $3 $4\n")' | \
			perl -pe "s/^/openstack.tenants.$tenant_name.networks./"
	done

	# Number of security groups per tenant
	echo -n openstack.tenants.$tenant_name.
	openstack security group list -c Project --format value --project $tenant_id| wc -l | gawk '{print "security-groups.number "$1" "systime()}'
done



