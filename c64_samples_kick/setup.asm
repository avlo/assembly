#importonce

setup:
// 10 SYS (4096)
*=$0800 "BASIC Start"
        .byte $00               // first byte of basic should be zero
        // These bytes are a one line basic program that will 
        // do a sys call to assembly language portion of
        // of the program which will be at $1000 or 4096 decimal
        // basic line is: 
        // 10 SYS (4096)
        .byte $0E, $08           // Forward address to next basic line
        .byte $0A, $00           // this will be line 10 ($0A)
        .byte $9E                // basic token for SYS
        .byte $20, $28,  $34, $30, $39, $36, $29 // ASCII for " (4096)"
        .byte $00, $00, $00      // end of basic program (addr $080E from above)

*=$1000 "Main Start"
Main:
        // assembler constants for special addresses
        .const CLEAR_SCREEN_KERNAL_ADDR = $E544  // addr Kernal clear screen
        // call kernal clear screen routine leave cursor upper left
        jsr CLEAR_SCREEN_KERNAL_ADDR
