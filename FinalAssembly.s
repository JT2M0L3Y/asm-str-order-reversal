
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
    movl    $0, %esi        # move 0 into esi to count characters
    leal    8(%esp,%ebx), %eax # load beginning address
    movl    %eax, 4(%esp)   # move the eax value into allocation of stack memory
    movl    $LC1, (%esp)    # read in the first character
    call    _scanf          # scan function
    incl    %esi            # increments character count by 1

    jmp     L2              # jump to loop comparison

L3:
    leal	8(%esp,%ebx), %eax      # A[ebx] into eax
	movl	%eax, 4(%esp)           # move the eax value into allocation of stack memory
	movl	$LC1, (%esp)            # read in the next character
	call	_scanf                  # reads in the character

    addl    $1, %ebx                # increment the counter
    incl    %esi                    # increments character count
    jmp     L2                      # jump to loop comparison
L2:
    cmpl    0x0a, %eax              # compare to ascii value of 10, which is the newline character
    jne     L3                      # Jump if not the newline character
    je      L5                      # Jump if newline character to begin backwards print

L4:
    

L5:
    movl    -1(%esi), %r1           # counter for start of word
    movl    -1(%esi), %r2           # counter for end of word

    testl   %r1, %r1                # test to see if end of word
    jle     L6                      # jump if end of word

    cmpb    $32, 8(%esp, %r1)       # if word is found
    jne     L7                      # decrement word start index

    leal    1(%r1), %eax            # set loop index to r1 (word start) + 1

    jmp     L8                      # while not at end of word, jump

L6:
   
L7:
    subb    $1, %r1                 # decrement the word start index

L8:

