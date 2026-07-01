section code
# Arguments:
# 1 -> X
# 2 -> Y
# 3 -> height
# All of them must be PUSHED to STACK.
kernel_draw:
  pop r11 # function ret pos, we will push it again when using ret
  pop r18 # getting third argument 
  pop r17 # getting middle argument 
  pop r16 # getting first one 

  push r13     # saving user registers (actual memory pos)
  push r14     # saving user registers (framebuffer start)
  push r15     # saving user registers (framebuffer size)
  inb 14, r14  # framebuffer pos 
  inb 15, r15  # framebuffer size
  
  # calculating actual memory pos
  mov 0, r13 
  add r14, r13 
  mul r18, r17
  print r17
  add r16, r17
  print r17
  add r17, r13 
  # basically: 
  # POS(x, y) = y * WINDOW_HEIGHT + x
  # Memory is a linear block. So we need to calculate actual position of the pixel.
  # Lets explain the math:
  # For example: x = 100, y = 50, HEIGHT=256 
  # (y * HEIGHT) = 50 * 256, that means: we need to go through 256 bytes of memory 50 times.
  # We ve reached position P, but we re at its beginning
  # We need to add an offset X to P to write to the desired location. 
  

  print r13        # debug 
  mov 255, p15b0   # color (white for test)
  store p15b0, r13 # writing to memory.

  pop r15      # pop user register
  pop r14      # pop user register 
  pop r13      # pop user register.

  push r11     # pushing actual ret adress again for ret.
  ret          # return 
