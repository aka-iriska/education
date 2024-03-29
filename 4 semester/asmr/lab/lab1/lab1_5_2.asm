section .data ;сегмент инициализироанных переменных
right dw 9472
dw 2500h
section .bss ;сегмент неинициализированных переменных

section .text ;сегмент кода
global _start
_start:
mov eax, right;
syscall
