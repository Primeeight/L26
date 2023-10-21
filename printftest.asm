extern	printf

 section .text           ; Code section.
        global main	; the standard gcc entry point
main:			
	push rbp
	lea edi, [pfmt]
	lea esi, [msg] 
	xor eax, eax	;clear eax register.
        call printf	; Call C function
	pop rbp		;restore stack.
	
	;return
	mov eax, 1
	mov ebx, 0
	int 80h

section .data
msg db "the parameter is ",0 ;print the average in floating point format.
pfmt db "%s", 10, 0
;arg1 db "50"
