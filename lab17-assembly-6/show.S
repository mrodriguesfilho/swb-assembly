.section .rodata

fmt01: .string "%d\n"

.data


.text

.globl show

show:

   pushq %rbp
   movq  %rsp, %rbp
   subq $32, %rsp
  
   # Salvando os registradores callee
   movq %r12, -8(%rbp)
   movq %r13, -16(%rbp)
   movq %r14, -24(%rbp)

   # v = %r12
   movq %rdi, %r12
   
   # size = %r13d
   movl %esi, %r13d

   # i = 0
   movl $0, %r14d

loop:
   cmpl %r13d, %r14d
   jge end

   movq $fmt01, %rdi

   # v + ( i  * 4)
   movslq %r14d, %r10
   imulq $4, %r10
   addq %r12, %r10
   movl (%r10), %esi

   movl $0, %eax
   call printf # printf(%rdi, %esi)
   
   incl %r14d
   jmp loop

end:

   movq -8(%rbp), %r12
   movq -16(%rbp), %r13
   movq -24(%rbp), %r14

   leave

   ret