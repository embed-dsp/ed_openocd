
#transport select jtag

adapter_khz 1000
adapter_nsrst_delay 400
reset_config none

if { [info exists CHIPNAME] } {
    set _CHIPNAME $CHIPNAME
} else {
    set _CHIPNAME rpi
}




if { [info exists CPU_TAPID] } {
    set _CPU_TAPID $CPU_TAPID
} else {
    set _CPU_TAPID 0x07b7617F
}

jtag newtap $_CHIPNAME arm -irlen 5 -expected-id $_CPU_TAPID

set _TARGETNAME $_CHIPNAME.arm

target create $_TARGETNAME arm11 -chain-position $_TARGETNAME

# $_TARGETNAME configure -event reset-assert-post "cortex_a dbginit"
$_TARGETNAME configure -event gdb-attach { halt }
