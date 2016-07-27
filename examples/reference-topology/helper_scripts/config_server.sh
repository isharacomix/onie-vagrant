#!/bin/bash

#This file is transferred to a Debian/Ubuntu Host and executed to re-map interfaces
#Extra config COULD be added here but I would recommend against that to keep this file standard.
echo "#################################"
echo "  Running Server Post Config"
echo "#################################"
sudo su


#Replace existing network interfaces file
echo -e "auto lo" > /etc/network/interfaces
echo -e "iface lo inet loopback\n\n" >> /etc/network/interfaces

echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{ifindex}=="2", NAME="vagrant", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:31:00:00", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:31:00:01", NAME="eth1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:31:00:02", NAME="eth2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:31:00:03", NAME="eth3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:31:00:04", NAME="eth4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:32:00:00", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:32:00:01", NAME="eth1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:32:00:02", NAME="eth2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:32:00:03", NAME="eth3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:32:00:04", NAME="eth4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:33:00:00", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:33:00:01", NAME="eth1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:33:00:02", NAME="eth2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:33:00:03", NAME="eth3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:33:00:04", NAME="eth4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:34:00:00", NAME="eth0", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:34:00:01", NAME="eth1", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:34:00:02", NAME="eth2", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:34:00:03", NAME="eth3", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \
echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:34:00:04", NAME="eth4", SUBSYSTEMS=="pci"' >> /etc/udev/rules.d/70-persistent-net.rules; \


#Add vagrant interface
echo -e "\n\nauto eth0" >> /etc/network/interfaces
echo -e "iface eth0 inet dhcp\n\n" >> /etc/network/interfaces

useradd cumulus
CUMULUS_HASH=`python -c 'import crypt; print(crypt.crypt("CumulusLinux!", "\$6\$saltsalt\$").replace("/","\\/"))'`
sed "s/cumulus:!/cumulus:$CUMULUS_HASH/" -i /etc/shadow
mkdir /home/cumulus/
sed "s/PasswordAuthentication no/PasswordAuthentication yes/" -i /etc/ssh/sshd_config
chsh -s /bin/bash cumulus

## Convenience code. This is normally done in ZTP.
echo "cumulus ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/10_cumulus
mkdir /home/cumulus/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzH+R+UhjVicUtI0daNUcedYhfvgT1dbZXgY33Ibm4MOo+X84Iwuzirm3QFnYf2O3uyZjNyrA6fj9qFE7Ekul4bD6PCstQupXPwfPMjns2M7tkHsKnLYjNxWNql/rCUxoH2B6nPyztcRCass3lIc2clfXkCY9Jtf7kgC2e/dmchywPV5PrFqtlHgZUnyoPyWBH7OjPLVxYwtCJn96sFkrjaG9QDOeoeiNvcGlk4DJp/g9L4f2AaEq69x8+gBTFUqAFsD8ecO941cM8sa1167rsRPx7SK3270Ji5EUF3lZsgpaiIgMhtIB/7QNTkN9ZjQBazxxlNVN6WthF8okb7OSt" >> /home/cumulus/.ssh/authorized_keys
chmod 700 -R /home/cumulus
chown cumulus:cumulus -R /home/cumulus

# Other stuff
sudo apt-get update -qy
sudo apt-get install lldpd -qy

# Reboot so udev takes effect
reboot

echo "#################################"
echo "   Finished"
echo "#################################"
