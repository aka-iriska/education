section .data ;сегмент инициализироанных переменных
ExitMsg db "Press Enter to Exit", 10 ;выводимое сообщение
lenExit equ $-ExitMsg
A   DW -30
B   DW 21
section .bss ;сегмент неинициализированных переменных
InBuf resb 10 ; буфер для вводимой строки
lenIn equ $-InBuf
X resd 1 ;зарезервировать место
section .text ;сегмент кода
global _start
_start:

;
mov eax, [A] ;загрузим число в регистр eax
add eax, 5;сложим eax и 5, результат в eax
sub eax, [B];вычесть число B, результат в eax
mov [X], eax; сохраним результат в памяти
;write
mov rax,1 ;системная функция 1(write)
mov rdi, 1;дескрипторо файла stdout=1
mov rsi, ExitMsg;адрес выводимой строки
mov rdx, lenExit;длина строки
syscall;вызов системной функции
;read
mov rax, 0;системная функция 0 (read)
mov rdi, 0;дескриптор файла stdin=0
mov rsi, InBuf;адрес вводимой строки
mov rdx, lenIn; длина строки
syscall; вызов системной функции
;exit
mov rax, 60;системная функция 60 (exit)
xor rdi, rdi;return code 0
syscall;вызов системной функции
