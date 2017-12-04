# ref: http://www.raspberrypi.org/forums/viewtopic.php?f=72&t=100268
#    : http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0464f/ch10s06s01.html

adapter_khz 1000
adapter_nsrst_delay 400
reset_config none

if { [info exists CHIPNAME] } {
    set _CHIPNAME $CHIPNAME
} else {
    set _CHIPNAME rpi3
}

#
# Main DAP
#
if { [info exists DAP_TAPID] } {
    set _DAP_TAPID $DAP_TAPID
} else {
    set _DAP_TAPID 0x4ba00477
}

jtag newtap $_CHIPNAME dap -irlen 4 -ircapture 0x01 -irmask 0xf -expected-id $_DAP_TAPID

set _TARGETNAME_0 $_CHIPNAME.cpu.0
set _TARGETNAME_1 $_CHIPNAME.cpu.1
set _TARGETNAME_2 $_CHIPNAME.cpu.2
set _TARGETNAME_3 $_CHIPNAME.cpu.3

target create $_TARGETNAME_0 cortex_a -chain-position $_CHIPNAME.dap -coreid 0 -dbgbase 0x80010000 -ctibase 0x80018000
target create $_TARGETNAME_1 cortex_a -chain-position $_CHIPNAME.dap -coreid 1 -dbgbase 0x80012000 -ctibase 0x80019000
target create $_TARGETNAME_2 cortex_a -chain-position $_CHIPNAME.dap -coreid 2 -dbgbase 0x80014000 -ctibase 0x8001A000
target create $_TARGETNAME_3 cortex_a -chain-position $_CHIPNAME.dap -coreid 3 -dbgbase 0x80016000 -ctibase 0x8001B000

$_TARGETNAME_0 configure -event reset-assert-post "cortex_a dbginit"
$_TARGETNAME_0 configure -event gdb-attach { halt }
