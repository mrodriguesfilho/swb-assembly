.section .rodata

fmt01: .string "%ld \n"

.data

.text

.globl show

show:

   pushq %rbp
   movq  %rsp, %rbp
   subq $32, %rsp

   movl $0, %ecx   # %ecx = int i

   movq %rdi, %rdx # ptr = d-> elemns 
   addq $8, %rdx   # 4 int + 4 padding
   
loop:
   cmpl (%rdi), %ecx # (%rdi) >= 1 endloop
   jge endloop
   
   # ptr[i]
   movq %rdx, %r8 
   movslq %ecx, %r9
   imulq $8, %r9
   addq %r9, %r8
   movq (%r8), %rsi
   
   # Salvando os registradores

   movq %rdi, -8(%rbp)
   movq %rcx, -16(%rbp) 
   movq %rdx, -24(%rbp)

   movq $fmt01, %rdi
   movl $0, %eax
   
   call printf
 
   # Recuperando os registradores
   movq -8(%rbp), %rdi
   movq -16(%rbp), %rcx
   movq -24(%rbp), %rdx

   incl %ecx # i++
   jmp loop
endloop:

   movl $0, %eax

   leave

   ret