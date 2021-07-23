.section .rodata

fmt01: .string "soma = "

.data

.globl nums
.align 4
nums: .int 65, -105, 11, 34

.text

.globl main

main:

   pushq %rbp

   movq  %rsp, %rbp

   # Seu código aqui...

   # Usar: %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11. 
   
   movl $0, %ecx     # i
   
   
   movl $0, %edx    # s

loop:

  cmpl $4, %ecx
  jge after
  
  movl %ecx, %r8d   # tmp = i
  
  incl %ecx   # i++ 

  
  movq $nums, %rax    # rax = &num[tmp]
  
  movslq %r8d, %r8    # r = (long)r8d
  
  imulq $4, %r8   # r8 = r8 + sizeof(int)
  
  addq %r8, %rax    # rax = &nums[i]
  
  addl (%rax), %edx   # s = s + nums[i]
  jmp loop
after:

   movl $0, %eax

   movq $fmt01, %rax
   call print_rax_as_string

   movl %edx, %eax
   call print_eax_as_int
   leave

   ret