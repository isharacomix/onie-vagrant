To build the onie image:

    sudo apt-get install bison flex build-essential realpath stgit autoconf gperf texinfo libtool ncurses-dev python-dev expat xorriso mtools libtool-bin
    git clone https://github.com/opencomputeproject/onie
    git config --global user.email "ishara@isharacomix.org"
    git config --global user.name "Barry Peddycord III"
    cp $ONIEVAGRANTDIR/build/discover $ONIEDIR/rootconf/default/bin/discover
    ln -s ../init.d/dropbear.sh $ONIEDIR/rootconf/default/etc/rcS.d/S05dropbear.sh
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
    vagrant package --base 6853b0cc-566f-481b-b8d8-a7f0e0f97325 --output onie.box
    vagrant box add onie.box --name onie
    nano ~/.vagrant.d/boxes/onie/0/virtualbox/Vagrantfile

    # include these defaults
        config.ssh.username = "root"
        config.ssh.shell = "sh"
