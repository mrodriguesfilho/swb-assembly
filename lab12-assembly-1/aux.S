.data
  .globl c
  c: .byte -20
  
  .globl i
  .align 4
  i: .int 20
  
  .globl ui
  .align 4
  ui: .int 1024
  
  .globl l
  .align 8
  l: .quad 129
  
  .globl ul
  .align 8
  ul: .quad 2048
  
  .globl v
  .align 4
  v: .int 10, 20, 30, 40, 50
  
  .globl us
  .align 2
  us: .short 111

  ptr: .quad 0
.text

.globl aux
aux:

    pushq %rbp

    movq  %rsp, %rbp


    # Se necessário, usar apenas os registradores:

    # %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10

    # Seu código aqui...

    movb c, %al
    movsbl %al, %ecx
    movl %ecx, i
    
    movl i, %ecx
    movl %ecx, %edx
    movl %edx, ui

    movl ui, %eax
    movq %rax, ul

    movq ul, %rax
    movw %ax, us

    movl $10, %eax
    addl i, %eax
    subl $5, %eax
    movb %al, c

    movq $v, %rax
    movl 8(%rax), %eax
    movl %eax, i

    movq $v, %rax
    movsbl c, %edx
    imull 12(%rax), %edx
    movl %edx, 16(%rax)

    movq l, %r8;
    
    movq $128, l;

    leave

    ret