# Crontab Controller

one little tool to deploy and install crontab

current version: v0.2

## some config

default cron file path

``./cron_file``

use ip name as directory name.
please put you cron file by below example.

``./cron_file/<ip>/some_thing_cron``

## Usage

**List Crontab**

``./bootstrap.sh list [ip]``

**Install Crontab**

``./bootstrap.sh install <ip>``

**Uninstall Crontab**

``./bootstrap.sh uninstall <ip>``

## TODO List

- [ ] common cron file
