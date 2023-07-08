#!/bin/bash

VOLNAME=debian12
INCFOLDER=config
OUTFOLDER=out
ISOFOLDER=iso
ISONAME=${VOLNAME}-amd64-netinst
OUTNAME=${VOLNAME}-amd64-unattend
OUTFILE=$OUTFOLDER/${OUTNAME}
URL=https://gemmei.ftp.acc.umu.se/debian-cd/current/amd64/iso-cd/debian-12.0.0-amd64-netinst.iso

NEWUSER=$USER
NEWPASS=$USER
HYBRIDMBR=/usr/lib/ISOLINUX/isohdpfx.bin
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
INFOLDER=$OUTFOLDER/$ISONAME
ISOFILE=$ISOFOLDER/${ISONAME}.iso
OUTFILE=$ISOFOLDER/${OUTNAME}

echo "USER = ${NEWUSER}"
echo "PASS = ${NEWPASS}"
echo "OUT  = ${OUTFOLDER}"
echo "ISO  = ${OUTFILE}"

# install
install(){
    sudo -E apt --yes install rsync syslinux syslinux-utils xorriso isolinux
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
    if [ ! -f "$ISOFILE" ] ; then
        wget -O "$ISOFILE" "$URL"
    fi
}

# Mount and extract
copybase(){
    mkdir -p "$MNTFOLDER" "$INFOLDER"
    sudo mount -o loop "$ISOFILE" "$MNTFOLDER"
    rsync -a -H --exclude=TRANS.TBL "$MNTFOLDER"/ "$INFOLDER"
    chmod 755 -R "$INFOLDER"
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
    cp -r "$INCFOLDER"/postinstall/*.bash -t "$INFOLDER"/postinstall/
    cp -r "$INCFOLDER"/isolinux/* -t "$INFOLDER"/isolinux
    cp -r "$INCFOLDER"/preseed.cfg "$INFOLDER"/preseed.cfg
    sed 's/initrd.gz/initrd.gz file=\/cdrom\/preseed.cfg/' \
        -i "$INFOLDER/isolinux/txt.cfg"
}


# Generate iso
geniso(){
    md5sum "$(find "$INFOLDER" -type f)" > "$INFOLDER"/md5sum.txt
    xorriso -as mkisofs \
      -r \
      -J \
      -V "$VOLNAME" \
      -c isolinux/boot.cat \
      -b isolinux/isolinux.bin \
      -no-emul-boot \
      -boot-info-table \
      -boot-load-size 4 \
      -partition_offset 16 \
      -isohybrid-mbr "$HYBRIDMBR" \
      -o "$OUTFILE".iso \
      "./$INFOLDER"
}
# Update initrd
irmod(){
    sudo rm -fr "$MODFOLDER"/
    sudo mkdir -p "$MODFOLDER"
    BASEDIR=$(realpath "$INFOLDER")
    gzip -d < "$INFOLDER"/install.amd/initrd.gz | sudo cpio -D "$MODFOLDER" \
        --extract --make-directories --no-absolute-filenames
    sudo cp "$INCFOLDER"/preseed.cfg "$MODFOLDER"/preseed.cfg
    sudo chown root:root "$MODFOLDER"/preseed.cfg
    sudo chmod o+w "$INFOLDER"/install.amd/initrd.gz
    cd "$MODFOLDER" || exit 1
    find . | cpio -H newc --create | gzip -9 \
        > "$BASEDIR"/install.amd/initrd.gz
    cd - || exit 1
    sudo chmod o-w "$INFOLDER"/install.amd/initrd.gz
    sudo rm -fr "$MODFOLDER"/
}

clean
install
download
copybase
copyaddons
irmod
geniso
