dhcp-install Example
====================
In this example, we'll be spinning up a white box switch running ONIE and
attaching its management interface to an out of band management network where
it will be receiving DHCP options and the ONIE installer image.

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
You will need two terminals.

#### Terminal 1
    cd onie-vagrant/examples/onie-nos-install
    vagrant up
    telnet localhost 40011
    # you may need to press enter to wake it up

#### Terminal 2
    cd onie-vagrant/examples/onie-nos-install
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


What's happening?
-----------------
