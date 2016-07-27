Reference Topology
==================


Usage
-----
    cd onie-vagrant/examples/reference-topology
    vagrant up oob-mgmt-server
    vagrant scp var oob-mgmt-server:.
    vagrant scp etc oob-mgmt-server:.
    vagrant scp onie-installer oob-mgmt-server:./var/www/html/
    vagrant ssh oob-mgmt-server
    sudo apt-get update
    sudo apt-get install -qy apache2 isc-dhcp-server git
    sudo cp ./etc/hosts /etc/hosts
    sudo cp ./etc/dhcp/* /etc/dhcp
    sudo cp ./var/www/html/* /var/www/html
    sudo service isc-dhcp-server restart
    exit
    vagrant up leaf01 leaf02 leaf03 leaf04 spine01 spine02 server01 server02
    vagrant ssh oob-mgmt-server
    sudo su - cumulus
    ping leaf04
    # when you see an interruption and then see the connection recover, that
    # means that it's done. this can take about 25 minutes (around 2000 pings).

From here, you can use any of the published
[cldemos](https://github.com/CumulusNetworks/?utf8=%E2%9C%93&query=cldemo).
Start from the command `sudo su - cumulus`.
