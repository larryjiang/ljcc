  .globl main
  .text
main:
  push %rbp
  mov %rsp, %rbp
  sub $0, %rsp
    lea 0(%rbp), %rax
  push %rax
  mov $1, %rax
  pop %rdi
  mov %rax, (%rdi)
  mov $0, %rax
    lea 0(%rbp), %rax
  mov (%rax), %rax
    jmp .L.return.main
.L.return.main:
  mov %rbp, %rsp
  pop %rbp
  ret
