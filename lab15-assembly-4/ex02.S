.section .rodata



.data



.text

.globl main

main:

  pushq %rbp

  movq  %rsp, %rbp



  # Seu código aqui...
  # Usar: %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11.
  
  movw $10, %cx   # i
  movw $20, %dx   # j
  movw $30, %si   # k
  movb $16, %r8b  # r

  cmpw $20, %cx   # i < 20
  jl inicioif01   # se true entra no bloco do if01
  cmpw $30, %dx   # j >= 30
  jge endif01     # se true vai para o fim do if01
inicioif01:
  movb %r8b, %r11b    # temporário <- r
  shrb $1, %r11b      # temporário >> 1;
  movb %r11b, %r8b    # r <- (temporário >>  1) 
endif01:
                  
  cmpw $30, %dx   # j <= 30
  jle endif02     # se true vai para o fim do if02
  cmpw $20, %si   # k >= 20
  jge endif02     # se true vai para o fim do if02

inicioif02:  
  movb %r8b, %r11b    # temporário <- r
  movb $2, %r10b    
  movzbw %r11b, %ax
  divb %cl            # r/2

endif02:

  cmpw $20, %cx   # i <= 20
  jle ou          # se true vai para o ou           
  cmpw $30, %dx   # j <= 30
  jle inicioif03  # se true vai para o inicio do if03

ou:
  cmpw $20, %si   # k <= 20
  jle endif03     # se true vai para o fim do if03
inicioif03:
  movb %r8b, %r11b # temporario <- r
  addb $100, %r11b # temporario + 100
  movb %r11b, %r8b # r <- (temporario + 100)
endif03:  
  movl $0, %eax
  movzbl %r8b, %eax
  call print_eax_as_uint
  leave

  ret