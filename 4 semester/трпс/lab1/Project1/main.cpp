#include <iostream>
#include <locale.h>
#include <string>
struct Person {

    unsigned int groupCode; //��� ������
    std::string name; //���
    std::string birthDate; //���� ��������
    bool delete_flag; //������ ��������
    static int count;
    //������ �����������, ����������� � �����������, ����������
    Person() { count++; }
    Person(unsigned int groupCode, std::string name, std::string birthDate) : groupCode(groupCode), name(name), birthDate(birthDate), delete_flag(false) { count++; }
    ~Person() { count--; }
    bool operator<(const Person& other) const { return name < other.name; }

};

//��������� ����������
int Person::count = 0;
// ������ �������
const int maxSize = 20;
void printTable(Person* persons) {
    std::cout << "---------------------------------------------------" << std::endl;
    std::cout << "| ��� ������ | ���                 | ���� �������� |" << std::endl;
    std::cout << "---------------------------------------------------" << std::endl;
    for (int i = 0; i < Person::count; ++i) {
        if (!persons[i].delete_flag) {
            std::cout << "| " << persons[i].groupCode << " | " << persons[i].name << " | " << persons[i].birthDate << " |" << std::endl;
        }
    }
    std::cout << "---------------------------------------------------" << std::endl;
}

// ������� ���������� ��������
void insertionSort(Person* arr) {
    for (int i = 1; i < Person::count; ++i) {
        Person current = arr[i];
        int j = i - 1;
        // �������� ��������, ���� �� ������ ����� ��� �������
        while (j >= 0 && !current.delete_flag && current < arr[j]) {
            arr[j + 1] = arr[j];
            j--;
        }
        // ��������� ������� �� ��� �����, ���� �� �� ������� ��� ��������
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
        {2033, "������ ���� ���������", "15.04.2004"},
        {1015, "������ ����� ����������", "01.10.1999"},
        {7001, "��������� �������� ������������", "31.12.1978"},
        {2033, "������� ������� ����������", "20.03.1970"},
        {3005, "�������� ������ ����������", "31.02.2002"}
    };
    std::cout << "��������������� �������" << std::endl;
    printTable(persons);
    insertionSort(persons);
    std::cout << "������������� �������" << std::endl;
    std::cout << "������� ���" << std::endl;
    std::string name;
    std::getline(std::cin, name);
    std::cout << name << std::endl;
    int a = binarySearch(name, persons);

    std::cout << a << std::endl;
    if (a != -1) {
        std::cout << "��������� �������:" << std::endl;
        std::cout << persons[a].groupCode << persons[a].name << persons[a].birthDate << std::endl;
    }
    else std::cout << "������ �������� � ������� ���" << std::endl;
    return 0;
}


