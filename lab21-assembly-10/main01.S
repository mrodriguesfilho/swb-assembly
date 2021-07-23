.section .rodata

fmt: .string "Soma: %ld \n"

.data


.text

.globl main

main:

   pushq %rbp

   movq  %rsp, %rbp

   subq $16, %rsp

   call constante

   movsbw %al, %bx # Pega o retorno de constante, alarga para short e salva em %bx(s)
   
   movw %bx, %di
   leaq -16(%rbp), %rsi
   leaq -8(%rbp), %rdx

   call init # init(%di, %rsi, %rdx)
   
   movq -16(%rbp), %rsi   # rsi <- l
   movslq -8(%rbp), %r12  # r12 <- i
   addq %r12, %rsi        # rsi = rsi + r12
   movswq %bx, %r12       # r12 <- s
   addq %r12, %rsi        # rsi = rsi + r12
   
   movq $fmt, %rdi
   movl $0, %eax
   call printf            # printf(%rdi, %rsi), sendo rsi = l + i + s

   movl $0, %eax

   leave

   ret