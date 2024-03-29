#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
#include <locale.h>
#include <cstdlib>

struct Person {
    unsigned int groupCode; //код группы
    std::string name; //ФИО
    std::string birthDate; //дата рождения
    bool delete_flag; //маркер удаления

    Person() {}
    Person(unsigned int groupCode, std::string name, std::string birthDate) :
        groupCode(groupCode), name(name), birthDate(birthDate), delete_flag(false)
    {}

    bool operator<(const Person& other) const { return name < other.name; }
};

//Вывод
void printTable(const std::vector<Person>& persons) {
    std::cout << "---------------------------------------------------" << std::endl;
    std::cout << "| Код группы | ФИО         | Дата рождения |" << std::endl;
    std::cout << "---------------------------------------------------" << std::endl;

    for (const Person& person : persons) {
        std::cout << "| " << person.groupCode << " | " << person.name << " | " << person.birthDate << " |" << std::endl;
    }

    std::cout << "---------------------------------------------------" << std::endl;
}
// последовательный поиск
int poslSearch(std::string name, const std::vector<Person>& persons) {
    for (int i = 0; i < persons.size(); ++i) {
        const Person& person = persons[i];
        if (!person.delete_flag && person.name == name) {
            return i;
        }
    }
    return -1;
}
// квадратичная выборка
// поиск минимального индекса в 1 группе
int min_index(const std::vector<Person>& persons, int start, int end) {
    int ind_min = -1;
    std::string min_str(255, 'я');

    for (int i = start; i < end; i++) {
        if (i < persons.size()) {
            if (persons[i].name < min_str){// && persons[i].name != min_str) {
                min_str = persons[i].name;
                ind_min = i;
            }
        }
    }

    return ind_min;
}
// вычисляем минимальный индекса в массиве Sn
int min_index_sn(const std::vector<Person>& persons, const std::vector<int>& arr, int length) {
    int ind_min = -1;
    std::string min_str(255, 'я');

    for (int i = 0; i < length; i++) {
        if (arr[i] != -1) {
            if (persons[arr[i]].name < min_str) {
                min_str = persons[arr[i]].name;
                ind_min = i;
            }
        }
    }

    return ind_min;
}

// Упорядочивание квадратичной выборкой
void quadrSort(std::vector<Person>& persons) {
    // Количество групп
    const int num_groups = ceil(sqrt(persons.size()));

    // Массив для хранения индексов начала каждой группы
    std::vector<int> group_starts(num_groups);
    // Разделение на группы SN и ищем мин индекс в каждой из них, лишние индексы заполняются -1
    for (int i = 0; i < num_groups; i++) {
        group_starts[i] = min_index(persons, i * num_groups, (i + 1) * num_groups);
    }
    // ищем минимальное в готовом массиве Sn
    int index_groups = min_index_sn(persons, group_starts, num_groups);
    std::vector<Person> resultArray(persons.size());
    int i = 0;
    //теперь в цикле движемся по каждой группе заново
    while (index_groups != -1) {
        resultArray[i] = persons[group_starts[index_groups]];
        persons[group_starts[index_groups]].name = std::string(255, 'я');
        group_starts[index_groups] = min_index(persons, index_groups * num_groups, (index_groups + 1) * num_groups);
        index_groups = min_index_sn(persons, group_starts, num_groups);

        i++;
    }
    std::swap(persons, resultArray);
}


// Маркировка нужного элемента и удаление всех с delete_flaf == true
void defineDelete(int index, std::vector<Person>& persons) {
    if (index != -1) {
        persons[index].delete_flag = true;
    }
}
void deletePerson(std::vector<Person>& persons) {
    int write_index = 0;
    for (int read_index = 0; read_index < persons.size(); read_index++) {
        if (!persons[read_index].delete_flag) {
            persons[write_index++] = persons[read_index];
        }
    }
    persons.resize(write_index);
}
int main() {
    setlocale(LC_ALL, "Russian");
    system("chcp 1251"); // настраиваем кодировку консоли
    // Динамический массив
    std::vector<Person> persons;

    // Инициализация
    persons.push_back({ 2033, "Иванов Иван Сергеевич", "15.04.2004" });
    persons.push_back({ 1015, "Дулина Ирина Алексеевна", "01.10.1999" });
    persons.push_back({ 7001, "Абрикосов Владимир Владимирович", "31.12.1978" });
    persons.push_back({ 2033, "Иванова Надежда Васильевна", "20.03.1970" });
    persons.push_back({ 3005, "Яблонева Карина Кирилловна", "31.02.2002" });

    std::cout << "Несортированная таблица" << std::endl;
    printTable(persons);
    std::cout << persons.size() << std::endl;

    //Поиск по имени
    std::cout << "Введите ФИО" << std::endl;
    std::string name;
    std::getline(std::cin, name);
    int a = poslSearch(name, persons);
    if (a != -1) {
        std::cout << "Найденный человек:" << std::endl;
        std::cout << persons[a].groupCode << " " << persons[a].name << " " << persons[a].birthDate << std::endl;
    }
    else std::cout << "Такого человека в таблице нет" << std::endl;

    //Сортировка таблицы=
    quadrSort(persons);
    std::cout << "Сортированная таблица" << std::endl;
    printTable(persons);
    
    //Удаление маркировкой
    defineDelete(a, persons);
    a = poslSearch("Иванов Иван Сергеевич", persons);
    defineDelete(a, persons);
    deletePerson(persons);
    std::cout << "Таблица с удалённым значением" << std::endl;
    printTable(persons);
    persons.push_back({ 1101, "Захаров Борис Владимирович", "12.12.1912" });
    printTable(persons);
    return 0;
}