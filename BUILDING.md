To build the onie image:

    sudo apt-get install bison flex build-essential realpath stgit autoconf gperf texinfo libtool ncurses-dev python-dev expat xorriso mtools libtool-bin
    git clone https://github.com/opencomputeproject/onie
    git config --global user.email "ishara@isharacomix.org"
    git config --global user.name "Barry Peddycord III"
    nano  onie/rootconf/default/bin/discover

# DHCPv4 service discovery
sd_dhcp4()
{
    intf_list=$(net_intf)
    udhcp_args="$(udhcpc_args) -t 2 -T 2 -n"

    udhcp_request_opts=
    for o in 7 43 54 66 67 72 114 125 ; do
        udhcp_request_opts="$udhcp_request_opts -O $o"
    done

    # Initate DHCP request on every interface in the list.  Stop after
    # one works.

    for i in $intf_list ; do
        log_debug_msg "Trying DHCPv4 on interface: $i"
        tmp=$(udhcpc $udhcp_args $udhcp_request_opts -i $i -s /lib/onie/udhcp4_sd) && onie_disco="${onie_disco}${tmp##*ONIE_PARMS:}"
    done

    if [ -n "$onie_disco" ] ; then
        return 0
    fi

    return 1
}

cd onie/build-config
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


vbox.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
vbox.customize ["modifyvm", :id, "--uartmode1", "tcpserver", "11111"]
