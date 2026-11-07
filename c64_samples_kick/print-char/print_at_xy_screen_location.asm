#import "../basic-start.asm"

pos_x: .byte $28
pos_y: .byte $19
.label cursor_ptr = $1040

*=$1000 "Main Start" 
main:
  jsr reset_cursor
  jsr KERNAL_CLR_SCR
  
  lsr pos_x
  lsr pos_y
  
  ldy pos_x
  ldx pos_y
  
  jsr print_char
  
  rts

print_char:
  clc
  jsr KERNAL_SET_CURSOR
  lda cursor_ptr
  jsr KERNAL_CHR_OUT
  rts

reset_cursor:
  lda #CURSOR_CHAR_START
  sta cursor_ptr
  rts

.label KERNAL_CLR_SCR = $E544
.label KERNAL_CHR_OUT = $ffd2
.label KERNAL_SET_CURSOR = $fff0
.label CURSOR_CHAR_START = $d1
