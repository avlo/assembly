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
  .label MEMORY_PETSCII_CHAR = $0805 

#import "../basic-start.asm"

*=$1000 "Main Start" 
Main:
  jsr KERNAL_CLRSCR
  
// first round
  lda #TEN_HEX // # is "immediate" mode, aka- load actual number $0A into accum
  asl // shift left: 000A mult by 2 should put at row 20
  sta ROW_POS // store shifted pos to sta ROW_POS
  jsr setpositionx
  
  lda #TEN_HEX
  lsr  // shift right-> 000A div by 2 should put at column 5
  sta COL_POS // store shifted pos to sta COL_POS
  jsr setpositiony
  
//  note: ldy #MEMORY_POS_Y would load *VALUE* $0000 into Y
  lda #PETSCII_BALL
  sta MEMORY_PETSCII_CHAR
  jsr printchar
  
// second round
  inc ROW_POS 
  lda ROW_POS // without "#" should be absolute mode, aka- load value at memory address ROW_POS into accum
  jsr setpositionx

  inc COL_POS
  lda COL_POS // without "#" should be absolute mode, aka- load value at memory address COL_POS into accum
  jsr setpositiony

  lda #PETSCII_SPADE
  sta MEMORY_PETSCII_CHAR
  jsr printchar
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

printchar:
  clc
  jsr KERNAL_SET_CURSOR // if clc, set cursor (see: README.md)
  lda MEMORY_PETSCII_CHAR
  jsr KERNAL_CHR_OUT
  rts
