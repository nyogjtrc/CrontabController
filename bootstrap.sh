#!/bin/bash
#
# CrontabController
# 
# author: nyogjtrc
# date: 2013/06/27
#
# version 0.2

# path where cron file you put in
CRON_DATA_PATH="./cron_file"
TMP_DIR=/tmp/CrontabController
REMOTE_CRON_DIR=/tmp/cron_tmp_file

_usage_msg() {
    echo -e "\nWelcome to CrontabController\n"
    echo "Usage:"
    echo "  ./bootstrap.sh list [ip]"
    echo "  ./bootstrap.sh install [ip]"
}

_install() {
    if [ -z $1 ]; then
        echo "missing file name..."
        return
    fi
    echo "install $1"

    cron_dir=$CRON_DATA_PATH/$1

    #create tmp file
    mkdir -p $TMP_DIR
    cat $cron_dir/* > $TMP_DIR/$1

    # upload crontab file
    ssh $1 mkdir -p $REMOTE_CRON_DIR
    scp $TMP_DIR/$1 $1:$REMOTE_CRON_DIR/$1

    # install crontab
    ssh $1 crontab $REMOTE_CRON_DIR/$1
}

_uninstall() {
    ssh $1 rm -rIv $REMOTE_CRON_DIR
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
