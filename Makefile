
# Copyright (c) 2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $


PACKAGE_NAME = openocd

# Package version number (git master branch / git tag)
PACKAGE_VERSION = master
# PACKAGE_VERSION = v0.10.0

PACKAGE = $(PACKAGE_NAME)-$(PACKAGE_VERSION)

# Set number of simultaneous jobs (Default 4)
ifeq ($(J),)
	J = 4
endif

# System and Machine.
SYSTEM = $(shell ./bin/get_system.sh)
MACHINE = $(shell ./bin/get_machine.sh)

# System configuration.
CONFIGURE_FLAGS = --enable-sysfsgpio --enable-bcm2835gpio

# Linux system.
ifeq ($(SYSTEM),linux)
	# Compiler.
	CC = /usr/bin/gcc
	# Installation directory.
	INSTALL_DIR = /opt
endif

# Cygwin system.
ifeq ($(SYSTEM),cygwin)
	# Compiler.
	CC = /usr/bin/gcc
	# Installation directory.
	INSTALL_DIR = /cygdrive/c/opt
endif

# MSYS2/mingw32 system.
ifeq ($(SYSTEM),mingw32)
	# Compiler.
	CC = /mingw32/bin/gcc
	# Installation directory.
	INSTALL_DIR = /c/opt
endif

# MSYS2/mingw64 system.
ifeq ($(SYSTEM),mingw64)
	# Compiler.
	CC = /mingw64/bin/gcc
	# Installation directory.
	INSTALL_DIR = /c/opt
endif

# Architecture.
ARCH = $(SYSTEM)_$(MACHINE)

# Installation directories.
PREFIX = $(INSTALL_DIR)/$(PACKAGE_NAME)/$(PACKAGE)
EXEC_PREFIX = $(PREFIX)/$(ARCH)


all:
	@echo "ARCH   = $(ARCH)"
	@echo "PREFIX = $(PREFIX)"
	@echo ""
	@echo "## Get Source Code"
	@echo "make clone"
	@echo "make pull"
	@echo ""
	@echo "## Build"
	@echo "make prepare"
	@echo "make configure"
	@echo "make compile [J=...]"
	@echo ""
	@echo "## Install"
	@echo "[sudo] make install"
	@echo ""
	@echo "## Cleanup"
	@echo "make clean"
	@echo "make distclean"
	@echo ""


.PHONY: clone
clone:
	git clone http://repo.or.cz/openocd.git
#	git clone https://git.code.sf.net/p/openocd/code openocd


.PHONY: pull
pull:
	# Discard any local changes
	cd $(PACKAGE_NAME) && git checkout -- .
	
	# Checkout master branch
	cd $(PACKAGE_NAME) && git checkout master
	
	# ...
	cd $(PACKAGE_NAME) && git pull


.PHONY: prepare
prepare:
	# Checkout specific version
	cd $(PACKAGE_NAME) && git checkout $(PACKAGE_VERSION)

	# Rebuild configure
	cd $(PACKAGE_NAME) && ./bootstrap

	# ...
#	cd $(PACKAGE_NAME) && chmod +x configure
#	cd $(PACKAGE_NAME) && chmod +x jimtcl/configure


.PHONY: configure
configure:
	cd $(PACKAGE_NAME) && ./configure CC=$(CC) --prefix=$(PREFIX) --exec_prefix=$(EXEC_PREFIX) $(CONFIGURE_FLAGS)
	

.PHONY: compile
compile:
	cd $(PACKAGE_NAME) && make -j$(J)
	

.PHONY: install
install:
	cd $(PACKAGE_NAME) && make install


.PHONY: clean
clean:
	cd $(PACKAGE_NAME) && make clean


.PHONY: distclean
distclean:
	cd $(PACKAGE_NAME) && make distclean
