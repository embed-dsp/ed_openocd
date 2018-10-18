
Compile and Install of Open On-Chip Debugger (OpenOCD)
======================================================

This repository contains make files for easy compile of [OpenOCD](http://openocd.org).

Prerequisites
=============

## Raspberry Pi

### Install GNU auto tools.
```
sudo apt-get install autoconf
sudo apt-get install automake
sudo apt-get install libtool
```

### Install libusb.
```
sudo apt-get install libusb-1.0-0
sudo apt-get install libusb-1.0-0-dev
```

Get Source Code
===============

## ed_openocd
```bash
git clone https://github.com/embed-dsp/ed_openocd.git
```

## OpenOCD
```bash
# Enter the ed_openocd directory.
cd ed_openocd

# Clone the OpenOCD git repository.
make clone

# Pull latest updates from the OpenOCD git repository.
make pull

# Edit the Makefile for selecting the OpenOCD version (git master branch / git tag).
vim Makefile
PACKAGE_VERSION = master
```

Build
=====
```bash
# Checkout specific version and rebuild configure script.
make prepare

# Configure source code.
make configure

# Compile source code using 4 simultaneous jobs (Default: J=4).
make compile
make compile J=4
```

Install
=======
```bash
# Install build products.
sudo make install
```

The build products are installed in the following locations:
```bash
opt/
└── openocd/
    └── openocd-master/
        ├── linux_x86_64/   # 64-bit binaries and libraries for Linux
        │   ├── bin/
        │   │   ├── openocd
        │   │   ...
        ├── linux_x86/      # 32-bit binaries and libraries for Linux
        │   ├── bin/
        │   │   ├── openocd
        │   │   ...
        └── share/          # Architecture independent data files.
            ├── openocd/
            │   ├── scripts/
                    ...
```

Notes
=====

This has been testes with the following Linux distributions and compilers:
* `Fedora-27 (64-bit)` and `gcc-7.2.1`
* `Raspberry Pi 3 Model B (32-bit)` and `gcc-6.3.0`
* `Raspberry Pi Zero Wireless (32-bit)` and `gcc-6.3.0`
