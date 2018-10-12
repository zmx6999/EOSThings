#!/bin/bash
cleos push action thalice add '["thalice",1,"wear long hair"]' -p thalice
sleep 5
cleos push action thalice add '["thalice",2,"find a boy friend"]' -p thbob
sleep 5
cleos push action thalice add '["thbob",2,"set up a company"]' -p thbob
sleep 5
cleos push action thalice add '["thbob",3,"find a girl friend"]' -p thbob
sleep 5
cleos get table thalice thalice things
sleep 5
cleos get table thalice thbob things
sleep 5
cleos push action thalice toggle '["thbob",3]' -p thalice
sleep 5
cleos push action thalice toggle '["thbob",3]' -p thbob
sleep 5
cleos push action thalice toggle '["thbob",1]' -p thbob
sleep 5
cleos get table thalice thbob things
sleep 5
cleos push action thalice remove '["thbob",3]' -p thalice
sleep 5
cleos push action thalice remove '["thbob",3]' -p thbob
sleep 5
cleos push action thalice remove '["thbob",1]' -p thbob
sleep 5
cleos get table thalice thbob things