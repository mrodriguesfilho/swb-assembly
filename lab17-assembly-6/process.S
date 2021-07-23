.section .rodata



.data



.text

.globl process

process:

   pushq %rbp
   movq  %rsp, %rbp
   subq $48, %rsp
   # Invertendo os a ordem dos parametros

   # variável auxiliar
   movl $0, %r11d

   # invertendo as variáveis para passar parametros
   
   movl %edi, %r11d
   movl %r9d, %edi
   movl %r11d, %r9d

   movl %esi, %r11d
   movl %r8d, %esi
   movl %r11d, %r8d

   movl %edx, %r11d
   movl %ecx, %edx
   movl %r11d, %ecx

   # Salvando os parametros
   movq %rdi, -8(%rbp)
   movq %rsi, -16(%rbp)
   movq %rdx, -24(%rbp)
   movq %rcx, -32(%rbp)
   movq %r8, -40(%rbp)
   movq %r9, -48(%rbp)

   call calc # retorna int r em %eax

   # Recuperando os parametros
   movq -8(%rbp), %rcx
   movq -16(%rbp), %rdx 
   movq -24(%rbp), %rdi
   movq -32(%rbp), %rsi
   movq -40(%rbp), %r8
   movq -48(%rbp), %r9
   
   # r = %r10d
   movl %eax, %r10d

   # r = a + b + c + d + e + f 
   addl %ecx, %r10d
   addl %edx, %r10d
   addl %edi, %r10d
   addl %esi, %r10d
   addl %r8d, %r10d
   addl %r9d, %r10d
   
   
   movl %r10d, %eax

   leave

   ret