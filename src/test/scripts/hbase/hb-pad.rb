#!/bin/env hbase shell

create 'testtable', 'colfam1'

put 'testtable', 'myrow-1', 'colfam1:q1', 'value-1'
put 'testtable', 'myrow-2', 'colfam1:q2', 'value-2'
put 'testtable', 'myrow-2', 'colfam1:q3', 'value-3'

scan 'testtable'
get 'testtable', 'myrow-1'

delete 'testtable', 'myrow-2', 'colfam1:q2'

scan 'testtable'

describe 'testtable'
alter 'testtable', NAME => 'colfam2', VERSIONS => 50
describe 'testtable'


for i in '0'..'9' do \
for j in '0'..'9' do \
for k in '0'..'9' do \
put 'testtable', \
"row-#{i}#{j}#{k}", \
"colfam1:#{j}#{k}", \
"#{j}#{k}" \
end end end

scan 'testtable', {LIMIT=> 10}


for i in '0'..'9' do \
for j in '0'..'9' do \
for k in '0'..'9' do \
put 'testtable', \
"row-zzz", \
"colfam2:zzz", \
"#{j}#{k}" \
end end end

get 'testtable',  'row-zzz'


get 'testtable',  'row-zzz', {COLUMN => 'colfam2', VERSIONS=> 10}


t = get_table 'testtable'

t.flush
t.count
t.describe

t.scan({LIMIT=> 10})

t.scan({COLUMN=>'colfam2'})
t.scan({COLUMN=>'colfam1',LIMIT=> 10})

t.scan({COLUMN=>['colfam1:10','colfam1:20','colfam1:30']})

t.scan({COLUMN=>(1..12).map {|x| "colfam1:#{10+x}"}})



disable 'testtable'
drop 'testtable'

