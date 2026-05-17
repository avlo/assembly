#import "../setup.asm"
//
// howto: loading prg
// more new
// another
//
// variant 1) from bash cli:
//      x64 -autoload ballmove-setup.prg
//    from c64:
//      run
//
// variant 2) from bash cli:
//      x64 -8 ballmove-setup.prg
//    from c64:
//      LOAD "ballmove-setup",8,1
//      run
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
