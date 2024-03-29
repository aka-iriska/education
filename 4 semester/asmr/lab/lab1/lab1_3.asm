section .data ;сегмент инициализироанных переменных
vall db 255
chart dw 256
lue3 dw -128
v5 db 10h
    db 100101b
beta db 23, 23h, 0ch
sdk db "Hello",10
min dw -32767
ar dd 12345678h
valar times 5 db 8
section .bss ;сегмент неинициализированных переменных
alu resw 10
fl resb 5
section .text ;сегмент кода
global _start
_start:
mov eax, [vall]
mov eax, [chart]
mov eax, [lue3]
mov eax, [v5]
mov eax, [beta]
mov eax, [sdk]
mov eax, [min]
mov eax, [ar]
mov eax, [valar]
mov eax, [alu]
mov eax, [fl]
syscall
