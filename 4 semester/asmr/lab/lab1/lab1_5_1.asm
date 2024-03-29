section .data ;сегмент инициализироанных переменных
right dw 37
dw 25h
section .bss ;сегмент неинициализированных переменных

section .text ;сегмент кода
global _start
_start:
mov eax, right;
syscall
