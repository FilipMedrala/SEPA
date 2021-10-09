#!/bin/bash

#!/bin/sh

# Gets the file path
filepath=$1

stats_flavor=$2

/bin/cat <<EOM > "$filepath/.env-afl"
AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1
AFL_EXIT_WHEN_DONE=1
AFL_EXIT_ON_TIME=300
AFL_NO_UI=1
AFL_STATSD=1
AFL_AUTORESUME=1
AFL_STATSD_TAGS_FLAVOR=$stats_flavor
EOM