#! /usr/bin/env bash

source /root/openrc

# Number of images in the catalog
openstack image list -c ID -f value|wc -l|awk '{print "openstack.images.available "$1,systime()}'

