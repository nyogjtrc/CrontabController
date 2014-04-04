# verify ip
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

# mkdir
_mkdir_working_directory() {
    working_diretory_path="$( dirname ${1} )"
    test ! -e "${working_diretory_path}" &&
        mkdir -p "${working_diretory_path}"
}
