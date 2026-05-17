BasicUpstart2(start)
/*
5 *=$1000
100 loop jsr $ffe4 ! get char
110 beq loop
999 rts
*/
* = $1000 "Input Char Program" // start address in memory. Here, $1000 (hexadecimal) corresponds to 4096 in decimal.

start:
    jsr $ffe4 // get char
    beq start
    rts            // return from subroutine

// c64 usage:
//
// 1. load <program_name>.prg into c64
// 2. execute below command at basic promt to run program (4096 decimal corresponds to $1000 hexadecimal, line 3):
//    SYS(4096) 
//
