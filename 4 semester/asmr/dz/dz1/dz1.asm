section .data
    FormerMsg db "Изначальный текст: ", 10
    lenFormerMsg equ $-FormerMsg
    SortedMsg db "Отсортированный текст:", 10
    lenSortedMsg equ $-SortedMsg
    ErrorStr db "Error: Invalid input format", 10
    lenError equ $-ErrorStr
    ;Text db "радуйся каждому моменту разного счастья", 10
    ;Text db "ДЛВПРНО АПРЦУПР ПРВАРРВ АРПВАПР ПРОВАПР", 10
    Text db "ДАЛЁКИЙ ДАЛЁКЫЙ ДАЛЁКИЙ ВЕДЁРКО НАДЕЖНО",10
    lenText equ $-Text
    Helper times 10 db " " ;для swap
section .bss

section .text

global _start
_start:
;проверка на ошибку ввода текста
    mov eax, lenText
    mov ebx, 75
    cmp eax, ebx
    jne Error
;вывод сообщения об изначальной строке
    mov eax, 4 ; системная функция 4 (write)
    mov ebx, 1 ; дескриптор файла stdout=1
    mov ecx, FormerMsg ; адрес выводимой строки
    mov edx, lenFormerMsg ; длина выводимой строки
    int 80h ; вызов системной функции
;вывод изначальной строки
    call printText
;сортировка пузырьком
    mov ecx, 4 ;5-1 чтобы можно было поставить указатель перед последним элементом и просмотреть его
    first_iter:
    mov eax, 5 ;всего элементов
    sub eax, ecx ;индекс просматриваемого i
    mov ebx, 0 ;счётчик для внутреннего цикла, 0 для установки указателя перед первым элементом
    xchg eax, ebx ;меняем значения ebx и eax для удобства
    push ecx
    push eax
    second_iter:
        mov ecx, 5 ;не несёт большого смысла, больше служит для продолжения работы внутреннего цикла, проверка и обнуление цикла в конце second_iter
        push ecx
        call load ;загрузка элементов a[j] в esi и a[j+1] в edi
        mov ecx, 15 ;просматриваем первые 15 байтов 7*2 + 1 на совпадение
        repe cmpsb
        jl next ;если a[j]<a[j+1] идём дальше
        call swap ;если a[j]>a[j+1] меняем их местами
        next:
        inc eax ;увеличиваем счётчик second_iter
        pop ecx
        sub ecx, ebx ;считаем граничное значение второго итератора N-i
        cmp eax, ecx ;сравниваем количество уже проверенных элементов с граничным значением
        je exit_second ;если достигли конца цикла выход
        jmp cont
        exit_second: mov ecx, 1 ;выход осуществляем ручным обнулением ecx, при вызове loop ecx станет = 0 и будет произведен выход из цикла
        cont: loop second_iter
    pop eax
    pop ecx
    loop first_iter
;вывод сообщения о сортированной строке
    mov eax, 4 ; системная функция 4 (write)
    mov ebx, 1 ; дескриптор файла stdout=1
    mov ecx, SortedMsg ; адрес выводимой строки
    mov edx, lenSortedMsg ; длина выводимой строки
    int 80h ; вызов системной функции
;вывод сортированной строки
    call printText
    jmp Exit
load:
    push eax
    push ebx
    mov ebx, 15
    mul ebx ;eax*15
    lea esi, [Text + eax] ;элемент j
    lea edi, [Text + eax+ebx] ; элемент j+1
    pop ebx
    pop eax
    ret
swap:
    push eax
    push ebx
    push ecx
    push esi
    push edi
    mov ebx, 15
    mul ebx
    ; k:=a[j]
    mov ecx, 14
    lea esi, [Text + eax]
    lea edi, [Helper]
    rep movsb
    ; a[j]:=a[j+1]
    mov ecx, 14
    lea esi, [Text + eax + ebx]
    lea edi, [Text+eax]
    rep movsb
    ; a[j+1] := k
    mov ecx, 14
    lea esi, [Helper]
    lea edi, [Text+eax+ebx]
    rep movsb
    pop edi
    pop esi
    pop ecx
    pop ebx
    pop eax
    ret
printText:
    mov eax, 4 ; системная функция 4 (write)
    mov ebx, 1 ; дескриптор файла stdout=1
    mov ecx, Text ; адрес выводимой строки
    mov edx, lenText ; длина выводимой строки
    int 80h ; вызов системной функции
    ret
Error:
    mov eax, 4 ;
    mov ebx, 1 ;
    mov ecx, ErrorStr ;
    mov edx, lenError ;
    int 80h ;
    jmp Exit
; выход
Exit:
mov eax, 1 ;
xor ebx, ebx ;
int 80h ;
%include "../lib.asm"

