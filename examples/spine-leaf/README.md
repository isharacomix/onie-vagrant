spine-leaf Example
====================
In this example, we'll be spinning up a white box switch running ONIE and
attaching its management interface to an out of band management network where
it will be receiving DHCP options and the ONIE installer image. This demo should
be completed after you have completed both `onie-nos-install` and `dhcp-install`.

Prerequisites
------------
From the [README](http://github.com/isharacomix/onie-vagrant)

  * Vagrant is installed
  * You have downloaded the Cumulus VX image to the directory with the Vagrantfile
    and named it `onie-installer`
  * You have used `git clone https://github.com/isharacomix/onie-vagrant` to
    download this repository.


Usage
-----
    cd onie-vagrant/examples/dhcp-install
    vagrant up mgmtserver
    vagrant scp var mgmtserver:.
    vagrant scp etc mgmtserver:.
    vagrant scp onie-installer mgmtserver:./var/www/html/
    vagrant ssh mgmtserver
    sudo apt-get update
    sudo apt-get install -qy apache2 isc-dhcp-server
    sudo cp ./etc/network/interfaces /etc/network
    sudo cp ./etc/dhcp/* /etc/dhcp
    sudo cp ./var/www/html/* /var/www/html
    sudo ifup eth1
    sudo service isc-dhcp-server restart
    exit
    vagrant up leaf01 leaf02 spine01 spine02


What's happening?
-----------------
In this demo, we are bringing up four switches simultaneously. We wait to start
the switches until after we have configured our management server. You'll notice
changes in the Vagrantfile and preseed file.

    device.vm.network "private_network", virtualbox__intnet: "oobnet", auto_config: false , :mac => "443839210000"
    device.vm.network "private_network", virtualbox__intnet: "intnet_1", auto_config: false , :mac => "443839210001"
    device.vm.network "private_network", virtualbox__intnet: "intnet_3", auto_config: false , :mac => "443839210002"

Here you will notice that we are creating some new virtual networks. In order
to simulate connecting two devices, we create a private network that contains
two interfaces.

        +------------+       +------------+
        | spine01    |       | spine02    |
        |            |       |            |
        +------------+       +------------+
        swp1 |    swp2 \   / swp1    | swp2
             |          \ /          |
     INTNET1 |           X           | INTNET4
             | INTNET2  / \  INTNET3 |
       swp51 |   swp52 /   \ swp51   | swp52
        +------------+       +------------+
        | leaf01     |       | leaf02     |
        |            |       |            |
        +------------+       +------------+

In order to simplify our lives, we make up mac addresses that correspond to our
devices.

    44:38:39:21:00:01  = swp1 on spine01
     \__\__\___________ reserved range for Cumulus Networks
              \________ 21 = spine01 (22 = spine02, 11 = leaf01)
                    \__ 01 = swp1

If you look at the preseed file, you'll see the following entries:

    echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:11:00:51", NAME="swp51", SUBSYSTEMS=="pci"' >> /target/etc/udev/rules.d/70-persistent-net.rules; \
    echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:11:00:52", NAME="swp52", SUBSYSTEMS=="pci"' >> /target/etc/udev/rules.d/70-persistent-net.rules; \
    echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:12:00:51", NAME="swp51", SUBSYSTEMS=="pci"' >> /target/etc/udev/rules.d/70-persistent-net.rules; \
    echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:12:00:52", NAME="swp52", SUBSYSTEMS=="pci"' >> /target/etc/udev/rules.d/70-persistent-net.rules; \
    echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:21:00:01", NAME="swp1", SUBSYSTEMS=="pci"' >> /target/etc/udev/rules.d/70-persistent-net.rules; \
    echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:22:00:02", NAME="swp2", SUBSYSTEMS=="pci"' >> /target/etc/udev/rules.d/70-persistent-net.rules; \
    echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:21:00:01", NAME="swp1", SUBSYSTEMS=="pci"' >> /target/etc/udev/rules.d/70-persistent-net.rules; \
    echo 'ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="44:38:39:22:00:02", NAME="swp2", SUBSYSTEMS=="pci"' >> /target/etc/udev/rules.d/70-persistent-net.rules; \

We create udev rules for all of the front panel ports so that when the device
is booted, ethernet devices will be renamed to swp devices based on the mac
addresses. You'll notice that the udev rules for all devices are added to
every switch - this is not a problem since only the rules that match will
be applied.

Obviously these steps are not required on real hardware since the switch knows
about its front panel ports. In general, we never recommend using a preseed file
for configuration, since anything worth doing in preseed would be better done
in a zero touch provisioning script.

When it comes to making virtual topologies of any meaningful complexity, it
becomes necessary to automatically generate the Vagrantfile and preseed file
to avoid making mistakes in building the topology. 
