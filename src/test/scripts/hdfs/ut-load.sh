#|/bin/bash


mkdir -p ./dn/ut

cat > ./dn/ut/ut-data-in.csv <<EOF
Custno, firstname, lastname, age, profession
4000001,Kristina,Chung,55,Pilot
4000002,Paige,Chen,74,Teacher
4000003,Sherri,Melton,34,Firefighter
4000004,Gretchen,Hill,66,Computer hardware engineer
4000005,Karen,Puckett,74,Lawyer
4000006,Patrick,Song,42,Veterinarian
4000007,Elsie,Hamilton,43,Pilot
4000008,Hazel,Bender,63,Carpenter
4000009,Malcolm,Wagner,39,Artist
4000010,Dolores,McLaughlin,60,Writer
4000011,Francis,McNamara,47,Therapist
4000012,Sandy,Raynor,26,Writer
4000013,Marion,Moon,41,Carpenter
4000014,Beth,Woodard,65,
4000015,Julia,Desai,49,Musician
4000016,Jerome,Wallace,52,Pharmacist
4000017,Neal,Lawrence,72,Computer support specialist
4000018,Jean,Griffin,45,Childcare worker
4000019,Kristine,Dougherty,63,Financial analyst
EOF



hdfs dfs -rm -r    dn/ut
hdfs dfs -mkdir -p dn/ut

hdfs dfs -put  ./dn/ut/ut-data-in.csv dn/ut/ut-data-in.csv
hdfs dfs -ls -R  dn/ut




