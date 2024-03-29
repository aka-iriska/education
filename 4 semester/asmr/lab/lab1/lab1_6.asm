section .data ;сегмент инициализироанных переменных
F1 dw 65535
F2 dd 65535
section .bss ;сегмент неинициализированных переменных

section .text ;сегмент кода
global _start
_start:
add word[F1], 1
add dword[F2], 1
syscall
