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
REMOTE_CRON_DIR=/tmp/cron_tmp_file/

usage_msg() {
    echo -e "\nWelcome to CrontabController\n"
    echo "Usage:"
    echo "  ./bootstrap.sh list [ip]"
    echo "  ./bootstrap.sh install [ip]"
}

install() {
    if [ -z $1 ]; then
        echo "missing file name..."
        return
    fi
    echo "install $1"
    CRON_FILE=$CRON_DATA_PATH"/"$1
    cron_dir=$CRON_DATA_PATH"/"$1

    # upload crontab file
    scp -r $cron_dir $1:$REMOTE_CRON_DIR

    # install crontab
    ssh $1 crontab $REMOTE_CRON_DIR
}

uninstall() {
    ssh $1 rm -rIv $REMOTE_CRON_DIR
}

list() {
    cron_dir=$CRON_DATA_PATH"/"$1
    if [ -d $cron_dir ]; then
        # output cron file
        cat $cron_dir/*
    else
        # output machine list
        ls $CRON_DATA_PATH
    fi
}

case $1 in
    list)
        list $2
        ;;
    install)
        install $2
        ;;
    uninstall)
        uninstall $2
        ;;
    *)
        usage_msg
        exit 1
        ;;
esac
