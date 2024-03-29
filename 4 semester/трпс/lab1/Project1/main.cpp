#include <iostream>
#include <locale.h>
#include <string>
struct Person {

    unsigned int groupCode; //код группы
    std::string name; //ФИО
    std::string birthDate; //дата рождения
    bool delete_flag; //маркер удаления
    static int count;
    //пустой конструктор, конструктор с параметрами, деструктор
    Person() { count++; }
    Person(unsigned int groupCode, std::string name, std::string birthDate) : groupCode(groupCode), name(name), birthDate(birthDate), delete_flag(false) { count++; }
    ~Person() { count--; }
    bool operator<(const Person& other) const { return name < other.name; }

};

//определим количество
int Person::count = 0;
// Размер массива
const int maxSize = 20;
void printTable(Person* persons) {
    std::cout << "---------------------------------------------------" << std::endl;
    std::cout << "| Код группы | ФИО                 | Дата рождения |" << std::endl;
    std::cout << "---------------------------------------------------" << std::endl;
    for (int i = 0; i < Person::count; ++i) {
        if (!persons[i].delete_flag) {
            std::cout << "| " << persons[i].groupCode << " | " << persons[i].name << " | " << persons[i].birthDate << " |" << std::endl;
        }
    }
    std::cout << "---------------------------------------------------" << std::endl;
}

// Функция сортировки вставкой
void insertionSort(Person* arr) {
    for (int i = 1; i < Person::count; ++i) {
        Person current = arr[i];
        int j = i - 1;
        // Сдвигаем элементы, пока не найдем место для вставки
        while (j >= 0 && !current.delete_flag && current < arr[j]) {
            arr[j + 1] = arr[j];
            j--;
        }
        // Вставляем элемент на его место, если он не помечен для удаления
        if (!current.delete_flag) {
            arr[j + 1] = current;
        }
    }
}

int binarySearch(std::string name, Person* persons) {
    int left = 0;
    int right = Person::count - 1;

    while (left <= right) {
        int middle = (left + right) / 2;

        if (persons[middle].name == name) {
            return middle;
        }
        else if (persons[middle].name < name) {
            left = middle + 1;
        }
        else {
            right = middle - 1;
        }
    }

    return -1;
}


void deletePerson(std::string name, Person* persons) {
    int index = binarySearch(name, persons);

    if (index != -1) {
        persons[index].delete_flag = true;
    }
}

int main()
{
    setlocale(LC_ALL, "Russian");
    Person persons[maxSize] = {
        {2033, "Иванов Иван Сергеевич", "15.04.2004"},
        {1015, "Дулина Ирина Алексеевна", "01.10.1999"},
        {7001, "Абрикосов Владимир Владимирович", "31.12.1978"},
        {2033, "Иванова Надежда Васильевна", "20.03.1970"},
        {3005, "Яблонева Карина Кирилловна", "31.02.2002"}
    };
    std::cout << "Несортированная таблица" << std::endl;
    printTable(persons);
    insertionSort(persons);
    std::cout << "Сортированная таблица" << std::endl;
    std::cout << "Введите ФИО" << std::endl;
    std::string name;
    std::getline(std::cin, name);
    std::cout << name << std::endl;
    int a = binarySearch(name, persons);

    std::cout << a << std::endl;
    if (a != -1) {
        std::cout << "Найденный человек:" << std::endl;
        std::cout << persons[a].groupCode << persons[a].name << persons[a].birthDate << std::endl;
    }
    else std::cout << "Такого человека в таблице нет" << std::endl;
    return 0;
}


