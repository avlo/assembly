#import "../basic-start.asm"

*=$1000 "Main Start"

main:
  jsr KERNAL_CLR_SCR
  ldx #$00                   // load 0 into x
  
loop:
  txa                       // xfer x to accum
  sta SCREEN_RAM_START, x   // store accum value + x offset into screen position
  sta $0500, x
  sta $0600, x
  sta $0700, x
  inx                       // add 1 to position
  bne loop
  rts

.label KERNAL_CLR_SCR = $E544  // addr Kernal clear screen
.label SCREEN_RAM_START = $0400 // 1024 decimal
.label SCREEN_RAM_END = $07E7 // 2047 decimal
.label KERNAL_SET_CURSOR = $fff0
.label KERNAL_CHR_OUT = $ffd2
