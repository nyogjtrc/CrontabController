# Crontab Controller

one little tool to deploy and install crontab

current version: v0.3

## Usage

**List Crontab**

``./bootstrap.sh list [ip]``

**Install Crontab**

``./bootstrap.sh install <ip>``

**Uninstall Crontab**

``./bootstrap.sh uninstall <ip>``

``./bootstrap.sh remote <ip>``

## Some Configuration

default cron file path

``./cron_file``

use ip name as directory name.
please put you cron file by below example.

``./cron_file/<ip>/some_thing_cron``

writing log at

``./.operation.log``

## TODO List

1. common cron file
2. looping to install all crontab
