#importonce

  .const SCREEN_START = $0400  // The start of c64 screen memory
  .const SCREEN_DIRECT_START = SCREEN_START + $0000 // offset in screen memory to write
  .const PLOT_KERNAL_CURSOR = $fff0
  .const CURSOR_CHAR = $D1
  .const CHR_OUT = $ffd2

str_to_poke: .text  @"loaded start-module\$00"  // null terminated string to print

// write direct to screen memory
  ldx #0                  // use x reg as loop index start at 0
  
write_loop:
  lda str_to_poke,x         // put a byte from string into accum
  beq start                 // if the byte was 0 then we're done 
  sta SCREEN_DIRECT_START,x // Store the byte to screen
  inx                     // inc to next byte and next screen location 
  jmp write_loop          // Go back for next byte

start:
  clc // clear-carry status == CLEARED (see: README.md)
  jsr PLOT_KERNAL_CURSOR // if clc, set cursor (see: README.md)
  lda #CURSOR_CHAR
  jsr CHR_OUT // print char
//
// keyboard input
//
  stx $033c
  sty $033d
