#import "../basic-start.asm"

.label START_X = $00
.label START_Y = $00
.label NUM_COLS_X = $28 // 40 decimal
.label NUM_ROWS_Y = $19 // 25 decimal
.label remaining_x = $033e
.label remaining_y = $033f
accumulator_position: .byte $00
.label stored_position_x = $033c
.label stored_position_y = $033d

*=$1000 "Main Start" 
main:
  ldx #NUM_COLS_X
  stx remaining_x
  ldy #NUM_ROWS_Y
  sty remaining_y
  
//  lda #$93   // Load A with PETSCII $93 (clear screen)
//  jsr KERNAL_CHR_OUT  // Call KERNAL CHROUT: clear
  jsr KERNAL_CLR_SCR
  
  ldx #START_X
  stx stored_position_x
  ldy #START_Y
  sty stored_position_y
  jmp loop
  rts

loop:
  clc // if clc here...
  jsr KERNAL_SET_CURSOR // ...set cursor (see: README.md)
  lda #CURSOR_CHAR
  jsr KERNAL_CHR_OUT // print char

//  jmp clear_position

  inc stored_position_x
  dec remaining_x
  iny
  bne loop
  inc stored_position_x
  inx 
  bne loop
  rts  

clear_position:
  stx stored_position_x
  sty stored_position_y
  clc
  jsr KERNAL_SET_CURSOR // set cursor
  lda #CURSOR_CHAR
  jsr KERNAL_CHR_OUT // print char
  ldx stored_position_x
  ldy stored_position_y
  rts

// assembler constants for special addresses
.label KERNAL_CLR_SCR = $E544  // addr Kernal clear screen
.label KERNAL_CHR_OUT = $ffd2
.label KERNAL_SET_CURSOR = $fff0
.label CURSOR_CHAR = $D1 // circle cursor
