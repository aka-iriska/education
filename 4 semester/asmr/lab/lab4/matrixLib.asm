section .data:
probel db " ", 10; символ новой строки
InputMsg db "Введите числа строки матрицы", 10
lenInputMsg equ $-InputMsg
ErrorStr db "Error: Invalid input format", 10
lenError equ $-ErrorStr
RowMsg db "Row: ", 10
lenRowMsg equ $-RowMsg

section .bss ; Буфер для ввода чисел
NumberBuf resb 10
InBuf resb 10 ; буфер для вводимой строки
lenIn equ $-InBuf
OutBuf resb 50
lenOut equ $-OutBuf


section _text
ReadMatrix:
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    mov esi, matr ; загрузка адреса матрицы в регистр esi
    mov ecx, [matr_rows] ; загрузка количества строк
    mov edx, [matr_columns] ; загрузка количества столбцов
.write_matrix_loop:
    mov ebx, edx ; сохраняем количество столбцов в регистре ebx для использования в цикле
    call .InputMessage
.write_row_loop:
    ;read element
    call .ReadElement
    mov [esi], eax
    add esi, 4 ; переход к следующему элементу матрицы (размер элемента - 4 байта)
    dec ebx ; уменьшаем счетчик столбцов
    cmp ebx, 0 ; проверяем, завершили ли мы обработку строки
    jnz .write_row_loop ; если нет, продолжаем выводить элементы
    loop .write_matrix_loop ; уменьшаем счетчик строк и продолжаем выводить
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
.InputMessage:
    push eax
    push ebx
    push ecx
    push edx
    mov eax, 4 ; системная функция 4 (write)
    mov ebx, 1 ; дескриптор файла stdout=1
    mov ecx, InputMsg ; адрес выводимой строки
    mov edx, lenInputMsg ; длина выводимой строки
    int 80h ; вызов системной функции
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
.ReadElement:
    push esi
    push ebx
    push ecx
    push edx
    call .Buffer
    mov esi, InBuf
    call StrToInt
    cmp ebx, 0
    jne Error
    pop edx
    pop ecx
    pop ebx
    pop esi
    ret
.Buffer:
    mov eax, 3 ; системная функция 3 (read)
    mov ebx, 0 ; дескриптор файла stdin=0
    mov ecx, InBuf ; адрес буфера ввода
    mov edx, lenIn ; размер буфера
    int 80h
    ret
WriteMatrix:
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    mov esi, matr ; загрузка адреса матрицы в регистр esi
    mov ecx, [matr_rows] ; загрузка количества строк
    mov edx, [matr_columns] ; загрузка количества столбцов

.print_matrix_loop:
    mov edi, OutBuf ; установка указателя на начало буфера для записи элементов
    mov ebx, edx ; сохраняем количество столбцов в регистре ebx для использования в цикле

.print_row_loop:
    mov eax, [esi] ; загрузка элемента матрицы в eax
    call .Output
    add esi, 4 ; переход к следующему элементу матрицы (размер элемента - 4 байта)
    dec ebx ; уменьшаем счетчик столбцов

    cmp ebx, 0 ; проверяем, завершили ли мы обработку строки
    jnz .print_row_loop ; если нет, продолжаем выводить элементы
    add edi, 1 ;до этого мы перекрывали маркер конца строки, когда все элементы однйо строки выведены в буфер добавляем его
    call .NewLineOutput ; выводим символ новой строки
    loop .print_matrix_loop ; уменьшаем счетчик строк и продолжаем выводить
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
.StringOutput:
    push eax
    push ebx
    push ecx
    push edx
    mov eax, 4 ; системная функция 4 (write)
    mov ebx, 1 ; дескриптор файла stdout=1
    mov ecx, RowMsg ; адрес выводимой строки
    mov edx, lenRowMsg ; длина строки
    int 80h ; вызов системной функции
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

.Output:
    push esi
    push eax
    push ebx
    push ecx
    push edx
    mov esi, NumberBuf ; установка указателя на начало буфера вывода
    call IntToStr ; вызов функции для преобразования числа в строку
    mov ebx, dword[esi]
    mov [edi], ebx ; сохраняем строку в буфере
    add edi, eax ; перемещаем указатель на следующий элемент по размеру строки
    sub edi, 1 ;не учитываем маркер конца строки
    mov eax, [probel] ;добавляем пробел между элементами
    mov [edi], eax
    add edi, 1 ;перемещаемся на 1 байт, так как добвили пробел и в будущем его не перекрывать
    pop edx
    pop ecx
    pop ebx
    pop eax
    pop esi
    ret

.NewLineOutput:
    push eax
    push ebx
    push ecx
    push edx
    mov eax, 4 ; системная функция 4 (write)
    mov ebx, 1 ; дескриптор файла stdout=1
    mov ecx, OutBuf ; адрес буфера
    mov edx, edi ; длина буфера (количество записанных элементов)
    sub edx, OutBuf ; вычисляем длину буфера в байтах
    int 80h ; вызов системной функции для вывода строки
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
Error:
    mov eax, 4 ; системная функция 4 (write)
    mov ebx, 1 ; дескриптор файла stdout=1
    mov ecx, ErrorStr ; адрес сообщения об ошибке
    mov edx, lenError ; длина сообщения об ошибке
    int 80h ; вызов системной функции
    jmp Exit
Exit:
    mov eax, 1 ; системная функция 1 (exit)
    xor ebx, ebx ; код возврата 0
    int 80h ; вызов системной функции
%include "../lib.asm"
