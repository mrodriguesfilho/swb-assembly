.section .rodata

.data

.text

.globl calc

calc:

   pushq %rbp

   movq  %rsp, %rbp
   
   subq $48, %rsp

   movl $0, %ebx     # ebx <- i
   movl $4, %r12d    # r12d <- j

   leaq -44(%rbp), %rdi  
   movl $5, %esi
   movl %ebx, %edx    
   call filli

   leaq -24(%rbp), %rdi 
   movl $5, %esi
   movl %r12d, %edx
   call fills

   movl $0, -48(%rbp)   # -48(%rbp) <- sum

loop:
   cmpl $5, %ebx
   jge endloop
   
   leaq -44(%rbp), %r8
   movslq %ebx, %r9
   imulq $4, %r9
   addq %r9, %r8
   movl (%r8), %r10d

   leaq -24(%rbp), %r8
   movslq %r12d, %r9
   imulq $2, %r9
   addq %r9, %r8
   movswl (%r8), %r11d
   
   movl -48(%rbp), %ecx

   addl %r10d, %ecx
   addl %r11d, %ecx 
   
   movl %ecx, -48(%rbp)

   incl %ebx
   decl %r12d
   jmp loop
endloop:

   movl -48(%rbp), %eax

   leave

   ret