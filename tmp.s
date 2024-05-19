  .data
  .globl .L..0
.L..0:
  .byte 97
  .byte 98
  .byte 99
  .byte 0
  .globl main
  .text
main:
  push %rbp
  mov %rsp, %rbp
  sub $0, %rsp
  mov $4, %rax
    jmp .L.return.main
.L.return.main:
  mov %rbp, %rsp
  pop %rbp
  ret
