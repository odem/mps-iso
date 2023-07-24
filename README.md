The Makefile invokes certain scripts in the 'scripts' folder to generate
iso-images for various platforms which are installing in an unattended manner.

All iso-images are created using a platform-specific generator script.
These generator scripts create bootable iso-images
containing data and postinstall scripts which are copied
from platform-specific config folders into the generated iso images.
Therefore, for each type of iso a subfolder must exist in the folder 'cfg'
containing the relevant data being copied.

These config folders contain a minimal setup for new virtual machines
such that an ssh-connect is possible after the installtion succeeds.
For that purpose, a rsa keypair can be copied into
'cfg/ISOTYPE/ssh/id_rsa(.pub)'. A new keypair is otherwise generated
if no key is present upon build time of that iso.

Additionally a postinstall script is located in
'cfg/ISOTYPE/postinstall/postinstall.bash' and where custom logic is defined.
By default this script copies a custom sshd config into the guest system.
Further, the provided keypair is copied into '/root/.ssh/authorized_keys'
and also into '/root/.ssh/authorized_keys'.
If a valid key was supplied the Nuromedia-repository can be cloned from and
ssh-connects using PublicKeyAuthentication is possible from the outside.

After that the mps repository is cloned and the installer located is invoked.
That installer then handles all other installations.
The installation also includes downloading and building iso-images
public public ressources such as debian.org or microsoft.com.
Unfortunately microsoft does not offer a public download link for iso images.
Hence, the link provided in 'scripts/generate-win10-iso.bash' has to be valid!

It can be created by using an activation url but is only valid for 24 hours.

Activation-Link:
https://www.microsoft.com/de-de/software-download/windows10ISO

After all and if all installing systemd units are invoked successfully,
they remove themselves from systemd.
By doing that, the time consuming installation occurs only once and services
are started correctly on every reboot.
The Makefile allows more configuration options
which can be listed with the help target of the Makefile.

```
make help

make [OPTION=OPTION_VALUE] [TARGET]

   TARGETS
      clean     : Invokes clean on all generate scripts
      clean-all : Removes all generated (iso, images, tmp-files)
      install   : Install prerequisites (qemu-kvm,isolinux,etc.)
      build     : Builds a specified iso
      disk      : Creates qcow-disk for test vm
      start     : Runs the generated iso in a test vm
      stop      : Stops a running test vm
      ssh       : Connects via ssh to the test vm
   OPTIONS
      USERNAME  : Username for installation and ssh connect
      USERPASS  : Initial password set during installation
      QCOWSIZE  : Maximum disk size for test vm
      VMSSHPORT : Local port mapped to test vm ssh port
      TIMEOUTS  : ssh connects until waitphase fails
      ISO_TYPE  : The generated iso type (debian12,win10,win11)
      INCFOLDER : The config folder being used

```
Individual command lines:
```
make ISOTYPE=debian12 build
make ISOTYPE=debian12 QCOWSIZE=32 disk
make ISOTYPE=debian12 start
make ISOTYPE=debian12 ssh
make ISOTYPE=debian12 stop
make ISOTYPE=debian12 clean
```
