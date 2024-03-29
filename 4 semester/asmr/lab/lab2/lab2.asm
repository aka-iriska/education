section .data
A dw 2
B dw 6
K dw 2
section .bss
F resw 1
section .txt
global _start
_start:
mov AX, [K]
imul AX ; k^2
add AX, 2
mov CX, AX; сохраним значение знаминателя
mov AX, [B]
imul AX ; B^2
mov BX, [B]
imul BX ; B^3
idiv CX ; AX = B^3 / K^2+2
mov CX, AX ;сохраним значение дроби
mov AX, [A]
imul BX
sub AX, CX
mov [F], AX
syscall




