#import "../basic-start.asm"

.const SCREEN_COLS = $02                // chars across
.const SCREEN_ROWS = $02                // chars down

position_x: .byte $00
position_y: .byte $00
cursor_ptr: .byte CURSOR_CHAR

*=$1000 "Main Start"

main:
  jsr KERNAL_CLR_SCR
  ldx #SCREEN_COLS    //using x register as column counter
  ldy #SCREEN_ROWS
  
loop:
  jsr print_char_xy
  lda position_x
  clc
  adc #01     
  dex
  bne loop     //if not x >= 5, loop again
  
//  ldx #$01
//  iny
//  sty position_y
//  cpy #SCREEN_ROWS
//  bne loop
  rts

print_char_xy:
  .var screen_addr = SCREEN_RAM_START + (position_y * SCREEN_COLS) + position_x
  lda cursor_ptr      // put a byte from string into accum
  sta $0400, x        // Store the byte to screen
  rts

.label KERNAL_CLR_SCR = $E544  // addr Kernal clear screen
.label SCREEN_RAM_START = $0400 // 1024 decimal
.label CURSOR_CHAR = $d1 // circle cursor
