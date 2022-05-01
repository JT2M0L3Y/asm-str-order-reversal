
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

    movl    $LC0, (%esp)    # Asks user for input
    call    _printf         # prints Enter in any sentence        

    movl    $0, %ebx        # move 0 to ebx for incrementing
    movl    $0, %eax        # move 0 to eax to ensure we start at right place

    jmp     L2              # jump to loop comparison


L3:
    leal	8(%esp,%ebx), %eax      # A[ebx] into eax
	movl	%eax, 4(%esp)           # move the eax value into allocation of stack memory
	movl	$LC1, (%esp)            # read in the next character
	call	_scanf                  # reads in the character

    addl    $1, %ebx                # increment the counter 
    jmp     L2
L2:
    cmpb    0x0a, %al                # compare to ascii value of 10, which is the newline character
    jne      L3                      # Jump if is the newline character

    leave
    ret
