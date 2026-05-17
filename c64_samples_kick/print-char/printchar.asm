BasicUpstart2(start)

* = $1000 "Print Char Program" // start address in memory. Here, $1000 (hexadecimal) corresponds to 4096 in decimal.

start:
    lda #$58            // load "X" into A (accumulator) register. note: accumulator register used for arithmetic / data operations
    jsr $ffd2           // jsr ROM function address $ffd2 prints character to screen
    rts                 // return from subroutine

// c64 usage:
//
// 1. load printchar-basicupstart2.prg into c64
// 2. execute below command at basic promt to run program (4096 decimal corresponds to $1000 hexadecimal, line 3):
//    SYS(4096) 
//
