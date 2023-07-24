#!/bin/bash

ISOFOLDER=iso
ISONAME=
VMSSHPORT=5555
QCOWSIZE=128
MEMSIZE=4096
export DEBIAN_FRONTEND=noninteractive

usage() {
    echo "Usage: $0 " 1>&2
    echo "      [-a <action>] [-n <isoname>]" 1>&2
    echo "      [-p <sshport>] [-s <disksize>]" 1>&2
    echo "      " 1>&2
    echo "      Action  : [wait,connect]" 1>&2
    echo "      Isoname : [isoname in ./iso without extension]" 1>&2
    echo "      Sshport : [ssh port (Default: 5555)]" 1>&2
    echo "      Disksize: [Size of disk in GB (Default: 128)]" 1>&2
}

while getopts ":a:h:n:p:s:" o; do
    case "${o}" in
        a)
            ACTION=${OPTARG}
            ;;
        n)
            ISONAME=${OPTARG}
            ;;
        p)
            VMSSHPORT=${OPTARG}
            ;;
        s)
            QCOWSIZE=${OPTARG}
            ;;
        h)
            usage && exit 0
            ;;
        *)
            usage && exit 1
            ;;
    esac
done
shift $((OPTIND-1))

QCOWIMAGE="$ISOFOLDER"/"$ISONAME".qcow2
PIDFILE="$ISOFOLDER"/"$ISONAME".pid
DISKOPTIONS="cache-size=16M,cache=none,file=$QCOWIMAGE"
FORWARDS="hostfwd=tcp::$VMSSHPORT-:22"

kvminstall() {
    sudo -E apt --yes install qemu-kvm
}

vmdisk(){
    rm -rf "$QCOWIMAGE"
    qemu-img create -q -f qcow2 -o cluster_size=2M "$QCOWIMAGE" "$QCOWSIZE"G
}

vmstart() {
    sudo kvm \
        -enable-kvm  \
        -machine q35,accel=kvm,usb=off,vmport=off,smm=on,dump-guest-core=off \
        -cpu host -smp 8,sockets=2,cores=4,threads=1 -m $MEMSIZE \
        -rtc 'base=utc,driftfix=slew' \
        -boot strict=on \
        -parallel none -serial none -k de \
        -device virtio-balloon \
        -device usb-ehci -device usb-tablet \
        -object iothread,id=io0 \
        -pidfile "$PIDFILE" \
        -netdev user,id=mynet0,"$FORWARDS" \
        -device virtio-net-pci,netdev=mynet0 \
        -object rng-random,id=rng0,filename=/dev/urandom \
        -device virtio-rng-pci,rng=rng0 \
        -object iothread,id=io1 \
        -drive if=none,id=disk0,format="qcow2"",$DISKOPTIONS" \
        -device virtio-blk-pci,drive=disk0,scsi=off,iothread=io1 \
        -cdrom "$ISOFOLDER"/"$ISONAME".iso &
}
vmstop() {
    if [ -f "$PIDFILE" ] ; then
        PID=$(sudo cat "$PIDFILE")
        sudo kill "$PID"
        sudo rm -rf "$PIDFILE"
    fi
}

case "$ACTION" in
    "start")
        [[ -z "$ISONAME" ]] && echo "No Isoname specified" && usage && exit 1
        vmstart
        ;;
    "stop")
        [[ -z "$ISONAME" ]] && echo "No Isoname specified" && usage && exit 1
        vmstop
        ;;
    "install")
        kvminstall
        ;;
    "disk")
        [[ -z "$ISONAME" ]] && echo "No Isoname specified" && usage && exit 1
        vmdisk
        ;;
     *)
        echo "Not a valid target: '$1'"
        ;;
esac

