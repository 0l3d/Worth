# EVERY INSTRUCTION IS 16 BYTE
section code 
  mov 0, r0 
  mov 1025, r1 
  outb 9, r0 

  mov 0, r3
get1023bytesfromdisk:
  
  cmp r3, 1023 
  je kernel_start 

  inb 10, r2
  cmp r2, 0x30
  je kernel_end_check 

  store r2, r1 
  inc r1 
  inc r3 
    
  jmp get1023bytesfromdisk

kernel_end_check:
  inb 9, r0  # PADDING 0x30 ... 7 bytes empty then, imm64 
  add 7, r0  # padding 
  outb 9, r0 
  inb 10, r2 
  cmp r2, 10 
  je kernel_start
  
  add 6, r0 
  outb 9, r0 

  jmp get1023bytesfromdisk

kernel_start:
  mov r1, r0 # stack pointer set to end 
  mov 1025, r1 
  jmp r1 
