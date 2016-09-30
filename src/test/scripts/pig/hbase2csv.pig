SOURCE = LOAD 'hbase://tableName'
       USING org.apache.pig.backend.hadoop.hbase.HBaseStorage(
       'cfName:name', '-loadKey true')
       AS (id:bytearray, name:chararray);

-- do some filtering or other manipulation here
STORE SOURCE INTO '/result_file' USING PigStorage('\t');


