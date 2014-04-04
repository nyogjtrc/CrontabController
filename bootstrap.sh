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
                 fetch [ip]
                 fetch_all

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
    if [ ! -d $cron_dir ]; then
        echo $1 "not exesit.";
        return 0;
    fi

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

_verify_ip() {
    ip_regex='^(((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)[.]){3})(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'
    ip_regex_allow="${ip_regex}"
    if echo -e "${1}" | egrep "${ip_regex_allow}" > /dev/null
    then
      echo -e " # ${1} is a valid ip "
    else
        echo " # ip : ${1} not available " ; exit 2
    fi	
}

_fetch_all() {
    echo -e " # function to be implemented "
}

_mkdir_working_directory() {
    working_diretory_path="$( dirname ${1} )"
    test ! -e "${working_diretory_path}" && 
        mkdir -p "${working_diretory_path}"
}

_fetch() {
    if [ -z $1 ]; then
        # fetch all remote machine crontab
        _fetch_all
    else
        # fetch remote machine crontab
        _verify_ip "${1}" && {
            working_copy_path="${CRON_DATA_PATH}"/"${1}"/"${1}".cron
            _mkdir_working_directory "${working_copy_path}"
            ssh "${1}" ' crontab -l ' > "${working_copy_path}"
        }
    fi
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
    *)
        _usage_msg
        exit 1
        ;;
esac
