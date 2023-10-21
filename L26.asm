extern  printf

 section .text           ; Code section.
        global main     ; the standard gcc entry point
main:
        ;save registers.
        push rdi
        push rsi
        sub rsp, 8      ;align stack.
                        ;put a check here to prevent the program name from being printed.        
	mov rsi, [rsi]  ;argument to be printed.
        mov rdi, pfmt   ;format
	jmp length
print:       
	xor rax, rax
        cmp qword [count], 0
        je restore 	;skip if first arg
        call printf
	mov rsi, [lengthb]
	mov rdi, dfmt
	call printf
restore:
        add rsp, 8      ;restore to prealigned value.
        inc qword [count]
        pop rsi
        pop rdi
loop:
        add rsi, 8 ;loop between all arguments, including the program name.
        dec rdi         ;good way to keep track of loop.
        jnz main
	jmp exit

length:
	mov rbx, rsi
	mov rax, rbx
	jmp nchar

nchar:
	cmp byte [rax], 0
	jz  total
	inc rax
	jmp nchar
total:
	sub rax, rbx
	mov [lengthb], rax
	jmp print
	
exit:
        mov eax, 1
        mov ebx, 0
        int 80h

section .data
pfmt db "the parameter is %s",10, 0     ;format for printing.
dfmt db "the length is %d",10, 0 	;decimal format.
count dq 0              ;For keeping count of arguments
lengthb dq 0 		;length of the string
