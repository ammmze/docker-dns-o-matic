#!/usr/bin/env sh

CONFIG_DIR=${CONFIG_DIR:-/config}
HOST=${HOST:-all.dnsomatic.com}
WILDCARD=${WILDCARD:-NOCHG}
MX=${MX:-NOCHG}
BACKMX=${BACKMX:-NOCHG}
DELAY=${DELAY:-1h}

IP_FILE=${CONFIG_DIR}/dnsomatic.myip

# make sure we have a username and password
if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
    echo You must provide a USERNAME and PASSWORD
    exit 1
fi

cleanup () {
    kill -s SIGTERM $!
    exit 0
}

trap cleanup SIGINT SIGTERM

while true; do
    # fetch your current ip address
    NEW_IP=$(curl -s http://myip.dnsomatic.com/)
    OLD_IP=$(test -f "${IP_FILE}" && cat "${IP_FILE}")

    echo OLD IP: ${OLD_IP}
    echo NEW IP: ${NEW_IP}

    if [ "${NEW_IP}" = "${OLD_IP}" ]; then
        echo IP is still the same, not updating
    else
        echo Updating ${HOST} with ${NEW_IP}
        LOG=$(curl -s -u "${USERNAME}:${PASSWORD}" "https://updates.dnsomatic.com/nic/update?myip=${NEW_IP}&hostname=${HOST}&wildcard=${WILDCARD}&mx=${MX}&backmx=${BACKMX}")

        if echo $LOG | grep -q 'good'; then
            echo Successfully updated ${HOST} to ${NEW_IP}
            echo ${NEW_IP} > "${IP_FILE}"
        else
            echo Uh oh. Update failed with response...
            echo "${LOG}"
            break
        fi
    fi
    echo "Sleeping for ${DELAY}"
    sleep ${DELAY} & wait $!
done
