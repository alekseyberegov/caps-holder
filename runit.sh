#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

PYTHONPATH=$DIR/caps-holder

scrapy runspider caps-holder/capsholder/spiders/CapsHolderScraper.py -a config=nypost -s SQLITE3_DIR=~