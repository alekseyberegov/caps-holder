#!/bin/bash

usage ()
{
    echo ""
    echo "Creating tunnel to CATS service"
    echo "Usage: $0 [-u|--user <user>] [-h|--help]"
    echo ""
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
    -u|--user)
    user="$2"
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

if [[ $user == "" ]]
then
  usage
fi

ssh -i ~/.ssh/id_rsa -L 8888:prod-ds-cats.cubaneddie.k8s.clicktripz.io:443 ${user}
