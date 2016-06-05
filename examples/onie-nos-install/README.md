onie-nos-install Example
========================
In this example, we'll be spinning up a white box switch running ONIE, copying
our ONIE installer image to the switch, and installing the image manually.

Prerequsites
------------
From the [README](http://github.com/isharacomix/onie-vagrant)

  * Vagrant is installed
  * You have downloaded the Cumulus VX image to the directory with the Vagrantfile
    and named it `onie-installer`


Usage
-----
You will need two terminals.

*Terminal 1*
    vagrant up
    telnet localhost 40011

*Terminal 2*
    vagrant scp onie-installer leaf01:/root/onie-installer
    vagrant ssh leaf01
    onie-nos-install onie-installer


What's happening?
-----------------
When you boot a factory-reset white box switch with ONIE installed, it will
start up in **installer mode**. In this mode, ONIE will automatically try to
find the onie-installer image, download, and run it. Usually, it will learn
where the image is via DHCP options (covered in
[another example](http://github.com/isharacomix/onie-vagrant/tree/master/examples/dhcp-install)).
If you watch the telnet terminal before you copy the onie-installer over,
you'll watch it run DHCP, try a bunch of URLs, and give up. This is called
**discovery**. The discovery process is discussed in detail in the
[official ONIE documentation](https://github.com/opencomputeproject/onie/wiki/Design-Spec-SW-Image-Discovery).

In our example, we are manually putting the ONIE install image on our switch
(for example, via a USB key or downloaded from a webserver) and running the
`onie-nos-install` command. The image will be installed, and when it reboots,
Cumulus Linux will be installed in the default GRUB slot.

To log into Cumulus Linux, the default username is `cumulus` and the password
is `CumulusLinux!`.
