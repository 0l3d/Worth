section code
entry kernel_start
stack_overflow:
  hlt

stack_underflow:
  hlt 

stack_uoflow_controller:
  cmp r0, r4
  jg stack_underflow
  cmp r0, r3 
  jl stack_overflow 
  ret

kernel_start:
  mov 1010, r10 # kernel start debug 
  print r10
  print r0 # get end memory position coming from bootloader

  # creating a memory layout 
  # HEAP_START: 
  mov r0, r1
  add 2048, r0 
  mov r0, r2 
  # HEAP END 
  # HEAP: r1--between--r2 

  # STACK:
  mov r0, r3 
  add 1024, r0 
  mov r0, r4 
  # STACK: r3--between--r4 
  mov r4, r0 # setting stack pointer
  # now we can use stack

kernel_work: 
  push r10 
  mov 120, r10 
  print r10
  call stack_uoflow_controller
  pop r10
  print r10

kernel_draw: # r10 return val 
  inb 14, r8  # getting framebuffer address 
  inb 15, r7  # framebuffer size
  print r8 
  print r7
  mov 255, r6
  mov 0, r9 

loop_frame:
  cmp r9, r7 
  je kernel_halt
  
  store r6, r8 
  inc r9 
  inc r8
  jmp loop_frame

kernel_halt: 
  print r9
  info 10
