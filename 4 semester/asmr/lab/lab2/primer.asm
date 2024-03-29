section .data
A dw 25
B dw -6
D dw 11
section .bss
X resw 1
section .txt
global _start
_start:
mov CX, [D]
add CX, 8
mov BX, [B];передаём значение при lea передаём адрес
dec BX; вычитание
mov AX, [A]
add AX, [D]
imul BX
idiv CX
mov [X], AX
syscall
