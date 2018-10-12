#!/bin/bash

deploy_contract() {
    cd $1
    eosiocpp -o ${1}.wast ${1}.cpp
    if [ $? -ne 0 ]; then exit 1; fi
    eosiocpp -g ${1}.abi ${1}.cpp
    if [ $? -ne 0 ]; then exit 1; fi
    cd ..
    cleos set contract $2 $1
}

if [ $# -lt 2 ]; then echo "USAGE: <contract name> <account name>"; exit 1; fi
deploy_contract $1 $2