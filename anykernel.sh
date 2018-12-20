# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Fluxions Kernel for Mi 6 MIUI Oreo
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=sagit
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chmod -R 755 $ramdisk/sbin;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.fluxions.rc
insert_line init.rc "import /init.fluxions.rc" after "import /init.usb.rc" "import /init.fluxions.rc";

#import init.spectrum.rc
insert_line init.rc "import /init.spectrum.rc" after "import /init.vantom.rc" "import /init.spectrum.rc";

# init.rc
remove_line default.prop "ro.secureboot.devicelock=1"
patch_prop default.prop "persist.sys.usb.config" "mtp,adb"
patch_cmdline "androidboot.selinux" "androidboot.selinux=permissive"
patch_cmdline "androidboot.verifiedbootstate" "androidboot.verifiedbootstate=green"

# ramdisk patch
ramdisk_patch;

# end ramdisk changes

write_boot;

## end install
