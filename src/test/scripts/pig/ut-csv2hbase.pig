-- load csv
A = LOAD 'hdfs:/user/hbase/dn/ut/ut-data-in.csv'
       USING PigStorage(',')
               AS (
        Custno:bytearray,
        firstname:chararray,
        lastname:chararray,
        age:int,
        profession:chararray);

-- add service columns

B = foreach A generate 
        Custno,
        CurrentTime(),
        firstname,
        lastname,
        age,
        profession);


-- save to hbase
STORE raw_data INTO 'hbase://ut'
        USING org.apache.pig.backend.hadoop.hbase.HBaseStorage(
        
'hk:key
 hs:update_time       
 d:firstname 
 d:lastname 
 d:age 
 d:profession'
);


