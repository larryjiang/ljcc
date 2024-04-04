  .globl main
main:
    push %rbp
    mov %rsp, %rbp
    sub $0, %rsp
  mov $0, %rax
  call ret5
    jmp .L.return
.L.return:
    mov %rbp, %rsp
    pop %rbp
    ret
