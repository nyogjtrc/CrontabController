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

#include configuration file
source config.sh

echo $(date -Iseconds) : $0 $@ >> $LOG_FILE

_usage_msg() {
    cat <<Usage
CrontabController, one tool to deploy crontab

usage:
  ./bootstrap.sh list [<ip>]
                 install <ip>
                 uninstall <ip>
                 remote <ip>

description:
    list

    install

    uninstall

    remote
Usage
}

_install() {
    if [ -z $1 ]; then
        echo "missing file name..."
        return
    fi
    echo "install $1"

    cron_dir=$CRON_DATA_PATH/$1

    #create tmp file
    mkdir -p $TMP_PATH

    # test file
    test -e $cron_dir || echo $1 "not exesit."; return

    cat $cron_dir/* > $TMP_PATH/$1

    # upload crontab file
    ssh $1 mkdir -p $REMOTE_CRON_PATH
    scp $TMP_PATH/$1 $1:$REMOTE_CRON_PATH/$1

    # install crontab
    ssh $1 crontab $REMOTE_CRON_PATH/$1
}

_uninstall() {
    if [ -z $1 ]; then
        echo "missing ip..."
        return
    fi

    # uninstall crontab
    ssh $1 crontab -ir

    # remove file
    ssh $1 rm -riv $REMOTE_CRON_PATH
}

_list() {
    if [ -z $1 ]; then
        # output machine list
        ls $CRON_DATA_PATH
    else
        # output cron file
        cat $CRON_DATA_PATH/$1/*
    fi
}

_remote_list() {
    if [ -z $1 ]; then
        echo "missing ip..."
        return
    fi
    ssh $1 crontab -l
}

#
# main code
#

case $1 in
    list)
        _list $2
        ;;
    install)
        _install $2
        ;;
    uninstall)
        _uninstall $2
        ;;
    remote)
        _remote_list $2
        ;;
    *)
        _usage_msg
        exit 1
        ;;
esac
