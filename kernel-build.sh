#!/bin/bash
#
# Android Kernel Build Script by sagar846 @xda-developers
#
# v1 : Initial release.
#
# v2 : Incorporate lazy flasher stuff + other modifications

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

KERNEL_DIR="${HOME}/kernel_athene"
ZIMAGE_DIR="$KERNEL_DIR/arch/arm/boot"
LAZYFLASHER_DIR="${HOME}/Kernel-Stuff/lazyflasher"

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
		echo "Cleansed your kernel's soul"
		echo
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

echo
echo "You are building Enigma kernel for $DEVICE";
echo

while read -p "Do you want to build the kernel (y/N)? " dchoice
do
case "$dchoice" in
	y|Y)
		DATE_START=$(date +"%s")
		make_kernel
		if [ -f $ZIMAGE_DIR/$KERNEL ];
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

echo "Moving all necessary files to lazyflasher directory..."
echo

if [ -f $LAZYFLASHER_DIR/$KERNEL ];
then
	echo "Removing existing zImage in lazyflasher directory....done"
	echo
	rm $LAZYFLASHER_DIR/$KERNEL
	echo "Copying new zImage to lazyflasher directory"
	cp $ZIMAGE_DIR/$KERNEL $LAZYFLASHER_DIR
	echo "Finished"
	echo
else
	echo
	echo "Copying new zImage to lazyflasher directory"
	cp $ZIMAGE_DIR/$KERNEL $LAZYFLASHER_DIR
	echo "Finished"
	echo
fi

echo "Creating flashable zip file using lazy flasher"
echo

if [ -f $LAZYFLASHER_DIR/$KERNEL ];
then
	cd $LAZYFLASHER_DIR
	make
	DATE_END=$(date +"%s")
	DIFF=$(($DATE_END - $DATE_START))
	echo "Total Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
	echo
	echo "########################################"
	echo "###### Script Execution Completed ######"
	echo "########################################"
	echo
else
	echo
	echo "Error: could not create zip file."
	echo "zImage does not exist in lazyflasher root directory"
	echo "Fix compile errors and rerun script to compile the kernel again"
	echo "Aborting script"
	echo
fi

