.section .rodata

.data

.text

.globl calc1
calc1:

   pushq %rbp

   movq  %rsp, %rbp

   cvtss2sd %xmm1, %xmm1   # converti float b para double b

   movsd %xmm0, %xmm2      # xmm2 <- double a
   addsd %xmm1, %xmm2      # xmm2 = double a + double b
   
   movsd %xmm0, %xmm3      # xmm3 <- double a
   subsd %xmm1, %xmm3      # xmm3 = double a - double b

   mulsd %xmm3, %xmm2      # (a+b) * (a-b)
   movsd %xmm2, %xmm0      # return (a+b) * (a-b)

   leave

   ret