section .data
InputA db "Input A", 10
lenMsgA equ $-InputA
InputB db "Input B", 10
lenMsgB equ $-InputB
InputK db "Input K", 10
lenMsgK equ $-InputK
ResultMsg db "Result = ", 10
lenMsgResult equ $-ResultMsg
ErrorStr db "Error: Invalid input format", 10
lenError equ $-ErrorStr
section .bss
InBuf resb 10 ; буфер для вводимой строки
lenIn equ $-InBuf
OutBuf resb 10
lenOut equ $-OutBuf
A resd 1
B resd 1
K resd 1
F resd 1
section .text

global _start
_start:

;input A
;write
mov eax, 4 ; системная функция 4 (write)
mov ebx, 1 ; дескриптор файла stdout=1
mov ecx, InputA ; адрес выводимой строки
mov edx, lenMsgA ; длина выводимой строки
int 80h ; вызов системной функции
; read
call Buffer
mov esi, InBuf
call StrToInt
cmp ebx, 0
jne Error
mov [A], eax

;input B
;write
mov eax, 4 ; системная функция 4 (write)
mov ebx, 1 ; дескриптор файла stdout=1
mov ecx, InputB ; адрес выводимой строки
mov edx, lenMsgB ; длина выводимой строки
int 80h ; вызов системной функции
; read
call Buffer
mov esi, InBuf
call StrToInt
cmp ebx, 0
jne Error
mov [B], eax

;input K
;write
mov eax, 4 ; системная функция 4 (write)
mov ebx, 1 ; дескриптор файла stdout=1
mov ecx, InputK ; адрес выводимой строки
mov edx, lenMsgK ; длина выводимой строки
int 80h ; вызов системной функции
; read
call Buffer
mov esi, InBuf
call StrToInt
cmp ebx, 0
jne Error
mov [K], eax

;program
mov eax, [K]
imul eax ; k^2
add eax, 2
mov ECX, EAX; сохраним значение знаминателя
mov eax, [B]
imul eax ; B^2
mov ebx, [B]
imul ebx ; B^3
idiv ecx ; AX = B^3 / K^2+2
mov ecx, eax ;сохраним значение дроби
mov eax, [A]
imul ebx
sub eax, ecx
mov [F], eax
int 80h ; вызов системной функции

;output
mov eax, 4 ; системная функция 4 (write)
mov ebx, 1 ; дескриптор файла stdout=1
mov ecx, ResultMsg ; адрес выводимой строки
mov edx, lenMsgResult ; длина строки
int 80h ; вызов системной функции
;вывод F
mov eax, [F]
mov esi, OutBuf
call IntToStr
mov esi, eax
mov eax, 4 ; системная функция 1 (write)
mov ebx, 1 ; дескриптор файла stdout=1
mov ecx, OutBuf ; адрес буфера
mov edx, esi ; длина буфера
int 80h ; вызов системной функции
jmp Exit
Error:
    mov eax, 4 ; системная функция 4 (write)
    mov ebx, 1 ; дескриптор файла stdout=1
    mov ecx, ErrorStr ; адрес сообщения об ошибке
    mov edx, lenError ; длина сообщения об ошибке
    int 80h ; вызов системной функции
; Выход
Buffer:
mov eax, 3 ; системная функция 3 (read)
mov ebx, 0 ; дескриптор файла stdin=0
mov ecx, InBuf ; адрес буфера ввода
mov edx, lenIn ; размер буфера
int 80h
ret
Exit:
mov eax, 1 ; системная функция 1 (exit)
xor ebx, ebx ; код возврата 0
int 80h ; вызов системной функции
%include "../lib.asm"






