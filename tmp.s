  .globl sub_char
  .text
sub_char:
  push %rbp
  mov %rsp, %rbp
  sub $16, %rsp
  mov %dil, -1(%rbp)
  mov %sil, -2(%rbp)
  mov %dl, -3(%rbp)
  lea -3(%rbp), %rax
  movsbq (%rax), %rax
  push %rax
  lea -2(%rbp), %rax
  movsbq (%rax), %rax
  push %rax
  lea -1(%rbp), %rax
  movsbq (%rax), %rax
  pop %rdi
  sub %rdi, %rax
  pop %rdi
  sub %rdi, %rax
    jmp .L.return.sub_char
.L.return.sub_char:
  mov %rbp, %rsp
  pop %rbp
  ret
  .globl main
  .text
main:
  push %rbp
  mov %rsp, %rbp
  sub $0, %rsp
  mov $7, %rax
  push %rax
  mov $3, %rax
  push %rax
  mov $3, %rax
  push %rax
  pop %rdx
  pop %rsi
  pop %rdi
  mov $0, %rax
  call sub_char
    jmp .L.return.main
.L.return.main:
  mov %rbp, %rsp
  pop %rbp
  ret
