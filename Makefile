
.PHONY: all

MPS_USER ?=mps
MPS_PASS ?=mps
TESTSIZE ?=32
VMSSHPORT:=5555
SSHKEY:=config/ssh/id_rsa
ISOFOLDER := iso
OUTFOLDER := out
ISONAME:=debian12-amd64-unattend
TESTIMAGE=$(ISOFOLDER)/$(ISONAME).qcow2
PIDFILE:=$(ISOFOLDER)/$(ISONAME).pid

all: | rebuild disk start
rebuild: | clean build
clean: stop
	-sudo rm -rf $(OUTFOLDER)
clean-all: clean
	-rm -rf $(TESTIMAGE) $(ISOFOLDER)

build:
	./generate-iso.bash -u $(MPS_USER) -p $(MPS_USER) -n $(ISONAME)

disk:
	rm -rf $(TESTIMAGE)
	qemu-img create -f qcow2 -o cluster_size=2M $(TESTIMAGE) $(TESTSIZE)G

start:
	export SDL_ALLOW_ALT_TAB_WHILE_GRABBED=0 \
		&& export SDL_MOUSE_FOCUS_CLICKTHROUGH=1 \
		&& export SDL_RENDER_DRIVER=opengl \
		&& export SDL_RENDER_VSYNC=0 \
		&& sudo kvm \
		-enable-kvm  \
		-machine q35,accel=kvm,usb=off,vmport=off,smm=on,dump-guest-core=off \
		-cpu host -smp 8,sockets=2,cores=4,threads=1 -m 8192 \
		-rtc 'base=utc,driftfix=slew' \
		-boot strict=on \
		-parallel none -serial none -k de \
		-device virtio-balloon \
		-device usb-ehci -device usb-tablet \
		-object iothread,id=io0 \
		-pidfile $(PIDFILE) \
		-netdev user,id=mynet0,hostfwd=tcp::"$(VMSSHPORT)"-:22 \
		-device virtio-net-pci,netdev=mynet0 \
		-object rng-random,id=rng0,filename=/dev/urandom \
		-device virtio-rng-pci,rng=rng0 \
		-object iothread,id=io1 \
		-drive if=none,id=disk0,format="qcow2",cache-size=16M,cache=none,file="$(TESTIMAGE)" \
		-device virtio-blk-pci,drive=disk0,scsi=off,iothread=io1 \
		-cdrom $(ISOFOLDER)/$(ISONAME).iso &

stop:
	if [ -f $(PIDFILE) ] ; then \
		sudo kill `sudo cat $(PIDFILE)` ; \
		sudo rm -rf $(PIDFILE) ; \
	fi

exec:
	ssh-keygen -f ~/.ssh/known_hosts -R "[localhost]:$(VMSSHPORT)"
	ssh -i $(SSHKEY) -p $(VMSSHPORT) root@localhost
