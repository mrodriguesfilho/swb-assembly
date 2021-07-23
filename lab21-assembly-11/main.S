.section .rodata

fmt: .string "sum = %ld\n"

.data

.text

.globl sum
sum:
  
  pushq %rbp
  movq  %rsp, %rbp
  subq $32, %rsp
  
  movq %rdi, -8(%rbp)     # rdi <- node
  movq %rsi, -16(%rbp)    # rsi <- size
  call new_sum
  movq -8(%rbp), %rdi
  movq -16(%rbp), %rsi

  movq %rax, -24(%rbp) # h <- new_sum()

  movl $0, -28(%rbp)  # i <- 0 
    
loop1:
  cmpl %esi, -28(%rbp)
  jge endloop1
  movl $0, -32(%rbp)    # j <- 0
loop2:
  movq %rdi, %r8
  movslq -28(%rbp), %r9
  imulq $56, %r9
  addq %r9, %r8
  movl 48(%r8), %r9d

  cmpl %r9d, -32(%rbp)
  jge endloop2

  movq %rdi, -8(%rbp)
  movq %rsi, -16(%rbp) 

  movq -24(%rbp), %rdi    # rdi <- h

  movslq -32(%rbp), %r9
  imulq $8, %r9
  addq %r9, %r8
  movq 8(%r8), %rsi

  call add_sum    # add_sum(h, node[i].values[j])
  movq -8(%rbp), %rdi
  movq -16(%rbp), %rsi

  incl -32(%rbp)
  jmp loop2
endloop2:
  incl -28(%rbp)
  jmp loop1

endloop1:

  movq -24(%rbp), %rdi
  call get_sum

  leave
  ret

.globl main
main:

   pushq %rbp

   movq  %rsp, %rbp

   subq $112, %rsp

   leaq -112(%rbp), %rdi  # nodes[2]   

   call init              # init(%rdi)

   leaq -112(%rbp), %rdi
   movl $2, %esi          # esi <- 2

   call sum               # sum(nodes, 2)

   movq %rax, %rsi        # rsi <- sum(nodes,2)

   movq $fmt, %rdi        
   
   movl $0, %eax

   call printf

   movl $0, %eax

   leave

   ret