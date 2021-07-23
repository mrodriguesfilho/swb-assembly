.section .rodata


fmt: .string "Soma: %ld\n"



.data

# Definição das variáveis aqui...

.globl sum
.align 8
sum: .quad 0

.global vet
.align 8
vet: .quad 10, 20, 30, 40, 50


.text


.globl main

main:

   pushq %rbp

   movq  %rsp, %rbp


   # Inicializações de 'i' e 'ptr' aqui...

   # i agora é o registrador ecx com valor 0
   movl $0, %ecx

   # *ptr <- vet
   movq $vet, %r8


beginwhile:

   cmpl $5, %ecx

   jge  endwhile      # while() {



   # Bloco do while aqui...
   
   # Pego o valor presente no endereço inicial de r8 e movo para rax
   movq (%r8), %rax

   # sum = sum + *ptr;
   addq %rax, sum

   # ptr++
   addq $8, %r8

   # i++
   incl %ecx

   jmp beginwhile     # }

endwhile:



   movq $fmt, %rdi    # printf()

   movq sum, %rsi

   movl $0, %eax

   call printf



   movl $0, %eax      # return 0

   leave

   ret