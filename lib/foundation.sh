# install crontab remtoe machine
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

# uninstall crontab to remote machine
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

# list local crontab file
_list() {
    if [ -z $1 ]; then
        # output machine list
        ls $CRON_DATA_PATH
    else
        # output cron file
        cat $CRON_DATA_PATH/$1/*
    fi
}

# list remote crontab file
_remote_list() {
    if [ -z $1 ]; then
        echo "missing ip..."
        return
    fi
    ssh $1 crontab -l
}

# fetch all
_fetch_all() {
    echo -e " # function to be implemented "
}

# fetch crontab file from remote machine
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
