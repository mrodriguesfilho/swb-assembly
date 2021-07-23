.section .rodata

fmt01: .string "Soma %f maior que o limite %f\n"

.align 8
tmp01: .double 0.0

.data

.text

.globl sum

sum:

   pushq %rbp
   movq  %rsp, %rbp
   sub $80, %rsp

   movl $4, -4(%rbp)        # -4(%rbp) <- i <- 4
   movsd %xmm0, -72(%rbp)   # -72(%rbp) <- limit
   movsd tmp01, %xmm0       # %xmm0 <- tmp01
   movsd %xmm0, -16(%rbp)   # -16(%rbp) <- %xmm0
   movl $5, -32(%rbp)       # -20(%rbp) <- 5
   movl $6, -28(%rbp)       # -24(%rbp) <- 6
   movl $7, -24(%rbp)       # -28(%rbp) <- 7
   movl $8, -20(%rbp)       # -32(%rbp) <- 8

   leaq -32(%rbp), %rdi     
   leaq -64(%rbp), %rsi
   movl -4(%rbp), %edx

   call mult
   movsd -16(%rbp), %xmm1   # xmm1 <- s <- -16(%rbp) = 0.0
   movl -4(%rbp), %ebx

loop:
   cmpl $0, %ebx            # ebx (i) <= 0  jmpendloop
   jle endloop
   
   
   leaq -64(%rbp), %r8      # r8 <- *vd
   decl %ebx
   movslq %ebx, %r9
   imulq $8, %r9
   addq %r9, %r8
   movsd (%r8), %xmm2       # xmm2 <- vd[--]
   addsd %xmm2, %xmm1       # xmm1(s) = xmm1(s) + xmm2(s) 
   movsd %xmm1, %xmm0       # xmm0 <- xmm1 - s = s + vd[--i]

if:
  movsd -72(%rbp), %xmm1    # xmm1 <- limit
  ucomisd %xmm1, %xmm0      # xmm0  below equal jump endif
  jbe endif
  
  movsd %xmm0, -16(%rbp)    # salvei o s 
  movq $fmt01, %rdi
  movl $2, %eax
  call printf
  movsd -16(%rbp), %xmm1    # recuperei o s em xmm1
endif:

  jmp loop
endloop:
   
   movsd %xmm1, %xmm0
   leave

   ret