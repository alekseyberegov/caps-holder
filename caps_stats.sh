#!/bin/bash

dir=~

latest_file=$(ls -t $dir/caps*db | head -1)
sqlite3 $latest_file < ./caps_stats.sql
