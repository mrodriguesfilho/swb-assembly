.section .rodata

.align 8
tmp01: .double 0.0

.data


.text

.globl max_prod

max_prod:

  pushq %rbp

  movq  %rsp, %rbp 

  subq $16, %rsp

  movsd tmp01, %xmm0
  movsd %xmm0, %xmm1     # xmm1 <-  m

loop:

  cmpl $0, (%rdi)
  je endloop

  movsd %xmm1, -8(%rbp)
  movq %rdi, -16(%rbp)
  movsd 8(%rdi), %xmm0
  
  call floor
  movq -16(%rbp), %rdi
  movsd %xmm0, %xmm2
  movsd -8(%rbp), %xmm1
  
if:
  ucomisd %xmm2, %xmm1
  jae endif
  movsd %xmm2, %xmm1
endif:   
  add $16, %rdi 
  jmp loop
endloop:

   movsd -8(%rbp), %xmm0

   leave

   ret