#!/bin/bash

dir=`dirname $0`

create_account() {
    keypath=${dir}/artifacts/$1
    if [ ! -d $keypath ]; then mkdir $keypath; fi

    keypair=(`cleos create key --to-console | awk -F: '{print $2}'`)
    echo ${keypair[0]} > ${keypath}/private.pem
    echo ${keypair[1]} > ${keypath}/public.pem
    cleos wallet import -n $2 --private-key ${keypair[0]}
    if [ $? -ne 0 ]; then exit 1; fi

    cleos create account eosio $1 ${keypair[1]}
}

if [ $# -lt 2 ]; then echo "USAGE: <account name> <wallet name>"; exit 1; fi
create_account $1 $2