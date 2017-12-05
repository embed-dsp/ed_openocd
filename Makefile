
# Copyright (c) 2017 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $


# ----------------------------------------
# Installation destination.
# ----------------------------------------
DESTDIR = /opt/ed_openocd

# ----------------------------------------

PATH := $(TOOL_CHAIN):$(PATH)

PREFIX = $(DESTDIR)

OPENOCD = openocd


all:
	@echo ""
	@echo "## First time"
	@echo "make clone	    # Get openocd source from git repo"
	@echo "make prepare	    # Checkout specific version"
	@echo "make configure"
	@echo "make compile"
	@echo "sudo make install"
	@echo ""
	@echo "## Any other time"
	@echo "make distclean	    # Clean all build products"
	@echo "make configure"
	@echo "make compile"
	@echo "sudo make install"
	@echo ""


.PHONY: clone
clone:
	git clone http://repo.or.cz/openocd.git
#	git clone https://git.code.sf.net/p/openocd/code openocd


.PHONY: prepare
prepare:
	# Discard any local changes
	cd $(OPENOCD) && git checkout -- .
	
	# Checkout specific version
	cd $(OPENOCD) && git checkout master
#	cd $(OPENOCD) && git checkout v0.10.0

	# ...
	cd $(OPENOCD) && ./bootstrap


.PHONY: distclean
distclean:
	cd $(OPENOCD) && make distclean


.PHONY: configure
configure:
	cd $(OPENOCD) && ./configure --prefix=$(PREFIX) --enable-sysfsgpio --enable-bcm2835gpio
	

.PHONY: compile
compile:
	cd $(OPENOCD) && make -j4
	

.PHONY: install
install:
	cd $(OPENOCD) && make install
