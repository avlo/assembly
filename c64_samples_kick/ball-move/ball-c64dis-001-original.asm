;****************************
;  JC64dis version 3.3-pre
;  
;  Source in Dasm format
;****************************

      processor 6502


      .org $0800

      brk                               
      asl  W0A08                        
      brk                               
      shx  $2820,y                      
      noop $30,x                        ; Pointer: BASIC starting arrays
      and  $2936,y                      
      brk                               
      brk                               
      brk                               
      ...                               
      ...                               
      ... ends at line 2047                               
      brk                               
      jsr  $E544                        ; Routine: Screen delete
      lda  #$93                         
      jsr  $FFD2                        ; Routine: Send a char in the channel
      ldx  #$0C                         
      ldy  #$01                         
W100C:
      clc                               
      jsr  $FFF0                        ; Routine: Read/Set (X,Y) cursor position
      lda  #$71                         
      jsr  $FFD2                        ; Routine: Send a char in the channel
      stx  $033C                        ; Tape I/O buffer
      sty  $033D                        ; Tape I/O buffer
W101B:
      jsr  $FFE4                        ; Routine: Take the char from keyboard buffer
      beq  W101B                        
      sta  $033E                        ; Tape I/O buffer
      ldx  $033C                        ; Tape I/O buffer
      ldy  $033D                        ; Tape I/O buffer
      clc                               
      jsr  $FFF0                        ; Routine: Read/Set (X,Y) cursor position
      lda  #$20                         
      jsr  $FFD2                        ; Routine: Send a char in the channel
      lda  $033E                        ; Tape I/O buffer
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

