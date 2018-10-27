#!/bin/bash
base=`dirname $0`
create_wallet() {
    if [ -d ${base}/artifacts/${1} ]; then rm -rf ${base}/artifacts/${1}/*; else mkdir -p ${base}/artifacts/${1}; fi
    if [ -f ${base}/eosio-wallet/${1}.wallet ]; then rm -f ${base}/eosio-wallet/${1}.wallet; fi
    password=`cleos wallet create --to-console -n $1 | sed '{1,3d;s/"//g}'`
    echo $password > ${base}/artifacts/${1}/password
    cleos wallet import --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3 -n $1
    if [ $? -ne 0 ]; exit 1; fi
    cleos wallet private_keys -n $1 --password $password
}
if [ $# -eq 0 ]; then echo "usage:<wallet name>"; exit 1; fi
create_wallet $1