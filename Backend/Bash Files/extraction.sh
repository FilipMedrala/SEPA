#!/bin/bash
# Get values from AFL Fuzzer stats

#SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Source location
# SOURCEDIR="/home/sepadmin/Documents/afl-results/afl-test/"
# SOURCEFILE="fuzzer_stats"
# SOURCE_LOCATION=$SOURCEDIR$SOURCEFILE
SOURCE_LOCATION=$1

# Destination location
# DESTDIR="/home/sepadmin/Documents/bash_testing/"
# DESTFILE="fuzzer_stats_extracted"
# DEST_LOCATION=$DESTDIR$DESTFILE
DEST_LOCATION=$2

cp $SOURCE_LOCATION $DEST_LOCATION
echo "Coping $SOURCE_LOCATION to $DEST_LOCATION"

start_time=`cat $DEST_LOCATION | grep "start_time" | sed 's/^.*: //'`
last_update=`cat $DEST_LOCATION | grep "last_update" | sed 's/^.*: //'`
fuzzer_pid=`cat $DEST_LOCATION | grep "fuzzer_pid" | sed 's/^.*: //'`
cycles_done=`cat $DEST_LOCATION | grep "cycles_done" | sed 's/^.*: //'`
execs_done=`cat $DEST_LOCATION | grep "execs_done" | sed 's/^.*: //'`
execs_per_sec=`cat $DEST_LOCATION | grep "execs_per_sec" | sed 's/^.*: //'`
paths_total=`cat $DEST_LOCATION | grep "paths_total" | sed 's/^.*: //'`
paths_favored=`cat $DEST_LOCATION | grep "paths_favored" | sed 's/^.*: //'`
paths_found=`cat $DEST_LOCATION | grep "paths_found" | sed 's/^.*: //'`
paths_imported=`cat $DEST_LOCATION | grep "paths_imported" | sed 's/^.*: //'`
max_depth=`cat $DEST_LOCATION | grep "max_depth" | sed 's/^.*: //'`
cur_path=`cat $DEST_LOCATION | grep "cur_path" | sed 's/^.*: //'`
pending_favs=`cat $DEST_LOCATION | grep "pending_favs" | sed 's/^.*: //'`
pending_total=`cat $DEST_LOCATION | grep "pending_total" | sed 's/^.*: //'`
variable_paths=`cat $DEST_LOCATION | grep "variable_paths" | sed 's/^.*: //'`
stability=`cat $DEST_LOCATION | grep "stability" | sed 's/^.*: //'`
bitmap_cvg=`cat $DEST_LOCATION | grep "bitmap_cvg" | sed 's/^.*: //'`
unique_crashes=`cat $DEST_LOCATION | grep "unique_crashes" | sed 's/^.*: //'`
unique_hangs=`cat $DEST_LOCATION | grep "unique_hangs" | sed 's/^.*: //'`
last_path=`cat $DEST_LOCATION | grep "last_path" | sed 's/^.*: //'`
last_crash=`cat $DEST_LOCATION | grep "last_crash" | sed 's/^.*: //'`
last_hang=`cat $DEST_LOCATION | grep "last_hang" | sed 's/^.*: //'`
execs_since_crash=`cat $DEST_LOCATION | grep "execs_since_crash" | sed 's/^.*: //'`
exec_timeout=`cat $DEST_LOCATION | grep "exec_timeout" | sed 's/^.*: //'`
afl_banner=`cat $DEST_LOCATION | grep "afl_banner" | sed 's/^.*: //'`
afl_version=`cat $DEST_LOCATION | grep "afl_version" | sed 's/^.*: //'`
target_mode=`cat $DEST_LOCATION | grep "target_mode" | sed 's/^.*: //'`
command_line=`cat $DEST_LOCATION | grep "command_line" | sed 's/^.*: //'`

start_time_converted=`date -d @$start_time`
last_update_converted=`date -d @$last_update`
last_path_converted=`date -d @$last_path`
last_crash_converted=`date -d @$last_crash`

echo $start_time_converted
echo $last_update_converted
echo $fuzzer_pid
echo $cycles_done
echo $execs_done
echo $execs_per_sec
echo $paths_total
echo $paths_favored
echo $paths_found
echo $paths_imported
echo $max_depth
echo $cur_path
echo $pending_favs
echo $pending_total
echo $variable_paths
echo $stability
echo $bitmap_cvg
echo $unique_crashes
echo $unique_hangs
echo $last_path_converted
echo $last_crash_converted*
echo $last_hang
echo $execs_since_crash
echo $exec_timeout
echo $afl_banner
echo $afl_version
echo $target_mode
echo $command_line