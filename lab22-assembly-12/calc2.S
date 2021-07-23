.section .rodata

fmt: .string "a = %f, b = %f, e = %f\n"

.data



.text

.globl calc2

calc2:

   pushq %rbp

   movq  %rsp, %rbp
   
   subq $16, %rsp

   movss %xmm0, -8(%rbp)    # salvei float a
   movss %xmm1, -16(%rbp)   # salvei float b

   cvtss2sd %xmm1, %xmm0 # converti b para double e mandei para xmm0
   
   call cos              # cos(xmm0)
   
   movsd %xmm0, %xmm3    # guardei o xmm3 <- cos(b)

   movss -8(%rbp), %xmm0  # recuperei float a
   movss -16(%rbp), %xmm1 # recuperei float b
   
   cvtss2sd %xmm0, %xmm4  # converti float a para double a e mandei para xmm4
   addsd %xmm3, %xmm4     # xmm4 = a + cos(b)

   movsd %xmm4, %xmm2     # e = xmm2 <- xmm4 = ( a + cos(b) )

   movss %xmm1, -8(%rbp)  # salvei b para retornar depois
   
   cvtss2sd %xmm0, %xmm0  # converti a para double
   cvtss2sd %xmm1, %xmm1  # converti b para double 

   movq $fmt, %rdi
   movl $3, %eax

   call printf

   movss -8(%rbp), %xmm1
  
   movss %xmm1, %xmm0   # return b

   leave

   ret