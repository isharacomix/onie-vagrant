To build the onie image:

    sudo apt-get install bison flex build-essential realpath stgit autoconf gperf texinfo libtool ncurses-dev python-dev expat xorriso mtools libtool-bin
    git clone https://github.com/opencomputeproject/onie
    git config --global user.email "ishara@isharacomix.org"
    git config --global user.name "Barry Peddycord III"
    cp $ONIEVAGRANTDIR/build/discover $ONIEDIR/rootconf/default/bin/discover
    cp $ONIEVAGRANTDIR/build/networking.sh $ONIEDIR/rootconf/default/etc/init.d
    cd $ONIEDIR/build-config
    make MACHINE=kvm_x86_64 all
    # this can take as long as three hours
    # sftp onie/build


IN VIRTUALBOX
 * Create with a SATA controller image for the hard drive
 * Console in, embed, delete cd drive, reset serial console to default
 * Boxify



IN
VBoxManage list vms
vagrant package --base 5c458a2a-51ad-4091-bb40-e892b49fad05 --output onie.box
vagrant box add onie.box --name onie
nano ~/.vagrant.d/boxes/onie/0/virtualbox/Vagrantfile

# include these defaults
    config.ssh.username = "root"
    config.ssh.shell = "sh"
    config.vm.synced_folder ".", "/vagrant", disabled: true


vbox.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
vbox.customize ["modifyvm", :id, "--uartmode1", "tcpserver", "11111"]
