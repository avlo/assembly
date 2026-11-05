#import "../basic-start.asm"

.label DIVIDEND = $10
.label DIVISOR = $4
.label SCREEN_RAM_START = $0400 // 1024 decimal

*=$1000 "Main Start"

// Inputs:
//   dividend = number to divide
//   divisor  = number to divide by
//
// Outputs:
//   quotient  = dividend / divisor
//   remainder = dividend % divisor
//   div_error = 1 if divisor is zero, otherwise 0

start:
  lda #DIVIDEND
  sta dividend
  lda #DIVISOR
  sta divisor
  jsr divide
  lda quotient
  sta SCREEN_RAM_START, x
  rts

divide:
  lda #0
  sta quotient
  sta div_error

  lda divisor
  beq division_by_zero

  lda dividend
  sta remainder

divide_loop:
  lda remainder
  cmp divisor
  bcc division_done       // Remainder < divisor

  sec
  sbc divisor
  sta remainder

  inc quotient
  jmp divide_loop

division_done:
  rts

division_by_zero:
  lda #1
  sta div_error
  rts

dividend:   .byte 0
divisor:    .byte 0
quotient:   .byte 0
remainder:  .byte 0
div_error:  .byte 0
