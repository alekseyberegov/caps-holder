#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

PYTHONPATH=$DIR/caps-holder

# default values
config="nypost"
sqlite3_dir=~
spider="caps-holder/capsholder/spiders/CapsHolderScraper.py"
endpoint="https://localhost:8888/v1/cats"
debug="False"

usage ()
{
    printf -- "\n"
    printf -- "Usage: $0 [OPTIONS]\n\n"
    printf -- "Running CAPS spider\n\n"
    printf -- "Options:\n"
    printf -- "  -c, --config string       use a given config for scraping\n"
    printf -- "  -e, --endpoint string     specify CATS endpoint\n"
    printf -- "  -d, --debug               enable debug mode\n"
    printf -- "  -s, --settings            show default settings\n"
    printf -- "\n"
    exit 1
}


settings ()
{
  printf -- "\n"
  printf -- "Default Settings:\n"
  printf -- "-----------------\n"
  printf -- "        debug :  %-25s\n" ${debug}
  printf -- "       config :  %-25s\n" ${config}
  printf -- "   sqlite dir :  %-25s\n" ${sqlite3_dir}
  printf -- "CATS endpoint :  %-25s\n" ${endpoint}
  printf -- "\n"
  exit 1
}


POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
      usage
    ;;
    -s|--settings)
      settings
    ;;
    -d|--debug)
    debug="True"
    shift # past argument
    ;;
    -c|--config)
    config="$2"
    shift # past argument
    shift # past value
    ;;
    -e|--endpoint)
    endpoint="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters


scrapy runspider ${spider} \
  -a config=${config} \
  -s CATS_DEBUG=${debug} \
  -s SQLITE3_DIR=${sqlite3_dir} \
  -s CATS_ENDPOINT=${endpoint}

