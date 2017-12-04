#
# Config for using Raspberry Pi's expansion header
#
# This is best used with a fast enough buffer but also
# is suitable for direct connection if the target voltage
# matches RPi's 3.3V and the cable is short enough.
#
# Do not forget the GND connection, pin 6 of the expansion header.
#

interface bcm2835gpio

bcm2835gpio_peripheral_base 0x3F000000

# Transition delay calculation: SPEED_COEFF/khz - SPEED_OFFSET
# These depend on system clock, calibrated for stock 700MHz
# bcm2835gpio_speed SPEED_COEFF SPEED_OFFSET
bcm2835gpio_speed_coeffs 146203 36

# Each of the JTAG lines need a gpio number set: tck tms tdi tdo
# Header pin numbers: 23 22 19 21
# bcm2835gpio_jtag_nums 11 25 10 9

# or if you have both connected,
# reset_config trst_and_srst srst_push_pull

# Each of the SWD lines need a gpio number set: swclk swdio
# Header pin numbers: 22 18
bcm2835gpio_swd_nums 25 24

# If you define trst or srst, use appropriate reset_config
# Header pin numbers: TRST - 26, SRST - 18

# bcm2835gpio_trst_num 7
# reset_config trst_only

bcm2835gpio_srst_num 18
reset_config srst_only srst_push_pull

# or if you have both connected,
# reset_config trst_and_srst srst_push_pull
