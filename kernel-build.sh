#!/bin/bash
#
# Android Kernel Build Script by sagar846 @xda-developers
#
# v1 : Initial release.

clear

#Resources

THREAD="-j4"
DEVICE="athene"
DEFCONFIG="enigma_defconfig"
KERNEL="zImage"

# Kernel Details

export ARCH=arm
export CROSS_COMPILE=~/Kernel-Stuff/UBERTC-arm-eabi-4.9/bin/arm-eabi-

#Paths

KERNEL_DIR="$(HOME)/kernel_athene"
ZIMAGE_DIR="$KERNEL_DIR/arch/arm/boot"

#Functions

function clean_all {
	echo
	make clean
}

function make_kernel {
	echo
	make $DEFCONFIG
	make $THREAD
}

while read -p "Do you want to perform a clean build (y/N)? " cchoice
do
case "$cchoice" in
	y|Y)
		echo
		clean_all
		echo "All Cleaned up"
		break
		;;
	n|N)
		echo
		echo "Dirty build it is then."
		echo
		break
		;;
	* )
		echo
		echo "Invalid input try again!"
		echo
		;;
esac
done


echo "You are building Enigma kernel for $DEVICE";
echo

while read -p "Do you want to build the kernel (y/N)? " dchoice
do
case "$dchoice" in
	y|Y)
		DATE_START=$(date+"%s")
		make_kernel
		if [ -f $ZIMAGE_DIR/$KERNEL];
		then
			echo
			echo "Kernel Build was Successful"
			echo "Check /arch/arm/boot for zImage, that is the kernel"
			echo
		else
			echo
			echo "Kernel Build failed"
			echo "Try building kernel without this script and see what went wrong."
			echo
		fi
		break
		;;
	n|N)
		DATE_START=$(date +"%s")
		echo
		break
		;;
	* )
		echo
		echo "Invalid input try again!"
		echo
		;;
esac
done

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo

