main:
  addi sp, sp, -1 
  addi t0, t0, -1
  sw t0, 0(s0)
  j main
