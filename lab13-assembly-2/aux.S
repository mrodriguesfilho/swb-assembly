.data
  .globl str
  str: .string "BEBAMUITOCAFE"

.text

.globl process

process:

   pushq %rbp

   movq  %rsp, %rbp

   # Inicialização de 'ptr' aqui...

   # ptr = str

  # move str para o registrador r8
  movq $str, %r8



beginwhile:

   cmpb $0, (%r8)

   je endwhile            # while() {



   # Bloco do while
    
    # Passa o primeiro byte do r8 para al
    movb (%r8), %al
    
    # Adiciona 32 no registrador al
    addb $32, %al

    # Devolvo o valor para o primeiro
    movb %al, (%r8)

    # Incrementa o endereço
    incq %r8



   jmp beginwhile         # }

endwhile:



   leave

   ret