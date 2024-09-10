
# compressed extension support
.option rvc

# -----------------------------------------------------------------------------
#   Register constants for a few hardware ports
# -----------------------------------------------------------------------------

.equ characters,    0x10000000
.equ font,          0x20000000
.equ color_n,       0x40004000

.equ char_limit,    500

# newline macro
.macro nl label
    addi x17, x17, 1
    j \label
.endm

# x16: Display X
# x17: Display Y
# x18: Character buffer position
li x16, 0               # Display X : 0
li x17, 0               # Display Y : 0
li x18, characters      # Character buffer

la t4, color_n
li t3, 0x0000F0FF
sw t3, 0(t4)

li t0, char_limit

la x8, meow     # pointer to meow string

j putc

inc:
    la x8, meow     # pointer to meow string

    # advance address, x position, character
    addi x18, x18, 1
    addi x16, x16, 1
    addi t1, t1, 1  # character counter
    add x8, x8, t1  # sum of base address + counter
    
    bge t1, t0, clear  # if x16 is greater or equal than character limit go to empty loop

    j putc

clear:
    nop
    j clear

putc:
    lb x8, 0(x8)
    sb x8, 0(x18)

    j inc

meow: .string "meow :3 meow mrrp nyaaa meow mrrppp :3333 meow. meow :3 meow mrrp nyaaa meow mrrppp :3333 meow. meow :3 meow mrrp nyaaa meow mrrppp :3333 meow. meow :3 meow mrrp nyaaa meow mrrppp :3333 meow. "
