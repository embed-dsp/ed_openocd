
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

PATH:=$(TOOL_CHAIN):$(PATH)

PREFIX = $(DESTDIR)
EXEC_PREFIX = $(PREFIX)/$(SOC)


all:
	

.PHONY: build
build: prepare configure compile
	
	
.PHONY: prepare
prepare:
	cd openocd-code && ./bootstrap

#	# Discard any local changes
#	cd alsa-lib && git checkout -- .
#	
#	# Checkout specific version
#	cd alsa-lib && git checkout v1.1.3
#	
#	# Rebuild configure
#	cd alsa-lib && autoreconf -f -i
	

.PHONY: configure
configure:
	cd openocd-code && ./configure --prefix=$(PREFIX) --exec-prefix=$(EXEC_PREFIX) --enable-sysfsgpio --enable-bcm2835gpio
#	cd alsa-lib && ./configure CFLAGS="$(CCFLAGS)" --host=$(HOST) --prefix=$(PREFIX) --exec-prefix=$(EXEC_PREFIX) --enable-static --disable-shared --disable-python
	

.PHONY: compile
compile:
	cd openocd-code && make -j4
	

.PHONY: install
install:
	cd openocd-code && make install
	

.PHONY: distclean
distclean:
	cd openocd-code && make distclean
	

.PHONY: clean
clean:
	cd openocd-code && make clean
	
