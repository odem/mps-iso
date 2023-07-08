#!/bin/bash

VOLNAME=win11
INCFOLDER=config
OUTFOLDER=out
ISOFOLDER=iso
ISONAME_VIRTIO=virtio-win-0.1.229
ISONAME_WIN=Win11_22H2_German_x64v2
OUTNAME=$ISONAME_WIN-unattend
OUTFILE=$OUTFOLDER/${OUTNAME}
# Reactivate Link: https://www.microsoft.com/de-de/software-download/windows11
URL_WIN="https://software.download.prss.microsoft.com/dbazure/Win11_22H2_German_x64v2.iso?t=2fde0d75-646a-4281-92bc-1a53a9e133cb&e=1688865220&h=385922d246794af1dd9094192e8491ba7d568e4fc7d4540b6dab77f72ce93baf"
URL_VIRTIO="https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.229-1/virtio-win-0.1.229.iso"

NEWUSER=$USER
NEWPASS=$USER
export DEBIAN_FRONTEND=noninteractive
USER=$(whoami)

usage() {
    echo "Usage: $0 " 1>&2
    echo "      [-u <user>] [-p <password>]" 1>&2
    echo "      [-d <out-dir>] [-i <inc-folder>]" 1>&2
    echo "      [-n <out-name>]" 1>&2
    exit 1
}

while getopts ":u:p:d:i:n:" o; do
    case "${o}" in
        u)
            NEWUSER=${OPTARG}
            ;;
        p)
            NEWPASS=${OPTARG}
            ;;
        d)
            OUTFOLDER=${OPTARG}
            ;;
        i)
            INCFOLDER=${OPTARG}
            ;;
        n)
            OUTNAME=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

MNTFOLDER=$OUTFOLDER/mnt
MODFOLDER=$OUTFOLDER/irmod
INFOLDER=$OUTFOLDER/$ISONAME_WIN
VIRTFOLDER=$OUTFOLDER/$ISONAME_VIRTIO
ISOFILE_WIN=$ISOFOLDER/${ISONAME_WIN}.iso
ISOFILE_VIRTIO=$ISOFOLDER/${ISONAME_VIRTIO}.iso
OUTFILE=$ISOFOLDER/${OUTNAME}

echo "USER = ${NEWUSER}"
echo "PASS = ${NEWPASS}"
echo "OUT  = ${OUTFOLDER}"
echo "ISO  = ${OUTFILE}"

# install
install(){
    sudo -E apt --yes install rsync genisoimage isolinux
}
# clean
clean(){
    sudo umount "$MNTFOLDER"
    rm -rf "$INFOLDER" "$MNTFOLDER"
    sudo rm -rf "$MODFOLDER"
    rm -rf "$OUTFOLDER"
}

# Download
download() {
    mkdir -p "$ISOFOLDER"
    if [ ! -f "$ISOFILE_WIN" ] ; then
        wget -O "$ISOFILE_WIN" "$URL_WIN"
    fi
    if [ ! -f "$ISOFILE_VIRTIO" ] ; then
        wget -O "$ISOFILE_VIRTIO" "$URL_VIRTIO"
    fi
}

# Mount and extract
copybase(){
    # Windows
    mkdir -p "$MNTFOLDER" "$INFOLDER"
    sudo mount -o loop "$ISOFILE_WIN" "$MNTFOLDER"
    rsync -a -H --exclude=TRANS.TBL "$MNTFOLDER"/ "$INFOLDER"
    chmod 755 -R "$INFOLDER"
    sudo umount "$MNTFOLDER"
    sudo rm -rf "$MNTFOLDER"
}
copyvirtio(){
    # Windows
    mkdir -p "$MNTFOLDER" "$VIRTFOLDER"
    sudo mount -o loop "$ISOFILE_VIRTIO" "$MNTFOLDER"
    rsync -a -H --exclude=TRANS.TBL "$MNTFOLDER"/ "$VIRTFOLDER"
    chmod 755 -R "$VIRTFOLDER"
    sudo umount "$MNTFOLDER"
    sudo rm -rf "$MNTFOLDER"
}

# Ensure ssh key
ensurekey(){
    if [[ ! -f "$INCFOLDER"/ssh/id_rsa.pub ]] ; then
        mkdir -p "$INCFOLDER"/ssh
        ssh-keygen -t rsa -N '' -f "$INCFOLDER"/ssh/id_rsa.pub
    fi
}

# Copy addons
copyaddons(){
    ensurekey
    mkdir -p "$INFOLDER"/postinstall/
    cp -r "$INCFOLDER"/ssh -t "$INFOLDER"/postinstall/
    cp -r "$INCFOLDER"/postinstall/* -t "$INFOLDER"/postinstall/
    cp -r "$VIRTFOLDER" "$INFOLDER"/virtio
    cp "$INCFOLDER"/autounattend.xml "$INFOLDER"/autounattend.xml
}

# Generate iso
geniso(){
mkdir -p $ISOFOLDER
mkisofs  -allow-limited-size \
    -V "$VOLNAME" \
    -no-emul-boot \
    -b boot/etfsboot.com \
    -boot-load-seg 0x07C0 \
    -boot-load-size 8 \
    -iso-level 2 \
    -udf \
    -joliet \
    -D \
    -N \
    -relaxed-filenames \
    -o $OUTFILE.iso \
    $INFOLDER
}

clean
install
download
copybase
copyvirtio
copyaddons
geniso
