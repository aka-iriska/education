section .data
; matr dd 2,3,1,-1,8,9,-2
; dd 6,-8,7,5,4,11,2
; dd 12,3,0,-13,5,7,2
; dd 6,23,103,4,5,-1,0
; dd 0,-1,4,6,12,5,-6
matr_rows dd 5 ;количество строк
matr_columns dd 7 ;количество столбцов
StartMsg db "Изначальная матрица:", 10
lenStartMsg equ $-StartMsg
EndMsg db "Измененная матрица:", 10
lenEndMsg equ $-EndMsg

section .bss
matr resd 35;резервируем место для 35 4-байтовых чисел матрицы 5х7

section .text
global _start

_start:
;ввод матрицы
call ReadMatrix
;вывод изн матрицы
    mov eax, 4 ; системная функция 4 (write)
    mov ebx, 1 ; дескриптор файла stdout=1
    mov ecx, StartMsg ; адрес выводимой строки
    mov edx, lenStartMsg ; длина выводимой строки
    int 80h ; вызов системной функции
    call WriteMatrix
;основная программа
mov ecx, [matr_columns] ;количество
cycle_colomns:
    mov eax, ecx ;смещение по столбцу
    dec eax
    ;умножение ebx на 4
    mov ebx, 4
    mul ebx
    mov ebx, eax
    ;проверка чётности:
    test ecx, 1
    jnz next ;если столбец нечетный
    push ecx
    mov eax, [matr_rows]
    ;деление eax на 2
    mov esi, 2
    div esi
    mov ecx, eax ;записываем только половину матрицы
    mov esi, 1;счётчик
    .cycle_rows:
        mov eax, [matr + ebx]
        call Arifmetic
        mov edx, [matr + ebx + edi]
        mov [matr + ebx], edx
        mov [matr + ebx + edi], eax
        inc esi
        add ebx, 28 ;переход к след элементу в столбце 7*4байта
        loop .cycle_rows
    pop ecx
    next:
    loop cycle_colomns
; вывод конечной матрицы
    mov eax, 4 ; системная функция 4 (write)
    mov ebx, 1 ; дескриптор файла stdout=1
    mov ecx, EndMsg ; адрес выводимой строки
    mov edx, lenEndMsg ; длина выводимой строки
    int 80h ; вызов системной функции
    call WriteMatrix
;выход
call Exit
Arifmetic:
    ;была выверена следующая зависимость:
    ;номер противоположного элемента вычисляется так:
    ;номер элемента + количество столбцов*(кол-во строк +1 - 2*номер строки)
    push eax
    push ebx
    push esi
    mov eax, esi
    mov ebx, 2
    mul ebx ; esi - номер строки, начиная с 1
    mov esi, eax
    mov eax, [matr_rows] ;кол-во строк
    inc eax ;кол-во строк+1
    sub eax, esi ;кол-во строк+1 - 2*номер строки
    mul dword[matr_columns] ;кол-во столбцов * рез-тат разности
    mov ebx, 4
    mul ebx
    mov edi, eax ; сохраняем результат произведения, номер элемента добавим в осн программе
    pop esi
    pop ebx
    pop eax
    ret
%include "matrixLib.asm"
