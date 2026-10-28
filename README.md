<pre>
  # = immediate: immediate address(ing), ex:
    lda #$2a 
  loads accumulator value into (hex) memory address $2a 
</pre>
  
### number formats
| Prefix | Format  | Example |
|-------|---|---|
|  | Decimal | lda #42  |
| $ | Hexadecimal | lda #$2a |
| % | Binary | lda #%101010 |

----

### plot kernal routines

  - $FFF0 (65520) get/set cursor position based on carry-flag status
    - status == CLEARED
      - SET cursor position (row/col from regX/regY) accumulator value will be overwritten
    - status == SET 
      - GET cursor position (row/col into regX/regY) accumulator value preserved


