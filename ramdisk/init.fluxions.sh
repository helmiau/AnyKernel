#!/system/bin/sh

################################################################################
# helper functions to allow Android init like script

function write() {
    echo -n $2 > $1
}

function copy() {
    cat $1 > $2
}

# macro to write pids to system-background cpuset
function writepid_sbg() {
    until [ ! "$1" ]; do
        echo -n $1 > /dev/cpuset/system-background/tasks;
        shift;
    done;
}

function writepid_top_app() {
    until [ ! "$1" ]; do
        echo -n $1 > /dev/cpuset/top-app/tasks;
        shift;
    done;
}
################################################################################

{

sleep 10


# KCAL - permissions
chown system system /sys/devices/platform/kcal_ctrl.0/kcal_enable
chown system system /sys/devices/platform/kcal_ctrl.0/kcal
chown system system /sys/devices/platform/kcal_ctrl.0/kcal_cont
chown system system /sys/devices/platform/kcal_ctrl.0/kcal_hue
chown system system /sys/devices/platform/kcal_ctrl.0/kcal_sat
chown system system /sys/devices/platform/kcal_ctrl.0/kcal_val
chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal_enable
chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal
chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal_cont
chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal_hue
chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal_sat
chmod 0664 /sys/devices/platform/kcal_ctrl.0/kcal_val

# KCAL
write /sys/devices/platform/kcal_ctrl.0/kcal_enable 1
write /sys/devices/platform/kcal_ctrl.0/kcal "256 256 256"	
write /sys/devices/platform/kcal_ctrl.0/kcal_sat 30
write /sys/devices/platform/kcal_ctrl.0/kcal_hue 0
write /sys/devices/platform/kcal_ctrl.0/kcal_val 4
write /sys/devices/platform/kcal_ctrl.0/kcal_cont 4

# Schedutil & Stune
chown system system /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

chown system system /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor

write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "schedutil"
write /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor "schedutil"

chown system system /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
chown system system /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
chown system system /sys/devices/system/cpu/cpu0/cpufreq/schedutil/iowait_boost_enable
chown system system /sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
chown system system /sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
chown system system /sys/devices/system/cpu/cpu4/cpufreq/schedutil/iowait_boost_enable

chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/schedutil/iowait_boost_enable
chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/schedutil/iowait_boost_enable

write /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us 500
write /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us 20000
write /sys/devices/system/cpu/cpu0/cpufreq/schedutil/iowait_boost_enable 1
write /sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us 500
write /sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us 20000
write /sys/devices/system/cpu/cpu4/cpufreq/schedutil/iowait_boost_enable 1
   
## write /sys/module/cpu_boost/parameters/dynamic_stune_boost 1
## write /sys/module/cpu_boost/parameters/input_boost_freq "0:0 1:0 2:0 3:0 4:0 5:0 6:0 7:0"
## write /sys/module/cpu_boost/parameters/input_boost_ms 100
echo 5 > /dev/stune/top-app/schedtune.boost

chown system system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
chown system system /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq

chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq

write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 175000
write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 175000

chown system system /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq

write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 1900800

chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo '1900800' > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo '1900800' > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo '1900800' > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo '1900800' > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
echo '1900800' > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
echo '2457600' > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
echo '2457600' > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
echo '2457600' > /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
echo '2457600' > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
echo '2457600' > /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
echo 'fiops' > /sys/block/sda/queue/scheduler
echo '0' > /sys/kernel/sched/gentle_fair_sleepers
echo '1' /sys/kernel/fast_charge/force_fast_charge
#echo '180000000' > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
echo 'Y' > /sys/module/sync/parameters/fsync_enabled
echo 414000000 > /sys/module/governor_msm_adreno_tz/parameters/boost_freq
echo 750 > /sys/module/governor_msm_adreno_tz/parameters/boost_duration

sleep 20

}&

