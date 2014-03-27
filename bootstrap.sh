#!/bin/bash
#
# CrontabController
# 
# author: nyogjtrc
# create date: 2013/06/27
#
# update date: 2013/07/17
# update by: nyogjtrc
# version 0.2

# path where cron file you put in
CRON_DATA_PATH=./cron_file
TMP_DIR=/tmp/CrontabController
REMOTE_CRON_DIR=/tmp/cron_tmp_file

_usage_msg() {
    echo
    echo "Welcome to CrontabController"
    echo
    echo "Usage:"
    echo "  ./bootstrap.sh list [ip]"
    echo "  ./bootstrap.sh install <ip>"
    echo "  ./bootstrap.sh uninstall <ip>"
    echo "  ./bootstrap.sh fetch [ip]"
    echo "  ./bootstrap.sh fetch_all"
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
    if [ -z $1 ]; then
        echo "missing ip..."
        return
    fi

    # uninstall crontab
    ssh $1 crontab -ir

    # remove file
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
    *)
        _usage_msg
        exit 1
        ;;
esac
