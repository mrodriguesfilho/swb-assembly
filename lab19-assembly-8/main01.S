.section .rodata

fmt01: .string "color: %ld, filled: %d\n"

.data

.globl circle
.align 8
circle:
  .int 0
  .int 0
  .byte 0
  .zero 7
  .quad 0

.text 

.globl main

main:

   pushq %rbp

   movq  %rsp, %rbp
   
   movq $circle, %r8 # r8 <- circle
   
   movl $10, (%r8) # x <- 10
   
   movl (%r8), %eax # eax <- 10
   
   imull $2, %eax # eax <- eax * 2
   
   movl %eax, 4(%r8) # y <- eax
   
   movb $1, 8(%r8) # filled <- 1

   cmpl $30, 4(%r8) # y <= 30 jump else
   jle inicioelse
inicioif:
   movq $2, 16(%r8)
   jmp endif
inicioelse:
   movq $1, 16(%r8)
endif:
   movq $fmt01, %rdi
   movq 16(%r8), %rsi
   movsbl 8(%r8), %edx   
   movl $0, %eax

   call printf
   
   movl $0, %eax

   leave

   ret