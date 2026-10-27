import "src/syscall.asm"

section code
kernel_start:
  # set stack 10k bytes 
  add 50000, r0

  mov 1010, r11 # kernel start debug 
  print r11  
  mov 50, r20 
  mov 50, r21 

  mov 0, r23 

key_control:
  in 11, r9

  cmp 'a', r9
  je circle_loop_i

  jmp key_control

circle_loop_i:
  cmp r23, 201
  je circle_end_i

  mov 0, r24  

circle_loop_j:
  cmp r24, 201
  je circle_end_j

  mov r23, r26
  mov r23, r29
  mul r29, r26

  mov r24, r27
  mov r24, r29
  mul r29, r27

  add r27, r26

  mov 10000, r29
  add r29, r26

  mov r23, r28
  add r24, r28

  mov 200, r29
  mul r29, r28 

  cmp r26, r28
  jg skip_pixel

  mov r20, r12
  add r24, r12
  
  mov r21, r13
  add r23, r13

  mov 256, r14 

  push r12    
  push r13     
  push r14     
  
  call kernel_draw 

skip_pixel:
  inc r24    
  jmp circle_loop_j

circle_end_j:
  inc r23     
  jmp circle_loop_i

circle_end_i:
  print r9

kernel_halt: 
  jmp kernel_halt
