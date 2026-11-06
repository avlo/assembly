#importonce

// Wait about 1 second using CIA 1 Timer A.
// Clobbers A.
// Preserves X and Y.

*=$1050 "Wait Start"

wait_1_second:
  jsr store_registers
  lda #$00
  sta $DC0E           // Stop Timer A
  sta $DC04           // Timer A low byte
  sta $DC05           // Timer A high byte
  lda #$01
  sta $DC0E           // Start Timer A

  ldx #50             // 50 × roughly 1/50 second
wait_loop:
  lda $DC0D           // Read CIA interrupt control/status
  and #$01            // Timer A underflow?
  beq wait_loop

  lda #$01
  sta $DC0D           // Clear Timer A interrupt flag
  dex
  bne wait_loop

  lda #$00
  sta $DC0E           // Stop Timer A
  jsr restore_registers
  rts

store_registers:
  pha
  txs
  tya
  pha
  rts

restore_registers:
  pla
  tay
  tsx
  pla
  rts  
