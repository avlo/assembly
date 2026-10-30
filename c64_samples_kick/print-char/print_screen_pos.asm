// assembler constants for special addresses
  .label KERNAL_CLRSCR = $E544  // addr Kernal clear screen
  .label KERNAL_SET_CURSOR = $fff0
  .label KERNAL_CHR_OUT = $ffd2
  .label PETSCII_BALL = $D1 // circle character
  .label PETSCII_SPADE = $C1 // spade character
  
  
  .label ZERO = $00
  .label TEN_HEX = $0A // decimal 10, "(" ----> asl (shift left) decimal 80, $50, "P"
  .label ROW_POS = $0801
  .label COL_POS = $0802
  .label MEMORY_POS_X = $0803
  .label MEMORY_POS_Y = $0804

#import "../basic-start.asm"

*=$1000 "Main Start" 
Main:
  jsr KERNAL_CLRSCR
  
// first round
  lda #TEN_HEX // # is "immediate" mode, aka- load actual number $0A into a
  asl // shift left: 000A mult by 2 should put at row 20
  sta ROW_POS // store shifted pos to sta ROW_POS
  jsr setpositionx
  
  lda #TEN_HEX
  lsr  // shift right-> 000A div by 2 should put at column 5
  sta COL_POS // store shifted pos to sta COL_POS
  jsr setpositiony
  
//  note: ldy #MEMORY_POS_Y would load *VALUE* $0000 into Y
  jsr printchar_ball
  
// second round
  inc ROW_POS // without "#" should be absolute mode, aka- load value at memory address ROW_POS
  lda ROW_POS
  jsr setpositionx

  inc COL_POS
  lda COL_POS
  jsr setpositiony

  jsr printchar_spade
  rts  
  
printchar_spade:
  clc
  jsr KERNAL_SET_CURSOR // if clc, set cursor (see: README.md)
  lda #PETSCII_SPADE
  jsr KERNAL_CHR_OUT
  rts
  
printchar_ball:
  clc
  jsr KERNAL_SET_CURSOR // if clc, set cursor (see: README.md)
  lda #PETSCII_BALL
  jsr KERNAL_CHR_OUT
  rts  
  
setpositionx:
  clc
  sta MEMORY_POS_X
  ldx MEMORY_POS_X
  rts
  
setpositiony:
  clc
  sta MEMORY_POS_Y
  ldy MEMORY_POS_Y
  rts
