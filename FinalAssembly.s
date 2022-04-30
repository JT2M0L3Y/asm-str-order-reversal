
#This program takes in input of a sentence, and then prints
#it in reverse order.

LC0:
    .ascii "Enter in any sentence: \0"
LC1:
    .ascii "%[^\n]\0"


    .globl _main
    .def    _main;  .scl    2;  .type   32; .endef

_main:

    pushl   %ebp            # Standard Call entrance
    movl    %esp, %ebp      # moving the base pointer to top of stack pointer

    pushl   %ebp            # save value of esp inside of the stack

    movl    $LC0, (%esp)    # Asks user for input
    call    _printf         # prints Enter in any sentence

    movl    $LC1, (%esp)    # gets input from the user
    call    _scanf          

    movl    $0, %ebx        # move 0 to ebx for incrementing
    jmp     L2              # jump to loop comparison


L3:



L2:
    li      $t1, 10
    beq     $t0, $t1, L3

