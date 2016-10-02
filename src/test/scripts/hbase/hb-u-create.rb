#!/bin/env hbase shell

disable 'ut'
drop 'ut'


create 'ut', \
       {NAME => 'hk', VERSIONS => 50}, \
       {NAME => 'hs', VERSIONS => 50}, \
       {NAME => 'd',  VERSIONS => 10}


describe 'ut'

scan 'ut', {LIMIT=> 10}



