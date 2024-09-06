init: 
    addi t3, x0, 8      # x limit
    addi t4, x0, 8      # y limit   

    la s1, pixel
    lw zero, 0(s1)      # clear word

    j led

inc:
    beq t0, t3, 8        # branch if >= t3 - pc +8 x
    addi t0, t0, 1       # x counter increase
    #beq t0, t3, 12

    beq t1, t4, -4       # branch if >= t4 - pc -4 y
    addi t1, t1, 1       # y counter increase

    j led

led:
    li a0, 0x100        # prepare our set-pixel ecall

    sh t0, 2(s1)        # store half word upper 2 bytes x axis
    #bge t0, t3, 12

    sh t1, 0(s1)        # store half word lower 2 bytes y axis
    #bge t1, t4, 4

    lw a1, 0(s1)        # load word to function register

    li a2, 0x00FFFFFF   # setting rgb value to white

    ecall               # enviroment call for our simulator
    j inc              # jump to main label

nop:
    nop

.data
pixel: .word 1 
pixels: .word 1, 0, 1, 0, 1