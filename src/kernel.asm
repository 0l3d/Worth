import "src/syscall.asm"

section code
kernel_start:
  mov 1010, r11 # kernel start debug 
  print r11

  add 10000, r0
  
  mov 200, r16
  push r16
  mov 250, r16
  push r16
  mov 256, r16
  push r16
  call kernel_draw

kernel_halt: 
  jmp kernel_halt
