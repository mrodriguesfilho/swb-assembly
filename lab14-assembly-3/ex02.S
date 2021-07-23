.section .rodata

fmt01: .string "Digite um número:\n"

.data
  .globl a
  .align 4
  a: .int 0

  .globl b
  .align 8
  b: .quad 0

.text

.globl main

main:

  pushq %rbp

  movq  %rsp, %rbp

  # Seu código aqui...
  movq $fmt01, %rax
  call read_int_to_eax     # Lê do teclado -> %eax

  # se (a)
  movl %eax, a
  testl $0xFFFFFFFF, a
  jz endelse

  movq $fmt01, %rax
  call read_long_to_rax     # Lê do teclado -> %rax

  # se b < 5
  movq %rax, b
  movq $5, %rdx
  cmpq b, %rdx
  jge endifstartelse
  
  # ( a * b )
  movq b, %rdi
  movslq a, %rsi
  imulq %rsi, %rdi
  # ( a << 1 )
  movl a, %eax
  shll $1, %eax
  movslq %eax, %r10
  
  # ( a << 1 ) + ( a * b)
  addq %r10, %rdi

  # b = ( a << 1 ) + ( a * b)
  movq %rdi, b
  movq b, %rax
  call print_rax_as_long
  jmp endelse

endifstartelse:

  movabs $0x1F, %r8
  xorq b, %r8
  movq %r8, a
  movq a, %rax

  
  call print_rax_as_hex

endelse:

  movl $0, %eax

  leave

  ret