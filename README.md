# Crontab Controller

one little tool to deploy and install crontab

current version: v0.4

## Usage

```bash
usage:
  ./bootstrap.sh -l|--list [<ip>]
                 -I|--install <ip>
                 -U|--uninstall <ip>
                 -r|--remote <ip>
                 -f|--fetch <ip>
                 -b|--backup|--bak <ip>

description:
    -l|--list
        list local crontab file

    -I|--install
        install remote crontab

    -U|--uninstall
        uninstall remote crontab

    -r|--remote
        list remote crontab

    -f|--fetch
        fetch remote crontab

    -b|--backup|--bak
        back up remote crontab to local file
```

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
