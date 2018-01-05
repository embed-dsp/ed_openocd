
# Copyright (c) 2017-2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $


CC = /usr/bin/gcc

PACKAGE_NAME = openocd

# Package version number (git master branch / git tag)
PACKAGE_VERSION = master
# PACKAGE_VERSION = v0.10.0

PACKAGE = $(PACKAGE_NAME)-$(PACKAGE_VERSION)

# Architecture.
ARCH = $(shell ./bin/get_arch.sh)

# Installation.
PREFIX = /opt/openocd/$(PACKAGE)
EXEC_PREFIX = $(PREFIX)/$(ARCH)

# Set number of simultaneous jobs (Default 4)
ifeq ($(J),)
	J = 4
endif


all:
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
	@echo "sudo make install"
	@echo ""
	@echo "## Cleanup"
	@echo "make distclean"
	@echo "make clean"
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


.PHONY: configure
configure:
	cd $(PACKAGE_NAME) && ./configure CC=$(CC) --prefix=$(PREFIX) --exec_prefix=$(EXEC_PREFIX) --enable-sysfsgpio --enable-bcm2835gpio
	

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
