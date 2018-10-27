#!/bin/bash
base=`dirname 0`
unlock_wallet() {
    password=`cat ${base}/artifacts/${1}/password`
    cleos wallet unlock -n $1 --password $password
    cleos wallet list
}
if [ $# -eq 0 ]; then echo "usage:<wallet name>"; exit 1; fi
unlock_wallet $1