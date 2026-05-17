BasicUpstart2(main) // autostart via BASIC "run" (in lieu of manual assembly SYS4096 command)
// assembler constants for special memory locations
  .const CLEAR_SCREEN_KERNAL_ADDR = $E544     // Kernal routine to clear screen
  .const SCREEN_START = $0400                 // The start of c64 screen memory
// offset in screen memory to write
  .const SCREEN_DIRECT_START = SCREEN_START + $0000 
// program variables
str_to_poke: .text  @"hello world assembly 3\$00"  // null terminated string to print
                                                 // via copy direct to screen memory
// assembly code will reside at this starting address
*=$1000 "Start"
main:
// clear screeen leave cursor upper left
  jsr CLEAR_SCREEN_KERNAL_ADDR 

// write direct to screen memory
  ldx #0                  // use x reg as loop index start at 0
  
write_loop:
  lda str_to_poke,x         // put a byte from string into accum
  beq border_loop                // if the byte was 0 then we're done 
  sta SCREEN_DIRECT_START,x // Store the byte to screen
  inx                     // inc to next byte and next screen location 
  jmp write_loop          // Go back for next byte
  
border_loop:
  inc $d020
  jmp border_loop
