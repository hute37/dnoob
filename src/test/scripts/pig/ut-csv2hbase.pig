-- env
%default JOB_TIME `date +%Y%m%d%H%M%S`;

-- load csv
A = LOAD 'hdfs:/user/hbase/dn/ut/ut-data-in.csv'
       USING PigStorage(',')
               AS (
        Custno:bytearray,
        firstname:chararray,
        lastname:chararray,
        age:int,
        profession:chararray);

-- skip CSV Header
C = FILTER A BY (chararray) Custno != 'Custno';

-- add service columns
B = FOREACH C {
        current_date = ToString(CurrentTime(),'yyyy-MM-dd');
        id = CONCAT('ID-', (chararray) Custno);
        GENERATE (
                id,
                current_date,
                '$JOB_TIME',
                firstname,
                lastname,
                age,
                profession);
        }

-- save to hbase
STORE B INTO 'hbase://ut'
        USING org.apache.pig.backend.hadoop.hbase.HBaseStorage(
        
'hk:key
 hs:update_time       
 hs:job_time       
 d:firstname 
 d:lastname 
 d:age 
 d:profession'
);

-- export hbase table to hdfs
-- fs -rm -r /user/hbase/dn/ut/ut-data-out.tsv
O = LOAD 'hbase://ut'
       USING org.apache.pig.backend.hadoop.hbase.HBaseStorage(
       'hk:key hs:* d:*', '-loadKey true')
       AS (key:chararray, hs:map[], d:map[]);

STORE O INTO 'hdfs:/user/hbase/dn/ut/ut-data-out.tsv'
        USING PigStorage('\t');

