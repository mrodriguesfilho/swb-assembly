.section .rodata

.data

.text

.globl fat

fat:

  pushq %rbp
  movq  %rsp, %rbp
  subq $16, %rsp
  
  cmpl $0, %edi
  # edi - 0 <= jmp fiminf
  jle fimif 

inicioif:

  # %ecx = n
  movl %edi, %ecx

  # n - 1
  subl $1, %edi

  # Salvando n
  movq %rcx, -8(%rbp)
  
  call fat

  # recuperando n
  movq -8(%rbp), %rcx

  # %eax = fat(n-1)*%eax
  imull %ecx, %eax

  leave

  ret

fimif:

  movl $1, %eax 

  leave

  ret