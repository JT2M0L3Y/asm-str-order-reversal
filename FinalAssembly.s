
#This program takes in input of a sentence, and then prints
#it in reverse order.

LC0:
    .ascii "Enter in any sentence: \0"
LC1:
    .ascii "%c\0"

    .globl _main
    .def    _main;  .scl    2;  .type   32; .endef

_main:

    pushl   %ebp            # Standard Call entrance
    movl    %esp, %ebp      # moving the base pointer to top of stack pointer

    pushl   %ebp            # save value of esp inside of the stack

    pushl   %edi            # push edi to stack
    pushl   %esi            # push esi to stack
    pushl   %ebx            # push ebx to stack

	subl	$240, %esp      # allocate memory for stack

    movl    $LC0, (%esp)    # move prompt into stack
    call    _printf         # print 

    leal    124(%esp), %ebx # stores address of first array element in base
    movl    %ebx, (%esp)    # moves address of first array element into stack pointer
    call    _gets           # reads in until new line character detected


