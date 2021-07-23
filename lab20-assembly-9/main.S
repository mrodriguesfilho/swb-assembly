.section .rodata

fmt01: .string "Diferença em %d/%d: %ld \n"

.data

.globl prods
.align 8
prods:
  .byte 0 # Struct[0]
  .zero 7
  .quad 0
  .int 0
  .zero 4
  .byte 0 # Struct[1]
  .zero 7
  .quad 0
  .int 0
  .zero 4

.text

.globl media
media:

  movl $0, %ecx # i <- 0
  movq $0, %rdx # soma <- 0

loop: 
  movslq %ecx, %r11 # alargando o i para long
  
  cmpq %rsi, %r11 # i >= size -> jmpendloop
  jge endloop
  
  movq %rdi, %r8    # r8 <- struct
  movslq %ecx, %r9  # alarga o i
  imulq $8, %r9     # posição r9 para prods
  addq %r9, %r8     # acesso à posição prods[r9]
  movq 8(%r8), %r10 # passa o valor que está em prods[r9] no campo apropriado da struct

  addq %r10, %rdx
  
  incl %ecx
  jmp loop
endloop:  

  movq %rsi, %rcx   # rcx <- rsi = size = 2
  movq %rdx, %rax   # rax <- rdx = soma
  cqto 
  idivq %rcx       # rax <- resultado = soma/size

  leave
  ret

.globl main

main:

   pushq %rbp
   movq  %rsp, %rbp
   subq $16, %rsp

   movl $0, %ebx # i <- 0 - Registrador Callee Saved

   movq $prods, %rdi # rdi <- prods
   movq $2, %rsi # rsi <- size

   movb $1, (%rdi)
   movq $100, 8(%rdi)
   movl $2020, 16(%rdi)
   
   movb $2, 24(%rdi)
   movq $120, 32(%rdi)
   movl $2020, 40(%rdi)

   movq %rdi, -8(%rbp)
   movq %rsi, -16(%rbp)
   call media
   movq -8(%rbp), %rdi
   movq -16(%rbp), %rsi

   movq %rax, %r15      # r15 <- m
   

enquanto:
   movslq %ebx, %r10 # alargando o i para quad
   cmpq %rsi, %r10   # size >= i -> jump fimenquanto
   jge fimenquanto


   movq $prods, %r8      # r8 <- prods ( vou usar rdi para fmt01 )
  
   # rdi <- fmt01
   movq $fmt01, %rdi

   # rsi <- (int)prods[i].mes
   movslq %ebx, %r9 
   imulq $8, %r9
   addq %r9, %r8
   movsbl (%r8), %esi
   
   # rdx <- prods[i].ano 
   movslq %ebx, %r9
   imulq $8, %r9
   addq %r9, %r8
   movq 8(%r8), %rdx

   # rcx <- prods[i].preço - m 
   movslq %ebx, %r9
   imulq $8, %r9
   addq %r9, %r8
   movq 16(%r8), %rcx
   subq %r15, %rcx

   # zerar EAX antes do printf
   movl $0, %eax
   call printf

   incl %ebx
   jmp enquanto
fimenquanto:

   movl $0, %eax

   leave

   ret