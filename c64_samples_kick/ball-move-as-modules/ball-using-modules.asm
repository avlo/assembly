#import "../setup.asm"
//
// howto: loading prg
// more new
// another
//
// variant 1) from bash cli:
//      x64 -autoload ball.prg
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
    lda #$93   // Load A with PETSCII $93 (clear screen)
    jsr $ffd2  // Call KERNAL CHROUT: clear screen and move cursor home
    ldx #$0c   // Set X to 12 (intended cursor row)
    ldy #$01   // Set Y to 1 (intended cursor column)
//
// print ball at current pos ------------
//
    
#import "start-module.asm"
    
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
