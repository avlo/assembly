#import "../setup.asm"
  jsr  $E544
  lda  #$93
  jsr  $FFD2
  ldx  #$0C
  ldy  #$01
W100C:
  clc  
  jsr  $FFF0
  lda  #$71
  jsr  $FFD2
  stx  $033C
  sty  $033D
W101B:
  jsr  $FFE4
  beq  W101B
  sta  $033E
  ldx  $033C
  ldy  $033D
  clc  
  jsr  $FFF0
  lda  #$20
  jsr  $FFD2
  lda  $033E
  cmp  #$11
  bne  W103D
  inx  
  jmp  W100C

W103D:
  cmp  #$1D
  bne  W1045
  iny  
  jmp  W100C

W1045:
  cmp  #$91
  bne  W104D
  dex  
  jmp  W100C

W104D:
  cmp  #$9D
  bne  W100C
  dey  
  jmp  W100C
  rts  
