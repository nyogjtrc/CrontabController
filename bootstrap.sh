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
  ./bootstrap.sh -l|--list [<ip>]
                 -I|--install <ip>
                 -U|--uninstall <ip>
                 -r|--remote <ip>
                 -f|--fetch <ip>
                 -b|--backup|--bak <ip>

description:
    -l|--list
        list local crontab file

    -I|--install
        install remote crontab

    -U|--uninstall
        uninstall remote crontab

    -r|--remote
        list remote crontab

    -f|--fetch
        fetch remote crontab

    -b|--backup|--bak
        back up remote crontab to local file
Usage
}

#
# main code
#

case $1 in
    -l|--list)
        _list $2
        ;;
    -I|--install)
        _install $2
        ;;
    -U|--uninstall)
        _uninstall $2
        ;;
    -f|--fetch)
        _fetch $2
        ;;
    -r|remote)
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
