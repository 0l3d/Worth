section code
entry kernel_start
kernel_start:
  mov 1010, r11 # kernel start debug 
  print r11
  print r0 # get end memory position coming from bootloader

kernel_draw: # r10 return val 
  inb 14, r8  # getting framebuffer address 
  inb 15, r7  # framebuffer size
  print r8
  print r7
  mov 255, p6b0
  mov 0, r9 

loop_frame:
  cmp r9, r7
  je kernel_halt
  
  store p6b0, r8
  inc r9 
  inc r8
  jmp loop_frame

kernel_halt: 
  print r9
  info 10
