#!/bin/bash

set -x
set -e

if [ -z "$1" ]
then
  echo 'no arguments. bail'
  exit 1
fi

#this needs to get passed in
SIMULATION_PREFIX=$1

check_state(){
if [ "$?" != "0" ]; then
    echo "ERROR Could not bring up last series of devices, there was an error of some kind!"
    exit 1
fi
}

kvm_ok()
{
    set +xe
    lscpu | grep -i virt &> /dev/null
    if [ $? -gt 0 ]; then
        echo "kvm not ok"
    fi
    lsmod | grep -i kvm &> /dev/null
    if [ $? -gt 0 ]; then
        echo "kvm not ok"
    fi
    set -xe
}

echo "Vagrant version is: $(/usr/bin/vagrant --version)"

echo "Libvirt version is: $(/usr/sbin/libvirtd --version)"

echo "Check that the machine supports virtualization..."
kvm_ok

echo "Checking/Installing Vagrant Plugins..."
VAGRANT_LIBVIRT_INSTALLED="false"
for plugin in `vagrant plugin list`
  do
    if [ "$plugin" = 'vagrant-libvirt' ]
    then
      VAGRANT_LIBVIRT_INSTALLED="true"
    fi
done
if [ "$VAGRANT_LIBVIRT_INSTALLED" = "false" ]
then
  vagrant plugin install vagrant-libvirt
fi

if [ -z "$SIMULATION_PREFIX" ]
then
  echo 'ERROR: The string we use to find simulations to cleanup is blank. exit.'
  exit 1
fi

#clean up libvirt simulations from previous failed runs
echo "Cleaning pre-existing simulations"
vms=$(virsh list --all | grep ".*\ ${SIMULATION_PREFIX}" | awk '{print $2}')

for item in $vms; do
  echo "$item"
    # check if its powered off state
    vm_state=`virsh list --all | grep $item | awk '{print $3}'`
    if [ "$vm_state" = "running" ] ; then
      virsh destroy $item
    fi
    virsh undefine $item
    virsh vol-delete --pool default $item".img"
done
