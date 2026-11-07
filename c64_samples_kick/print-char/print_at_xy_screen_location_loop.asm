#import "../basic-start.asm"
#import "module-wait.asm"

.label NUM_COLS_X = $27
.label NUM_ROWS_Y = $17
.label cursor_ptr = $1040

*=$1000 "Main Start" 
main:
  jsr reset_cursor
  
  jsr KERNAL_CLR_SCR
  clc
  ldx #$00
  ldy #$00
  
  jsr loop
  rts

loop:
  jsr print_char
//  jsr clear_position

  iny
  tya
  cmp #NUM_COLS_X
  bne loop
  
  clc
  ldy #$00
  inx
  txa
  cmp #NUM_ROWS_Y
  bne loop
  rts  

print_char:
//  jsr KERNAL_CLR_SCR
  
  clc
  jsr KERNAL_SET_CURSOR
  lda cursor_ptr
  jsr KERNAL_CHR_OUT
  
//  jsr wait_1_second
  
  clc
  adc #1
  sta cursor_ptr
  cmp #CURSOR_CHAR_END
  beq reset_cursor 
  rts

reset_cursor:
  lda #CURSOR_CHAR_START
  sta cursor_ptr
  rts

.label KERNAL_CLR_SCR = $E544  // addr Kernal clear screen
.label KERNAL_CHR_OUT = $ffd2
.label KERNAL_SET_CURSOR = $fff0
.label CURSOR_CHAR_START = $41 // A
.label CURSOR_CHAR_END = $5B // Z
//.label CURSOR_CHAR_CLEAR = $20 // heart cursor
