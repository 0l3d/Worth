section code 
  mov 0, r0 
  mov 1025, r1 
  outb 9, r0 

  mov 0, r3
get1023bytesfromdisk:
  
  cmp r3, 1023 
  je kernel_start 

  inb 10, r2 
  store r2, r1 
  inc r1 
  inc r3 
    
  jmp get1023bytesfromdisk

kernel_start:
  mov r1, r0 # stack pointer set to end 
  mov 1025, r1 
  jmp r1 
