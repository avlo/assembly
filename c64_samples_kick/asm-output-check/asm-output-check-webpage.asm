// assembler constants for special addresses
  .const CLEAR_SCREEN_KERNAL_ADDR = $E544  // addr Kernal clear screen

#import "../basic-start.asm"

*=$1000 "Main Start"
main:
  jsr CLEAR_SCREEN_KERNAL_ADDR
  ldx     #1
  lda     #72
LBB0_1:
  cmp     #10
  beq     LBB0_4
LBB0_2:
  jsr     65490
  lda     Lstr,x
  inx
  cpx     #13
  bne     LBB0_1
  lda     #13
  jsr     65490
  rts
LBB0_4:
  lda     #13
  jmp     LBB0_2

Lstr:
  .text	@"HELLO, 6502!"

// .text  @"hello direct\$00"  
