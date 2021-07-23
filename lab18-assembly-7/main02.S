.section .rodata

.data

.globl v1
.align 2
v1: .short 1, 2

.globl v2
.align 8
v2: .quad 1, 2, 3


.text

.globl aux

aux:
  pushq %rbp
  movq  %rsp, %rbp
  subq $32, %rsp

  # i = %ecx
  movl $2, %ecx;
  
  # v2 = %rdx
  movq $v2, %rdx

for:
  # se i < 0 jmp endfor
  cmpl $0, %ecx
  jl endfor
  
  movq %rdi, -8(%rbp)
  movq %rsi, -16(%rbp)
  movq %rdx, -24(%rbp)
  movq %rcx, -32(%rbp)
  call sum
  movq -8(%rbp), %rdi
  movq -16(%rbp), %rsi
  movq -24(%rbp), %rdx
  movq -32(%rbp), %rcx

  decl %ecx 
  jmp for
  
endfor:  

  leave

  ret

.globl main

main:

  pushq %rbp
  movq  %rsp, %rbp
  subq $16, %rsp
  
  # i = 0
  movl $0, %esi

while:

  # esi >= 2 jmp endwhile

  cmpl $2, %esi;
  jge endwhile
 
  movq $v1, %rdi
  # salvando i antes de chamar aux
  movq %rsi, -8(%rbp)
  call aux
  movq -8(%rbp), %rsi

  incl %esi
  jmp while

endwhile:

  movl $0, %eax

  leave

  ret