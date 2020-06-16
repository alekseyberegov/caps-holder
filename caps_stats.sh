#!/bin/bash


sqlite3 -init ./caps_stats.sql $1 $2 $3
