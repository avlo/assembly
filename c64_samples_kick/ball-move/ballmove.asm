//////////////////////////////////////////////////////////////////////////////
// screencolors.asm
// Copyright(c) 2021 Neal Smith.
// License: MIT. See LICENSE file in root directory.
//////////////////////////////////////////////////////////////////////////////
// Sample c64 program that shows how to cycle through the screen and border
// colors with no regard for syncing with scan lines


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
//
// setup --------------------------------
//
    lda #$93
    jsr $ffd2 // print char
    ldx #$0c
    ldy #$1
//
// print ball at current pos ------------
//
    
start:
    clc
    jsr $fff0 // set cursor
    lda #$71
    jsr $ffd2 // print char
//
// keyboard input
//
    stx $033c
    sty $033d
    
loop1:
    jsr $ffe4 // getin
    beq loop1
    sta $033e
    //
    // clear ball at current pos -------------
    //
    ldx $033c
    ldy $033d
    clc
    jsr $fff0 // set cursor
    lda #$20
    jsr $ffd2 // print char
    //
    // set row and column --------------------
    //
    lda $033e
    cmp #$11 // check down
    bne right
    inx
    jmp start
    
right:
    cmp #$1d // check right
    bne up
    iny
    jmp start
    
up:
    cmp #$91 // check up
    bne left
    dex
    jmp start
    
left:    
    cmp #$9d // check left
    bne start
    dey
    jmp start
    rts
