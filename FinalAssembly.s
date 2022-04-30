
    This program takes in input of a sentence, and then prints
    it in reverse order.

LC0:
    .ascii "Enter in any sentence: \0"
LC1:
    .ascii %[^\n]\0


    .globl _main
    .def    _main;  .scl    2;  .type   32; .endef

_main:

    pushl   %ebp            # Standard Call entrance
    movl    %esp, %ebp      # moving the base pointer to top of stack pointer

    pushl   %ebp

    movl    $LC0, (%esp)
    call    _printf




