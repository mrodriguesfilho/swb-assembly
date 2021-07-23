.section .rodata

str01: .string "'a' é maior do que 'b'"
str02: .string "'a' não é maior do que 'b'"

.data
   .globl a
   .align 4
   a: .int 55

   .globl b
   .align 4
   b: .int 65

.text

.globl main

main:

   pushq %rbp

   movq  %rsp, %rbp

   # Seu código aqui...
   movl a, %eax
   movl b, %ecx
   cmpl %ecx, %eax
   jle endif01
   movq $str01, %rax
   call print_rax_as_string
   jmp endif02

endif01:
   movl a, %eax
   movl b, %ecx
   cmpl %eax, %ecx
   jl endif02
   movq $str02, %rax
   call print_rax_as_string

endif02:

   movl $0, %eax

   leave

   ret