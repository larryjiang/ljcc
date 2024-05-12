  .data
  .globl x
x:
  .zero 32
  .globl main
  .text
main:
  push %rbp
  mov %rsp, %rbp
  sub $0, %rsp
  mov $32, %rax
    jmp .L.return.main
.L.return.main:
  mov %rbp, %rsp
  pop %rbp
  ret
