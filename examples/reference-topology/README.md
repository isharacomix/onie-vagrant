

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
    # get a coffee while onie installation happens in the background.
    vagrant ssh oob-mgmt-server
    sudo su - cumulus
