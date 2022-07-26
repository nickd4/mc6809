#!/bin/sh
if ! test -f ExBasRom.zip
then
  wget http://searle.x10host.com/6809/ExBasRom.zip
fi
if ! test -f ExBasROM.hex
then
  unzip ExBasRom.zip ExBasROM.hex
fi
if ! test -f ExBasROM.bin
then
  hex2bin.py --range=c000: ExBasROM.hex ExBasROM.bin
fi
#./mc09emulator ExBasROM.bin 0xc000 <basic_test.txt
if ! test -f v09.rom
then
  dd if=/dev/zero of=v09.rom bs=1024 count=16
  cat ExBasROM.bin >>v09.rom
fi
./mc09emulator v09.rom 0x8000r <basic_test.txt
