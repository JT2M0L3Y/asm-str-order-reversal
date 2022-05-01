LC0:
	.ascii "Enter any string: \12\0"
LC2:
	.ascii " \12%s\0"

	.globl	_main
	.def	_main
_main:
	pushl	%ebp

	movl	%esp, %ebp

	pushl	%edi
	pushl	%esi
	pushl	%ebx
	
	andl	$-16, %esp
	subl	$224, %esp

	movl	$LC0, (%esp)							# output directions
	call	_printf

	leal	124(%esp), %ebx

	movl	%ebx, (%esp)
	call	_gets

	movl	$0, %eax
	movl	$-1, %ecx
	movl	%ebx, %edi
	repnz scasb
	movl	%ecx, %eax
	notl	%eax
	leal	-2(%eax), %esi
	movl	%esi, %ebx

	movl	$0, %edx
	jmp	L2

L5:
	movzbl	124(%esp,%eax), %ecx
	movb	%cl, 24(%esp,%edx)
	# increment i and index
	addl	$1, %eax
	addl	$1, %edx
L4:
	cmpl	%ebx, %eax								# inner loop
	
	jle	L5
	
	movb	$32, 24(%esp,%edx)
	# 
	leal	-1(%esi), %ebx
	leal	1(%edx), %edx
L3:
	# word start decrement
	subl	$1, %esi
L2:
	testl	%esi, %esi                              # outer loop comparison (C_code line 23)
	
	jle	L10									        # end of loop (jump to line 46 in C_code)
	
	cmpb	$32, 124(%esp,%esi)						# if statement
	
	jne	L3 										        # jump to word start decrement (line 42)
	
	leal	1(%esi), %eax                           # set i to wordStart + 1 (line 29 C_code)
	
	jmp	L4									        # jump to inner loop (line 30 C_code)

L10:
	movl	$0, %eax
	
	jmp	L7

L8:
	movzbl	124(%esp,%eax), %ecx
	movb	%cl, 24(%esp,%edx)
	# increment i and index vars
	addl	$1, %edx
	addl	$1, %eax
L7:
	cmpl	%ebx, %eax								# comparison->for loop
	
	jle	L8

	movb	$0, 24(%esp,%edx)

	leal	24(%esp), %eax 							# move to reverse location
	movl	%eax, 4(%esp)

	movl	$LC2, (%esp) 							# reverse string
	call	_printf

	movl	$0, %eax
	leal	-12(%ebp), %esp

	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp

	ret
