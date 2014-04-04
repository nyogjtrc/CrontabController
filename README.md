# Crontab Controller

one little tool to deploy and install crontab

current version: v0.4

## Usage

**List Crontab**

``./bootstrap.sh list [ip]``

**Install Crontab**

``./bootstrap.sh install <ip>``

**Uninstall Crontab**

``./bootstrap.sh uninstall <ip>``

**List Remote Crontab**

``./bootstrap.sh remote <ip>``

**Backup Remote Crontab**

``./bootstrap.sh -b <ip>``

## Some Configuration

default cron file path at ``./cron_file``
default backup file path at ``./cron_bak``

use ip name as directory name.
please put you cron file by below example.

``./cron_file/<ip>/some_thing_cron``

## Operation Log

controller will write log at

``./.operation.log``

## TODO List

1. common cron file
2. looping to install all crontab
3. checking method
