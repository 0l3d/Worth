#EVERY INSTRUCTION IS 16 BYTE
section code 
  mov 0, r0 
  mov 1025, r10 
  outb 9, r0 

  mov 0, r3
getKernelfromdisk:
  
  inb 10, p2b0
  cmp p2b0, 0x30
  je kernel_end_check 

  store p2b0, r10
  inc r10
    
  jmp getKernelfromdisk

kernel_end_check:
  inb 9, r0  # PADDING 0x30 ... 7 bytes empty then, imm64 
  add 7, r0  # padding 
  outb 9, r0 
  inb 10, p2b0  
  cmp p2b0, 10 
  je kernel_start
  
  add 6, r0 
  outb 9, r0 

  jmp getKernelfromdisk

kernel_start:
  mov r10, r0 # stack pointer set to end 
  mov 1025, r10
  jmp r10 
