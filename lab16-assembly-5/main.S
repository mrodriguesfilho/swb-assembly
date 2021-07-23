.section .rodata

fmt01: .string "Hello"
fmt02: .string "[INFO] %d\n"

.data

.globl val
.align 4
val: .int 432

.globl age
.align 2
age: .short 4

.globl r
.align 4
r: .int 0

.globl err
.align 4
err: .int 0

.text

.globl main

main:

   pushq %rbp

   movq  %rsp, %rbp

   # Seu código aqui...
   
   # const char *prefix
   movq $fmt01, %rdi

   # int v1
   movl val, %esi
   
   # short v2
   movw age, %dx
   
   # int * s
   movq $r, %rcx
   call sum

   # err = sum()
   movl %eax, err
   
   # print f
   movq $fmt02, %rdi
   movl err, %esi
   movl $0, %eax
   call printf

   # return 0
   movl $0, %eax

   leave

   ret