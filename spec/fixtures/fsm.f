--00 init0 init1 00
--01 init4 IOwait 01
--1- init1 init2 10
-01- IOwait init2 01
-111 init4 init4 10
000- IOwait IOwait 01
0001 read0 read1 11
0010 RMACK RMACK 11
0010 read1 IOwait 01
0100 init1 init1 00
0100 write0 IOwait 01
0110 IOwait read0 00
0111 IOwait RMACK 11
0111 RMACK read0 00
1-10 init2 init4 10
100- IOwait init1 01
1001 WMACK write0 01
1100 IOwait write0 11
1100 WMACK WMACK 00
1101 IOwait WMACK 00
