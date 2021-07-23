.section .rodata

fmt: .string "%d\n"

.data

.globl i
.align 4
i: .int 0

.globl vet
vet: .byte 12, 3, 20, 8

.text

.globl main

main:

   pushq %rbp

   movq  %rsp, %rbp

   # Seu código aqui...

loop:
   movl $4, %edx
   cmpl %edx, i
   jge after

   movq $vet, %r8
   movslq i, %r9
   imulq $1, %r9
   addq %r9, %r8
   movb (%r8), %dil

   movw $10, %si

   call filtro

   # printf
   movq $fmt, %rdi
   movl %eax, %esi
   movl $0, %eax
   call printf

   # i++
   incl i
   jmp loop
after:

   # return 0
    movl $0, %eax

   leave

   ret