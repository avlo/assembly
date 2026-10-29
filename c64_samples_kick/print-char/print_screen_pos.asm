// assembler constants for special addresses
  .const CLEAR_SCREEN_KERNAL_ADDR = $E544  // addr Kernal clear screen
  
  .const KERNAL_SET_CURSOR = $fff0
  .const KERNAL_CHR_OUT = $ffd2
  
  .const COL_POS = $000A // decimal 10, "(" ----> asl (shift left) decimal 80, $50, "P"
  .const ROW_POS = $000A // decimal 25
  .const CURSOR_CHAR = $D1 // circle cursor
  
  .const RAM_START_ADDRESS = $0000
  .const RAM_START_ADDRESS_NEXT = $0002

#import "../basic-start.asm"

*=$1000 "Main Start"
Main:
  jsr CLEAR_SCREEN_KERNAL_ADDR

  clc
  lda #ROW_POS
  jsr setpositionx
    
  clc
  lda #COL_POS
  lsr  // shift right-> 000A div by 2 should put at column 5
  sta RAM_START_ADDRESS
  ldy RAM_START_ADDRESS // load value at RAM
//  note: ldy #RAM_START_ADDRESS would load *VALUE* $0000 into Y

  jsr printchar
  rts  
  
printchar:  
  clc
  jsr KERNAL_SET_CURSOR // if clc, set cursor (see: README.md)
  lda #CURSOR_CHAR
  jsr KERNAL_CHR_OUT
  rts
  
setpositionx:  
  asl // shift left: 000A mult by 2 should put at row 20  
  sta RAM_START_ADDRESS_NEXT
  ldx RAM_START_ADDRESS_NEXT
  rts  
  
//  sta RAM_START_ADDRESS
//  ldy #RAM_START_ADDRESS   // Set Y to 1 (intended cursor column)
//  
//  lda ROW_POS
////  asl 
//  sta RAM_START_ADDRESS_NEXT
//  ldx #RAM_START_ADDRESS_NEXT   // Set X to 12 (intended cursor row)
  rts
