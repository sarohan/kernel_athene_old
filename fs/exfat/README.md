exfat-nofuse
============

<<<<<<< HEAD
Linux non-fuse read/write kernel driver for the exFAT, FAT12, FAT16 and vfat (FAT32) file systems.<br />
Originally ported from Android kernel v3.0.
=======
Linux non-fuse read/write kernel driver for the exFAT file system.<br />
Originally ported from android kernel v3.0.

>>>>>>> fc156d9... exFAT support

Kudos to ksv1986 for the mutex patch!<br />
Thanks to JackNorris for being awesome and providing the clear_inode() patch.<br />
<br />
<<<<<<< HEAD
Big thanks to lqs for completing the driver!<br />
=======
Big thanks to lqs for completing the driver!
>>>>>>> fc156d9... exFAT support
Big thanks to benpicco for fixing 3.11.y compatibility!


Special thanks to github user AndreiLux for spreading the word about the leak!<br />


<<<<<<< HEAD
Installing as a stand-alone module:
====================================

    make
    sudo make install
=======
Installation as stand alone module:
====================================

    make -f Makefile.module KDIR="path to kernel source" CROSS_COMPILE="path to android chain tools (as linaro)/bin/SOMETHING- (see your folder for clues)"

Example how it's works for me!

    make -f Makefile.module CROSS_COMPILE=../dorimanx-SG2-I9100-Kernel/android-toolchain/bin/arm-eabi- KDIR=../dorimanx-SG2-I9100-Kernel/

exfat.ko module file will be created in exfat source folder. and will work with kernel source you have used.

    make -f Makefile.module install
>>>>>>> fc156d9... exFAT support

To load the driver manually, run this as root:

    modprobe exfat

<<<<<<< HEAD
You may also specify custom toolchains by using CROSS_COMPILE flag, in my case:
>CROSS_COMPILE=../dorimanx-SG2-I9100-Kernel/android-toolchain/bin/arm-eabi-

Installing as a part of the kernel:
======================================

Let's take [linux] as the path to your kernel source dir...

	cd [linux]
	cp -rvf exfat-nofuse [linux]/fs/exfat

edit [linux]/fs/Kconfig
```
 menu "DOS/FAT/NT Filesystems"

  source "fs/fat/Kconfig"
 +source "fs/exfat/Kconfig"
  source "fs/ntfs/Kconfig"
```

  endmenu

edit [linux]/fs/Makefile
```
  obj-$(CONFIG_FAT_FS)    += fat/
 +obj-$(CONFIG_EXFAT_FS)  += exfat/
  obj-$(CONFIG_BFS_FS)    += bfs/
```

	cd [linux]
	make menuconfig

Go to:
> File systems > DOS/FAT/NT
>   check exfat as MODULE (M)
>   (437) Default codepage for exFAT
>   (utf8) Default iocharset for exFAT
=======
To add to kernel you need to do this:
======================================

cd your kernel source dir

mkdir fs/exfat

copy all files (exept .git) from exfat-nofuse to your kernel source fs/exfat/

see
https://github.com/dorimanx/Dorimanx-SG2-I9100-Kernel/commit/e8fc728a68096db9ffcebff40244ebfb60a3de18

edit fs/Kconfig
edit fs/Makefile

cd your kernel source
make menuconfig

Go to:
> File systems > DOS/FAT/NT > check the exfat as MODULE (M)
> (437) Default codepage for exFAT
> (utf8) Default iocharset for exFAT
>>>>>>> fc156d9... exFAT support

> ESC to main menu
> Save an Alternate Configuration File
> ESC ESC

<<<<<<< HEAD
build your kernel

Have fun.

Free Software for the Free Minds!
=================================
=======
build your kernel.

and you will have new module!

exfat.ko

have fun.

Free Software for the Free Minds!
=====================================
>>>>>>> fc156d9... exFAT support
