#EVERY INSTRUCTION IS 16 BYTE
#ROMSIZE 10KB
section code
  in 0x8, r10 # getting rom size
  print r10
  mov 0, r0 
  out 0x9, r0 

  mov 0, r3

readBinaryHeaderFromDisk:
  in 0xA, p2b0
  store p2b0, r10

  cmp r3, 56
  je CheckHeader 

  inc r3 
  inc r10
  
  jmp readBinaryHeaderFromDisk

CheckHeader:
  in 0x8, r11  # HEADER SIZE IS ALWAYS 56 BYTES
  # HEADER ALIGNMENT:
  #  uint64_t section_data -> 8 byte
  #  uint64_t section_bss -> 8 byte 
  #  uint64_t section_code -> 8 byte 
  #  uint64_t code_size -> 8 byte 
  #  uint64_t bss_size -> 8 byte
  #  uint64_t data_size -> 8 byte 
  #  uint64_t entry_start_point -> 8 byte

  add 16, r11 
  load r11, r16
  add 8, r11 
  load r11, r12
  add 24, r11 
  load r11, r14
  mov 0, r3

  print r12 
  print r14
  print r10

  mov 56, r0 
  out 0x9, r0

getKernelFromDisk:
  in 0xA, p2b0 
  store p2b0, r10
  
  cmp r3, r12 
  je kernel_start 

  inc r10 
  inc r3

  jmp getKernelFromDisk

kernel_start:

  # SETTING FRAME BUFFER
  mov 0xFFFF, r15 
  out 0xF, r15 
  add 0x27FF, r15 
  out 0xE, r15
  # SETTING FRAMEBUFFER


  cmp r14, 0 
  je kernel_code_sectioner

  mov r10, r0 # stack pointer set to end 
  mov 0, r10 
  in 0x8, r10 
  add r14, r10

  jmp r10

kernel_code_sectioner:
  in 0x8, r10
  add r16, r10 
  jmp r10
