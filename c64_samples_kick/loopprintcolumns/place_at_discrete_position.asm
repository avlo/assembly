#import "../basic-start.asm"

char_to_print: .byte $00
position: .byte $00

*=$1000 "Main Start"

main:
  jsr KERNAL_CLR_SCR

loop:
  lda char_to_print
  ldx position
  sta SCREEN_RAM_START, x
  sta $0500, x
  sta $0600, x
  sta $0700, x
  inc position
  
  inc char_to_print
  lda position
  bne loop
//  lda SCREEN_RAM_START
  rts

.label KERNAL_CLR_SCR = $E544  // addr Kernal clear screen
.label SCREEN_RAM_START = $0400 // 1024 decimal
.label SCREEN_RAM_END = $07E7 // 2047 decimal
.label KERNAL_SET_CURSOR = $fff0
.label KERNAL_CHR_OUT = $ffd2
