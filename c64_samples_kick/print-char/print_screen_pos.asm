// assembler constants for special addresses
  .const CLEAR_SCREEN_KERNAL_ADDR = $E544  // addr Kernal clear screen
  
  .const KERNAL_SET_CURSOR = $fff0
  .const KERNAL_CHR_OUT = $ffd2
  
  .const TEN_HEX = $0A // decimal 10, "(" ----> asl (shift left) decimal 80, $50, "P"
  .const CURSOR_BALL = $D1 // circle cursor
  .const CURSOR_UNDR = $C1 // underscore cursor
  
  .const MEMORY_POS_X = $0000
  .const MEMORY_POS_Y = $0002
  .const LAST_ROW_POS = $0004
  .const LAST_COL_POS = $0006

#import "../basic-start.asm"

*=$1000 "Main Start"
Main:
  jsr CLEAR_SCREEN_KERNAL_ADDR

// first round
  lda #TEN_HEX
  asl // shift left: 000A mult by 2 should put at row 20
  sta LAST_ROW_POS // store shifted pos to sta ROW_POS
  jsr setpositionx
  
  lda #TEN_HEX
  lsr  // shift right-> 000A div by 2 should put at column 5
  sta LAST_COL_POS // store shifted pos to sta COL_POS
  jsr setpositiony
//  note: ldy #MEMORY_POS_Y would load *VALUE* $0000 into Y
  jsr printchar_BALL
  
//// second round  
  lda #LAST_ROW_POS
  adc 1
  jsr setpositionx

  lda #LAST_COL_POS
  adc 1
  jsr setpositiony

  jsr printchar_UNDR
  rts  
  
printchar_UNDR:  
  clc
  jsr KERNAL_SET_CURSOR // if clc, set cursor (see: README.md)
  lda #CURSOR_UNDR
  jsr KERNAL_CHR_OUT
  rts
  
printchar_BALL:
  clc
  jsr KERNAL_SET_CURSOR // if clc, set cursor (see: README.md)
  lda #CURSOR_BALL
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
