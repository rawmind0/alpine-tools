#!/usr/bin/env sh

function checkError {
        if [ $1 -ne 0 ]; then
                echo "ERROR"
                exit $1
        fi
        echo "OK"
}

./start.sh

CURRENT_FULL=$(confd -version)
checkError $?

CURRENT_VERSION=$(echo ${CURRENT_FULL} | cut -d" " -f2)

if [ "$CURRENT_VERSION" != "$CONFD_VERSION"]; then
        echo "ERROR got $CURRENT_VERSION expected $CONFD_VERSION"
        exit 1
fi

echo "OK"
exit 0