.section .rodata

.data

.text

.globl myopen

myopen:

   pushq %rbp
   
   movq  %rsp, %rbp

   subq $16, %rsp

   movq %rdi, -8(%rbp)     # Salvei o handler *h

   movq %rsi, %rdi         # passei *filename para rdi

   movl %edx, %esi         # esi <- flags

   movl $0, %edx           # mode <- 0

   movq $2, %rax           # código da chamada

   syscall                 # syscall(rdi, esi)
   
   movq -8(%rbp), %rdi     # recupero o *h

   movl %eax, (%rdi)       # h.fd <- open()

   leave

   ret

.globl myread
myread:

   pushq %rbp
   movq %rsp, %rbp

   movq %rdi, %r8          # passei o endereço do ponteiro para r8

   movl (%r8), %edi        # edi <- fd
   movq 16(%r8), %rsi      # rsi <- buffer
   movq 8(%r8), %rdx       # rdx <- size_t
   
   movq $0, %rax            # sys code

   syscall

   leave
   ret

.globl mywrite
mywrite:

   pushq %rbp
   movq %rsp, %rbp
   
   movq %rdi, %r8          # passei o endereço do ponteiro para r8
  
   movl (%r8), %edi        # edi <- fd
   movq %rsi, %rdx         # rdx <- count
   movq 16(%r8), %rsi      # rsi <- buffer

   movq $1, %rax           # sys code

   syscall

   leave
   ret

.globl myclose
myclose:

   pushq %rbp
   movq %rsp, %rbp

   movq %rdi, %r8       # passei o endereço do ponteiro para r8
   
   movl (%r8), %edi
   movq $3, %rax
   syscall
   
   leave
   ret