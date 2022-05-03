
LC0:
	.ascii "Enter any string: \0"
LC1:
	.ascii "Original string \12%s\12\12\0"
LC2:
	.ascii "Reverse ordered words \12%s\0"

	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef

_main:

	pushl	%ebp

	movl	%esp, %ebp

	andl	$-16, %esp
	subl	$80, %esp

	movl	$LC0, (%esp)
	call	_printf
	leal	40(%esp), %eax
	movl	%eax, (%esp)
	call	_gets

	leal	40(%esp), %eax
	movl	%eax, (%esp)
	call	_strlen

	movl	%eax, 60(%esp)
	movl	$0, 72(%esp)
	movl	60(%esp), %eax
	subl	$1, %eax
	movl	%eax, 68(%esp)
	movl	60(%esp), %eax
	subl	$1, %eax
	movl	%eax, 64(%esp)
	jmp	L2

L6:
	leal	40(%esp), %edx
	movl	68(%esp), %eax
	addl	%edx, %eax

	movl	(%eax), %eax
	cmpb	$32, %al
	jne	L3

	movl	68(%esp), %eax
	addl	$1, %eax
	movl	%eax, 76(%esp)
	jmp	L4

L5:
	leal	40(%esp), %edx
	movl	76(%esp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax

	leal	20(%esp), %ecx
	movl	72(%esp), %edx
	addl	%ecx, %edx
	movb	%al, (%edx)
	addl	$1, 76(%esp)
	addl	$1, 72(%esp)

L4:
	movl	76(%esp), %eax
	cmpl	64(%esp), %eax
	jle	L5

	movl	72(%esp), %eax
	leal	1(%eax), %edx
	movl	%edx, 72(%esp)
	movb	$32, 20(%esp,%eax)
	movl	68(%esp), %eax
	subl	$1, %eax
	movl	%eax, 64(%esp)

L3:
	subl	$1, 68(%esp)
L2:
	cmpl	$0, 68(%esp)
	jg	L6
	movl	$0, 76(%esp)
	jmp	L7

L8:
	leal	40(%esp), %edx
	movl	76(%esp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	leal	20(%esp), %ecx
	movl	72(%esp), %edx
	addl	%ecx, %edx
	movb	%al, (%edx)
	addl	$1, 72(%esp)
	addl	$1, 76(%esp)
L7:
	movl	76(%esp), %eax
	cmpl	64(%esp), %eax
	jle	L8

	leal	20(%esp), %edx
	movl	72(%esp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
	leal	40(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC1, (%esp)
	call	_printf
	leal	20(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC2, (%esp)
	call	_printf
	movl	$0, %eax


	leave

	ret

