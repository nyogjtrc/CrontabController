#!/bin/bash
#
# CrontabController
# 
# author: nyogjtrc
# create date: 2013/06/27
#
# update date: 2013/07/17
# update by: nyogjtrc
# version 0.3

#include configuration file
source config.sh

echo $(date -Iseconds) : $0 $@ >> $LOG_FILE

_usage_msg() {
    echo
    echo "Welcome to CrontabController"
    echo
    echo "Usage:"
    echo "  ./bootstrap.sh list [ip]"
    echo "                 install <ip>"
    echo "                 uninstall <ip>"
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
    ssh $1 rm -rIv $REMOTE_CRON_PATH
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
    *)
        _usage_msg
        exit 1
        ;;
esac
