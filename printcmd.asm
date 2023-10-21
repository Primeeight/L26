extern  printf

 section .text           ; Code section.
        global main     ; the standard gcc entry point
main:
       	;save registers.
	push rdi
	push rsi
	sub rsp, 8	;align stack.
			;put a check here to prevent the program name from being printed.	
	mov rsi, [rsi]	;argument to be printed.
	mov rdi, pfmt	;format
	xor eax, eax
	cmp [count], eax
	je restore
	
	call printf
restore:	
	add rsp, 8	;restore to prealigned value.
	inc qword [count]
	pop rsi
	pop rdi
loop:
	add rsi, 8 ;loop between all arguments, including the program name.
	dec rdi		;good way to keep track of loop.
	jnz main

        ;return
        mov eax, 1
        mov ebx, 0
        int 80h

section .data
pfmt db "the parameter is %s",10, 0	;format for printing.
count dw 0		;For keeping count of arguments
