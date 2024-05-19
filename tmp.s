  .globl main
  .text
main:
  push %rbp
  mov %rsp, %rbp
  sub $16, %rsp
  lea -8(%rbp), %rax
  push %rax
  mov $2, %rax
  pop %rdi
  mov %rax, (%rdi)
  lea -8(%rbp), %rax
  push %rax
  mov $3, %rax
  pop %rdi
  mov %rax, (%rdi)
  lea -8(%rbp), %rax
  mov (%rax), %rax
    jmp .L.return.main
.L.return.main:
  mov %rbp, %rsp
  pop %rbp
  ret
