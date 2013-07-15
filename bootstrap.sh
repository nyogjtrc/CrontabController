#!/bin/bash
#
# CrontabController
# 
# author: nyogjtrc
# date: 2013/06/27
#
# version 0.2

# path where cron file you put in
CRON_FILE_PATH="./cron_file"

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
    CRON_FILE=$CRON_FILE_PATH"/"$1

    # upload crontab file
    scp $CRON_FILE $1:/tmp/crontab_tmp_file

    # install crontab
    ssh $1 crontab /tmp/crontab_tmp_file
}

list() {
    CRON_FILE=$CRON_FILE_PATH"/"$1
    if [ -d $CRON_FILE ]; then
        cat $CRON_FILE/*
    else
        ls $CRON_FILE_PATH
    fi
}

case $1 in
    list)
        list $2
        ;;
    install)
        install $2
        ;;
    *)
        usage_msg
        exit 1
        ;;
esac
