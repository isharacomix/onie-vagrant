#! /bin/sh
# CUMULUS-AUTOPROVISIONING

# Set all ports on the device as admin up
for i in `ls /sys/class/net -1 | grep swp`; do  ip link set up $i; done;

# CUMULUS-AUTOPROVISIONING
exit 0
