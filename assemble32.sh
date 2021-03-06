#!/bin/sh

echo -n "assembling stage1.asm..."
nasm stage1.asm -o DealOS.bin

if [ $? -ne 0 ]; then
	exit $?
fi

echo "done"

echo -n "assembling stage2.asm..."
nasm stage2.asm -o stage2.bin

if [ $? -ne 0 ]; then
	exit $?
fi

echo "done"

cat stage2.bin >> DealOS.bin
rm stage2.bin

if [ "$#" -gt 0 ]; then
	echo -n "assembling $1.asm..."

	nasm $1.asm -o $1.bin

	if [ $? -ne 0 ]; then
		exit $?
	fi

	echo "done"

	echo -n "concatenating $1.bin to DealOS.bin..."
	cat "$1.bin" >> DealOS.bin
	echo "done"
fi

# this is necessary to boot from USB for some reason.
cat oneMillionZeros >> DealOS.bin
