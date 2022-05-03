# Mason Manca, Jonathan Smoley, and Sam Berkson
# Group 6
# CPSC 260
# Dr.Zarafshani
# 3 May 2020
								# The eax register represents our initial array, and edx represents our reversed array
LC0:
	.ascii "Enter any string: \0"

LC1:
	.ascii "Reverse ordered words: %s\0"

	.globl	_main
	.def	_main;

_main:

	pushl	%ebp   				# Standard calle entrance

	movl	%esp, %ebp 			# moves the top of stack pointer to the base pointer

	andl	$-80, %esp			# allocate memory for the stack

	movl	$LC0, (%esp)		# call text function
	call	_printf				# print text

	leal	40(%esp), %eax		# Assume an array of less than 20, and move eax halfway up the stack since we have 2 arrays 
	movl	%eax, (%esp)		# move eax into stack p

	call	_gets				# read in characters until reaching a '\n'

	leal	40(%esp), %eax		# move eax halfway in order to start to get the length of our input string
	movl	%eax, (%esp)		
	call	_strlen				# strlen is read into the eax register

	movl	%eax, 60(%esp)		# copy length of string to stack
	movl	$0, 72(%esp)		# copy 0 to stack to track index, new place on stack

	subl	$1, %eax			# Decremeny by 1 to get to last character and store in eax
	movl	%eax, 68(%esp)		# move start of word back onto stack in new location on stack

	movl	%eax, 64(%esp)      # word end stored at 64+esp, same length as word start

	jmp	L2						# Jump to conditional of the loop

L6:
	leal	40(%esp), %edx		# Navigate to the start of array and store in edx
	movl	68(%esp), %eax		# Copy start value into eax
	addl	%edx, %eax			# Traverse the array

	cmpb	$32, (%eax)			# checking the value at the dereferenced array index and comparing it to a space
	jne	L3						# If not a space, then we decrement word start and go to next index

	movl	68(%esp), %eax		# move word start into eax
	addl	$1, %eax			# increment by 1 and
	movl	%eax, 76(%esp)		# Store in i, which is in 76+top of stack pointer
	jmp	L4						# jump to inner loop

L5:
	leal	40(%esp), %edx		# 40+esp is the start of 2nd array, putting element into edx
	movl	76(%esp), %eax		# going to str[i] and putting element into eax

	addl	%edx, %eax			# Traverse the array

	leal	20(%esp), %ecx		# ecx stores reverse[] array
	movl	72(%esp), %edx		# edx now holds index
	addl	%ecx, %edx			# Going to element reverseArray[index]

	movl	(%eax), %eax		# str[i] into eax register

	movb	%al, (%edx)			# moving str[i] into reverseArray[inedex]

	addl	$1, 76(%esp)		# increment i
	addl	$1, 72(%esp)		# increment index

L4:
	movl	76(%esp), %eax		# copy value of i into eax
	cmpl	64(%esp), %eax		# compare i and wordEnd
	jle	L5						# exit loop if less than or equal to

	movl	72(%esp), %eax		# move index into eax
	leal	1(%eax), %edx		# increment index, and store into edx

	movl	%edx, 72(%esp)		# reverseArray[index + 1]
	movb	$32, 20(%esp,%eax)	# add ' ' into reverseArray[index + 1] to prepare for next word

	movl	68(%esp), %eax		# store wordStart into eax register
	subl	$1, %eax			# subtract 1 from wordStart
	movl	%eax, 64(%esp)		# wordEnd receives value of wordStart - 1 as per last two lines

L3:
	subl	$1, 68(%esp)		# decrement start point in word because initial character was not a space
L2:
	cmpl	$0, 68(%esp)		# compare the start of word with 0
	jg	L6						# If greater than 0, then begin loop body, otherwise done with loop

								# Remember that we are missing the last word after this iterates
								# need to add in the next word manually

	movl	$0, 76(%esp)		# move 0 into i
	jmp	L7						# jump to loop comparison

L8:
	leal	40(%esp), %edx		# getting original array
	movl	76(%esp), %eax		# move i into eax 
	addl	%edx, %eax			# str[i] 

	movl	(%eax), %eax		# get the elemend inside of str[i]
	leal	20(%esp), %ecx		# 20%esp is reversedArray[], store it in ecx
	movl	72(%esp), %edx		# move index into edx

	addl	%ecx, %edx			# reversedArray[index]
	movb	%al, (%edx)			# reversedArray[index] = str[i]

	addl	$1, 72(%esp)		# 72(%esp) tracks index in our loop
	addl	$1, 76(%esp)		# 76(%esp) tracks the i in the array
L7:
	movl	76(%esp), %eax		# move i into eax
	cmpl	64(%esp), %eax		# compare wordEnd and i 
	jle	L8						# jump to loop body if less than or equal

	leal	20(%esp), %edx		# reversedArray into edx
	movl	72(%esp), %eax		# index into eax
	addl	%edx, %eax			# reversedArray[index]

	movb	$0, (%eax)			# Adding null character to the end of reverse[index]

	leal	20(%esp), %eax		# move reversedArray to eax
	movl	%eax, 4(%esp)		# move array to 4 + esp, so we print LC1 first

	movl	$LC1, (%esp)		# move LC1 function to the top of the stack
	call	_printf				# Print that business

	subl	$80, %esp			# deallocate memory
	
	leave						

	ret

