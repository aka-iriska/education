section .data ;сегмент инициализированных переменных
A db 5
B db 10
section .bss ;сегмент неинициализированных переменных
C resb 1
section .text ;сегмент кода
global _start
_start:
mov eax, [A]
add eax, [B]
mov [C], ax
syscall;вызов системной функции
