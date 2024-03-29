section .data ;сегмент инициализироанных переменных
right dw 25
slovo dd -35
name db "Irina"
imya db "Ирина"
section .bss ;сегмент неинициализированных переменных

section .text ;сегмент кода
global _start
_start:
mov eax, right;
mov eax, slovo;
mov eax, name;
mov eax, imya;
syscall
