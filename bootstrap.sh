#!/bin/bash
#
# CrontabController
# 
# author: nyogjtrc
# date: 2013/06/27
#

echo "Welcome to CrontabController";

usage_msg() {
    echo "Usage:"
    echo "  ./bootstrap.sh install"
}

install() {
    echo "install"
}

case $i in
    *)
        usage_msg
        exit 1
        ;;
esac
