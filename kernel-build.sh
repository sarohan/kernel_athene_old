#!/bin/bash
#
# Android Kernel Build Script for Enigma Kernel by sagar846 @xda-developers
#
# v1 : Initial release.
#
# v2 : Incorporate lazy flasher stuff + other modifications
#
# v3 : Some changes here and there + new stuff

clear

#Resources- DON'T CHANGE THIS
THREAD="-j4"
DEVICE="athene"
DEVICE_NAME="Moto G4 Plus"
DEFCONFIG="enigma_defconfig"
KERNEL="zImage"
FLASHABLE_ZIP="*.zip"

# Kernel Build Details
export ARCH=arm
# Give the complete path to your toolchain like so
export CROSS_COMPILE=~/Kernel-Stuff/UBERTC-arm-eabi-4.9/bin/arm-eabi-

#Paths - Very Important that you give the right paths
KERNEL_DIR="${HOME}/kernel_athene"
ZIMAGE_DIR="$KERNEL_DIR/arch/arm/boot"
LAZYFLASHER_DIR="${HOME}/Kernel-Stuff/lazyflasher"
KERNEL_OUT_DIR="${HOME}/Kernels/out"

######################## No touchy stuff ########################
############## Unless you know what you're doing ################

#Functions
function clean_out {
	rm $KERNEL_OUT_DIR/*.zip
	rm $KERNEL_OUT_DIR/*.sha1
}

function clean_all {
	echo
	make clean
}

function make_kernel {
	echo
	make $DEFCONFIG
	make $THREAD
}

while read -p "Executing Kernel Build Script. Continue (y/N)? " achoice
do
case "$achoice" in
	y|Y)
		echo
		echo
		break
		;;
	n|N)
		echo
		echo "Exiting build script"
		echo
		exit
		;;
	* )
		echo
		echo "Invalid Input try again!"
		echo
		;;
esac
done

while read -p "Do you want to clean out directory (y/N)? " bchoice
do
case "$bchoice" in
	y|Y)
		echo
		clean_out
		echo "Out directory cleaned."
		echo
		break
		;;
	n|N)
		echo 
		echo "Out directory has not been touched"
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
echo "You are building Enigma kernel for $DEVICE_NAME ($DEVICE)";
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
			echo "Exiting script"
			exit
			echo
		fi
		break
		;;
	n|N)
		echo "Exiting build script"
		echo
		exit
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
	echo "Note: this is done only if there is no zImage already present"
	cp $ZIMAGE_DIR/$KERNEL $LAZYFLASHER_DIR
	echo "Finished"
	echo
fi

echo "Removing flashable zip in lazyflasher directory if present"
echo "Dont worry about any errors here"
echo

VARIABLE= $($LAZYFLASHER_DIR/$FLASHABLE_ZIP)
if [ -f $VARIABLE ];
then
	rm $LAZYFLASHER_DIR/*.zip
	rm $LAZYFLASHER_DIR/*.sha1
	echo "Finished"
	echo
else
	echo "$LAZYFLASHER_DIR is clean."
	echo "Nothing to do"
	echo
fi
	
echo "Creating flashable zip file using lazy flasher"
echo

if [ -f $LAZYFLASHER_DIR/$KERNEL ];
then
	cd $LAZYFLASHER_DIR
	make
	echo
else
	echo
	echo "Error: could not create zip file."
	echo "zImage does not exist in lazyflasher root directory"
	echo "Fix compile errors and rerun script to compile the kernel again"
	echo "Aborting script"
	exit
	echo
fi

echo "Moving newly created flashable zip to out directory"
echo

if [ -f $VARIABLE ];
then
	cd $LAZYFLASHER_DIR
	mv *.zip $KERNEL_OUT_DIR
	mv *.sha1 $KERNEL_OUT_DIR
	echo "Finished"
	echo
else
	echo "Error no zip file found"
	echo "Check manually"
	echo
fi

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Total Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo

