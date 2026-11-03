#import "../basic-start.asm"

*=$1000 "Main Start"

main: 
  lda #$04 // load 04 into zero page ($03)
  sta $03
  lda #$00 // load 00 into zero page ($02)
  sta $02
  
  jsr KERNAL_CLR_SCR
  
  ldx #$04       
  ldy #$00
  lda ($02), y
  
loop:
  tya                       
  sta ($02), y   
  iny            
  bne loop
  inc $03
  dex
  bne loop
  rts

.label KERNAL_CLR_SCR = $E544  // addr Kernal clear screen
.label SCREEN_RAM_START = $0400 // 1024 decimal
.label SCREEN_RAM_END = $07E7 // 2047 decimal
