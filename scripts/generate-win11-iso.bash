#!/bin/bash

# Default config
VOLNAME=Win11
INCFOLDER=cfg/win11
OUTFOLDER=out
ISOFOLDER=iso
ISONAME=${VOLNAME}_22H2_German_x64v2
ISONAME_VIO=virtio-win-0.1.229
OUTNAME=${VOLNAME}-22H2_German_x64_unattend
INFOLDER=$OUTFOLDER/$ISONAME
OUTFILE=$OUTFOLDER/${OUTNAME}
VIRTIOFOLDER=$OUTFOLDER/${ISONAME_VIO}
# Enable link at: https://www.microsoft.com/de-de/software-download/windows11
URL_WIN="https://software.download.prss.microsoft.com/dbazure/Win11_22H2_German_x64v2.iso?t=ca5a0223-497c-4b8a-892f-5187e44c2909&e=1690324830&h=ad4f797eb340cc7b9b922e828dac6aa8b090a79aa5662b3384a77ae8005abaaf"
URL_VIRTIO="https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.229-1/virtio-win-0.1.229.iso"
URL_PYTHON="https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe"
URL_PSTOOLS="https://download.sysinternals.com/files/PSTools.zip"
USERNAME=root
ROOTPASS=root
export DEBIAN_FRONTEND=noninteractive

# Help
usage() {
    echo "Usage: $0 " 1>&2
    echo "      [-a <action>] [-n <isoname>]" 1>&2
    echo "      [-u <username>] [-p <userpass>]" 1>&2
    echo "      [-d <outdir>] [-i <incdir>]" 1>&2
    echo "      " 1>&2
    echo "      Action  : [clean,install,download,generate]" 1>&2
    echo "      Isoname : [isoname in ./iso without extension]" 1>&2
    echo "      Username: [Hostname to connect to (Default: localhost)]" 1>&2
    echo "      Userpass: [User name (Default: root)]" 1>&2
    echo "      Outdir  : [Output folder (Default: ./out)]" 1>&2
    echo "      IncDir  : [Include folder (Default: ./config)]" 1>&2
}

# install
toolinstall(){
    sudo -E apt --yes install rsync unzip isolinux 1>&2 2>/dev/null
}
# clean
clean(){
    sudo umount "$MNTFOLDER" 1>&2 2>/dev/null
    rm -rf "$INFOLDER" "$MNTFOLDER" "$VIRTIOFOLDER"
    sudo rm -rf "$MODFOLDER"
}

# Download
download() {
    mkdir -p "$ISOFOLDER"
    if [ ! -f "$ISOFILE" ] ; then
        wget -O "$ISOFILE" "$URL_WIN"
    fi
    if [ ! -f "$ISOFILE_VIO" ] ; then
        wget -O "$ISOFILE_VIO" "$URL_VIRTIO"
    fi
}
download_tools() {
    mkdir -p "$INCFOLDER/tools"
    if [ ! -f "$INCFOLDER/tools/python-3.11.4-amd64.exe" ] ; then
        wget -O "$INCFOLDER/tools/python-3.11.4-amd64.exe" "$URL_PYTHON"
    fi
    mkdir -p "$INCFOLDER/env"
    if [ ! -f "$INCFOLDER/env/PSTools.zip" ] ; then
        wget -O "$INCFOLDER/env/PSTools.zip" "$URL_PSTOOLS"
    fi
    if [ ! -d "$INCFOLDER/env/PSTools" ] ; then
        unzip "$INCFOLDER/env/PSTools.zip" -d "$INCFOLDER/env/PSTools"
        rm -rf "$INCFOLDER/env/PSTools.zip"
    fi
}

# Mount and extract
copybase(){
    mkdir -p "$MNTFOLDER" "$INFOLDER"
    sudo mount -o loop "$ISOFILE" "$MNTFOLDER"
    rsync -a -H --exclude=TRANS.TBL "$MNTFOLDER"/ "$INFOLDER"
    chmod 755 -R "$INFOLDER"
    sudo umount "$MNTFOLDER"

    sudo mount -o loop "$ISOFILE_VIO" "$MNTFOLDER"
    rsync -a -H --exclude=TRANS.TBL "$MNTFOLDER"/ "$VIRTIOFOLDER"
    chmod 755 -R "$VIRTIOFOLDER"
    sudo umount "$MNTFOLDER"
    sudo rm -rf "$MNTFOLDER"
}

# Ensure ssh key
ensurekey(){
    if [[ ! -f "$INCFOLDER"/ssh/id_rsa.pub ]] ; then
        mkdir -p "$INCFOLDER"/ssh
        ssh-keygen -t rsa -N '' -f "$INCFOLDER"/ssh/id_rsa
    fi
}

# Copy addons
copyaddons(){
    ensurekey
    mkdir -p "$INFOLDER"/postinstall/
    cp -r "$INCFOLDER"/ssh -t "$INFOLDER"/postinstall/
    cp -r "$INCFOLDER"/env -t "$INFOLDER"/postinstall/
    cp -r "$INCFOLDER"/tools -t "$INFOLDER"/postinstall/
    cp -r "$INCFOLDER"/postinstall/*.bat -t "$INFOLDER"/postinstall/
    cp -r "$INCFOLDER"/autounattend.xml "$INFOLDER"/autounattend.xml
    cp -r "$VIRTIOFOLDER" "$INFOLDER"/virtio
}

updateuser() {
    sed "s#<Name>user</Name>#<Name>$USERNAME</Name>#g" \
         -i "$INFOLDER/autounattend.xml"
    sed "s#<Username>user</Username>#<Username>$USERNAME</Username>#g" \
         -i "$INFOLDER/autounattend.xml"
    sed "s#<UserName>user</UserName>#<UserName>$USERNAME</UserName>#g" \
         -i "$INFOLDER/autounattend.xml"
    sed "s#<FullName>user</FullName>#<FullName>$USERNAME</FullName>#g" \
         -i "$INFOLDER/autounattend.xml"
    sed "s#<DisplayName>user</DisplayName>#<DisplayName>$USERNAME</DisplayName>#g" \
         -i "$INFOLDER/autounattend.xml"
    sed "s#<RegisteredOwner>user</RegisteredOwner>#<RegisteredOwner>$USERNAME</RegisteredOwner>#g" \
         -i "$INFOLDER/autounattend.xml"
    sed "s#<Value>user</Value>#<Value>$ROOTPASS</Value>#g" \
         -i "$INFOLDER/autounattend.xml"
    sed "s#C:\\\\Users\\\\user\\\\#C:\\\\Users\\\\$USERNAME\\\\#g" \
         -i "$INFOLDER/postinstall/postinstall.bat"
}

# Generate iso
geniso(){
	mkdir -p "$OUTFOLDER"
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
		-o "$OUTFILE".iso \
		"$INFOLDER"
	#sudo rm -rf $(DATAFOLDER)
}

# Read params
while getopts ":a:u:p:d:i:n:" o; do
    case "${o}" in
        a)
            ACTION=${OPTARG}
            ;;
        u)
            USERNAME=${OPTARG}
            ;;
        p)
            ROOTPASS=${OPTARG}
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
            ;;
    esac
done
shift $((OPTIND-1))

# Dynamic vars
MNTFOLDER=$OUTFOLDER/mnt
MODFOLDER=$OUTFOLDER/irmod
INFOLDER=$OUTFOLDER/$ISONAME
VIRTIOFOLDER=$OUTFOLDER/${ISONAME_VIO}
ISOFILE=$ISOFOLDER/${ISONAME}.iso
ISOFILE_VIO=$ISOFOLDER/${ISONAME_VIO}.iso
OUTFILE=$ISOFOLDER/${OUTNAME}

# Execute action
case "$ACTION" in
    "clean")
        [[ -z "$ISONAME" ]] && echo "No Isoname specified" && usage && exit 1
        clean
        ;;
    "install")
        [[ -z "$ISONAME" ]] && echo "No Isoname specified" && usage && exit 1
        toolinstall
        ;;
    "download")
        [[ -z "$ISONAME" ]] && echo "No Isoname specified" && usage && exit 1
        download
        download_tools
        ;;
    "generate")
        [[ -z "$ISONAME" ]] && echo "No Isoname specified" && usage && exit 1
        clean
        toolinstall
        download
        download_tools
        copybase
        copyaddons
        updateuser
        geniso
        ;;
     *)
        echo "Not a valid target: '$1'"
        ;;
esac
