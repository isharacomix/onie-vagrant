onie-vagrant
============
This is a project for deploying the [Open Networking Install Environment](http://onie.org)
using Vagrant to quickly deploy accurate simulations of data center networks
for educational, testing, and prototyping purposes. The ONIE Vagrant box
simulates a factory-reset white box switch, on which a compatible network
operating system such as [Cumulus Linux](http://cumulusnetworks.com) can be
installed. This Vagrant box is compatible with the ONIE installer image for
[Cumulus VX](https://cumulusnetworks.com/cumulus-vx/)

### Useful Links
 * ONIE base box on Hashicorp: https://atlas.hashicorp.com/isharacomix/boxes/onie
 * Download Cumulus VX: https://cumulusnetworks.com/cumulus-vx/




Contents
========
    onie-vagrant.iso        ISO for installing the base ONIE image
    BUILDING.md             Instructions for building onie-vagrant.iso



Getting an ONIE Installer Image
===============================

## Cumulus VX
Cumulus VX is the free version of Cumulus Linux used for Virtual Machines.
Since VX 3.0.0, Cumulus Networks provides an ONIE installer image that can
be used to install VX on a Virtual Machines running ONIE.

Create an account on the [Cumulus Networks](http://cumulusnetworks.com) and
visit the [Cumulus VX](https://cumulusnetworks.com/cumulus-vx/) download page.
Choose a desired version (starting at 3.0.0) and download the Cumulus VX
binary image.

![](onie-vx.png)
