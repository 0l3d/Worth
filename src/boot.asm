#EVERY INSTRUCTION IS 16 BYTE
section code 
  mov 0, r0 
  mov 1025, r10 
  outb 9, r0 

  mov 0, r3

readBinaryHeaderFromDisk:
  inb 10, p2b0
  store p2b0, r10

  cmp r3, 56
  je CheckHeader 

  inc r3 
  inc r10
  
  jmp readBinaryHeaderFromDisk

CheckHeader:
  mov 1025, r11  # HEADER SIZE IS ALWAYS 56 BYTES
  # HEADER ALIGNMENT:
  #  uint64_t section_data -> 8 byte
  #  uint64_t section_bss -> 8 byte 
  #  uint64_t section_code -> 8 byte 
  #  uint64_t code_size -> 8 byte 
  #  uint64_t bss_size -> 8 byte
  #  uint64_t data_size -> 8 byte 
  #  uint64_t entry_start_point -> 8 byte

  add 24, r11 
  load r11, r12 
  add 24, r11 
  load r11, r14
  mov 0, r3

  print r12 
  print r14
  print r10

  mov 56, r0 
  outb 9, r0 

getKernelFromDisk:
  inb 10, p2b0 
  store p2b0, r10
  
  cmp r3, r12 
  je kernel_start 

  inc r10 
  inc r3

  jmp getKernelFromDisk

kernel_start:
  mov r10, r0 # stack pointer set to end 
  add 1025, r14
  print r14
  load r14, p13b0 
  print p13b0
  jmp r14
