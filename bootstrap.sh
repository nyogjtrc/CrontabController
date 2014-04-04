#!/bin/bash
#
# CrontabController
# 
# author: nyogjtrc
# create date: 2013/06/27
#
# update date: 2013/08/07
# update by: nyogjtrc
# version 0.3

# load configuration
source 'config.sh'

# load
source 'lib/common.sh'

# load foundation
source 'lib/foundation.sh'

echo $(date -Iseconds) : $0 $@ >> $LOG_FILE

_usage_msg() {
    cat <<Usage
CrontabController, one tool to deploy crontab

usage:
  ./bootstrap.sh list [<ip>]
                 install <ip>
                 uninstall <ip>
                 remote <ip>
                 fetch [ip]
                 fetch_all

description:
    list

    install

    uninstall

    remote
Usage
}

#
# main code
#

case $1 in
    list)
        _"${1}" $2
        ;;
    install)
        _"${1}" $2
        ;;
    uninstall)
        _"${1}" $2
        ;;
    fetch)
        _"${1}" $2
        ;;
    fetch_all)
        _"${1}"
        ;;
    remote)
        _remote_list $2
        ;;
    -b|--backup|--bak)
        _backup_cron $2
        ;;
    *)
        _usage_msg
        exit 1
        ;;
esac
