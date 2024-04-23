import time

import psycopg2
from faker import Faker
import random
import requests
from bs4 import BeautifulSoup
import json
from datetime import datetime, timedelta
from tqdm import tqdm
from typing import NoReturn


class FillDB:
    def __init__(self, autoconnect: bool = True):
        if autoconnect:
            self.cursor, self.connection = self.connect()
        else:
            self.cursor, self.connection = None, None

        self.faker = Faker()
        self._phones = []

    @staticmethod
    def connect() -> tuple[psycopg2.extensions.cursor, psycopg2.extensions.connection]:
        connection = psycopg2.connect(database='Car rental',
                                      user='postgres',
                                      password='1234',
                                      host='127.0.0.1',
                                      port='5432',
                                      )
        cursor = connection.cursor()

        return cursor, connection

    def fill_workers(self, iterations: int) -> NoReturn:
        """
        :param iterations: количество записей в таблице
        :return: `NoReturn`

        Заполняем таблицу worker
        """

        print('Fill workers...')

        with open('data.json', 'r') as json_file:
            # 'Специалист-кассир', 'Мастер-приемщик', 'Мастер', 'Бухгалтер', 'Автомаляр', 'Автослесарь',
            # 'Автомойщик', 'Автосварщик', 'Шиномонтажник', 'Слесарь'
            data: list = json.load(json_file)['worker-positions']

        items = set()

        progress_bar = tqdm(total=iterations, desc="Progress", unit="iteration")

        while len(items) != iterations:
            name = self.faker.name()
            position = random.choice(data)
            salary = random.randint(30_000, 150_000)
            phone = self._generate_phone_number()

            item = (name, position, salary, phone)
            items.add(item)

            progress_bar.update(1)

        print('Начата вставка в БД...')
        insert_query = """INSERT INTO workers (name, position, salary, phone) VALUES (%s, %s, %s, %s)"""
        self.cursor.executemany(insert_query, list(items))
        self.connection.commit()
        print('Вставка в БД завершена')

    def fill_type_of_rental(self, iterations: int) -> NoReturn:
        """
        :param iterations: количество записей в таблице
        :return: `NoReturn`

        Заполняем таблицу type_of_rental
        Цена в час от 100р до 500р
        Цена в день от 2_000р до 50_000р
        """

        print('Fill type_of_rental...')

        with open('data.json', 'r') as json_file:
            # Краткосрочная, Долгосрочная, Эксклюзивная, С водителем, Без водителя
            data: list = json.load(json_file)['type-of-rental']

        items = set()

        progress_bar = tqdm(total=iterations, desc="Progress", unit="iteration")

        while len(items) != iterations:
            type_name = random.choice(data)
            price_per_hour = random.randint(100, 500)
            price_per_day = random.randint(2_000, 50_000)

            item = (type_name, price_per_hour, price_per_day)
            items.add(item)

            progress_bar.update(1)

        print('Начата вставка в БД...')
        insert_query = """INSERT INTO type_of_rental (type_name, price_per_hour, price_per_day) VALUES (%s, %s, %s)"""
        self.cursor.executemany(insert_query, list(items))
        self.connection.commit()
        print('Вставка в БД завершена')

    def fill_cars(self, iterations: int, branches: int) -> NoReturn:
        """
        :param iterations: количество записей в таблице
        :param branches: макс. число филиалов
        :return: `NoReturn`

        Заполняем таблицу car

        `data = self._parse_car_brand()` - парсим вики
        Какие машины находятся в филиале
        """

        print('Fill cars...')

        with open('data.json', 'r') as json_file:
            data: dict = json.load(json_file)['Car']

        items = set()

        progress_bar = tqdm(total=iterations, desc="Progress", unit="iteration")

        while len(items) != iterations:
            branch_id = random.randint(1, branches)

            country_of_manufacture = random.choice(list(data.keys()))
            brand = random.choice(data[country_of_manufacture])

            release_year = random.randint(2004, 2024)
            price = random.randint(300_000, 50_000_000)

            item = (branch_id, brand, release_year, price, country_of_manufacture)
            items.add(item)

            progress_bar.update(1)

        print('Начата вставка в БД...')
        insert_query = """INSERT INTO cars (branch_id, brand, release_year, price, country_of_manufacture) VALUES (%s, %s, %s, %s, %s)"""
        self.cursor.executemany(insert_query, list(items))
        self.connection.commit()
        print('Вставка в БД завершена')

    def fill_customers(self, iterations: int) -> NoReturn:
        """
        :param iterations: количество записей в таблице
        :return: `NoReturn`

        Заполняем таблицу customers
        """

        print('Fill customers...')

        items = set()

        progress_bar = tqdm(total=iterations, desc="Progress", unit="iteration")

        while len(items) != iterations:
            name = self.faker.name()
            address = self.faker.address()
            birthday_date = self._generate_birthday()
            phone = self._generate_phone_number()

            item = (name, address, birthday_date, phone)
            items.add(item)

            progress_bar.update(1)

        print('Начата вставка в БД...')
        insert_query = """INSERT INTO customers (name, address, birthday_date, phone) VALUES (%s, %s, %s, %s)"""
        self.cursor.executemany(insert_query, list(items))
        self.connection.commit()
        print('Вставка в БД завершена')

    def fill_payments(self, iterations: int, customers: int) -> NoReturn:
        """
        :param iterations: количество записей в таблице
        :param customers: макс. число клиентов
        :return: `NoReturn`

        Генерируем оплату от 1000 до 1млн
        """

        print('Fill payments...')

        with open('data.json', 'r') as json_file:
            # Онлайн картой, Офлайн картой, Наличными, Биткоинами
            data: list = json.load(json_file)['payment-method']

        items = set()

        progress_bar = tqdm(total=iterations, desc="Progress", unit="iteration")

        while len(items) != iterations:
            customer_id = random.randint(1, customers)
            price = random.randint(1_000, 1_000_000)
            payment_date = self._generate_date()
            payment_method = random.choice(data)

            item = (customer_id, price, payment_date, payment_method)
            items.add(item)

            progress_bar.update(1)

        print('Начата вставка в БД...')
        insert_query = """INSERT INTO payments (customer_id, price, payment_date, payment_method) VALUES (%s, %s, %s, %s)"""
        self.cursor.executemany(insert_query, list(items))
        self.connection.commit()
        print('Вставка в БД завершена')

    def fill_branches(self, iterations: int, workers: int) -> NoReturn:
        """
        :param iterations: количество записей в таблице
        :param workers: макс. число работников
        :return: `NoReturn`
        """

        print('Fill branches...')

        items = set()

        progress_bar = tqdm(total=iterations, desc="Progress", unit="iteration")

        while len(items) != iterations:
            worker_id = random.randint(1, workers)
            address = self.faker.address()
            working_time = random.choice(['8:00-20:00', '8:00-21:00', '8:00-22:00', '8:00-23:00',
                                          '9:00-20:00', '9:00-21:00', '9:00-22:00', '9:00-23:00',
                                          '10:00-20:00', '10:00-21:00', '10:00-22:00', '10:00-23:00',
                                          ])

            phone = self._generate_phone_number()

            item = (worker_id, address, working_time, phone)
            items.add(item)

            progress_bar.update(1)

        print('Начата вставка в БД...')
        insert_query = """INSERT INTO branches (worker_id, address, working_time, phone) VALUES (%s, %s, %s, %s)"""
        self.cursor.executemany(insert_query, list(items))
        self.connection.commit()
        print('Вставка в БД завершена')

    def fill_car_rental(self, iterations: int, cars: int, customers: int, type_of_rentals: int,
                        payments: int) -> NoReturn:
        """
        :param iterations: количество записей в таблице
        :param cars: макс. число машин для связи FK
        :param customers: макс. число клиентов для связи FK
        :param type_of_rentals: макс. число типов проката для связи FK
        :param payments: макс. число платежей для связи FK
        :return: `NoReturn`
        """

        print('Fill car_rental...')

        items = set()

        # Инициализируйте экземпляр tqdm с помощью `iterations`
        progress_bar = tqdm(total=iterations, desc="Progress", unit="iteration")

        while len(items) != iterations:
            car_id = random.randint(1, cars)
            customer_id = random.randint(1, customers)
            type_of_rental_id = random.randint(1, type_of_rentals)
            payment_id = random.randint(1, payments)

            date_of_receipt = self._generate_date()
            return_date = self._generate_return_date()

            item = (car_id, customer_id, type_of_rental_id, payment_id, date_of_receipt, return_date)
            items.add(item)

            progress_bar.update(1)

        print('Начата вставка в БД...')
        insert_query = """INSERT INTO car_rental (car_id, customer_id, type_of_rental_id, payment_id, date_of_receipt, return_date) VALUES (%s, %s, %s, %s, %s, %s)"""
        self.cursor.executemany(insert_query, list(items))
        self.connection.commit()
        print('Вставка в БД завершена')

    def fill(self):
        start = time.time()

        workers = 5_000
        type_of_rental = 100
        cars = 20_000
        customers = 80_000
        payments = 1_000
        branches = 100
        car_rental = 1_000_000

        _total = workers + type_of_rental + cars + customers + payments + branches + car_rental

        self.fill_workers(workers)
        self.fill_branches(branches, workers)
        self.fill_cars(cars, branches)
        self.fill_type_of_rental(type_of_rental)
        self.fill_customers(customers)
        self.fill_payments(payments, customers)
        self.fill_car_rental(car_rental, cars, customers, type_of_rental, payments)

        print(f'Заполенние {_total} записей заняло: {time.time() - start}сек')

    # ---------------- Секция генераторов ---------------------------------------- #
    def _generate_phone_number(self) -> str:
        """
        :return: 10 цифр номера телефона
        """

        phone = ''.join([str(random.randint(1, 9)) for _ in range(10)])
        if phone not in self._phones:
            self._phones.append(phone)
        else:
            while phone in self._phones:
                phone = ''.join([str(random.randint(1, 9)) for _ in range(10)])

        return phone

    @staticmethod
    def _generate_birthday() -> str:
        """
        :return: s%Y-%m-%d
        Генерируем день рождения от 1950 до 2004
        """

        # Генерация случайной даты в пределах определенного диапазона
        start_date = datetime(1950, 1, 1)
        end_date = datetime(2004, 12, 31)

        random_birthday = start_date + timedelta(days=random.randint(0, (end_date - start_date).days))

        return random_birthday.strftime('%Y-%m-%d')

    @staticmethod
    def _generate_date() -> str:
        """
        :return: %Y-%m-%d
        Генерируем дату начиная с 2000 заканчивая текущим временем
        """

        # Генерация случайной даты в пределах определенного диапазона
        start_date = datetime(2000, 1, 1)
        end_date = datetime.now()

        random_date = start_date + timedelta(days=random.randint(0, (end_date - start_date).days))

        return random_date.strftime('%Y-%m-%d')

    @staticmethod
    def _generate_return_date() -> str:
        """
        :return: %Y-%m-%d
        Генерируем дату возврата машины, начиная с сегодня, заканчивая 2025г
        """

        # Генерация случайной даты в пределах определенного диапазона
        start_date = datetime.now()
        end_date = datetime(2025, 1, 1)

        random_date = start_date + timedelta(days=random.randint(0, (end_date - start_date).days))

        return random_date.strftime('%Y-%m-%d')

    @staticmethod
    def _parse_car_brand() -> dict:
        """
        :return: список стран производства и машин
        Парсим Вики, чтобы достать все бренды
        """

        url = "https://en.wikipedia.org/wiki/List_of_car_brands"
        data = {'Car': {}}

        # Отправка GET-запроса к странице
        response = requests.get(url)

        # Проверка успешности запроса
        if response.status_code == 200:
            print('Подключение прошло успешно!')
            # Создание объекта BeautifulSoup для парсинга HTML
            soup = BeautifulSoup(response.text, 'html.parser')

            # Находим div с указанными классами
            mw_content_div = soup.find('div', {'class': 'mw-content-ltr mw-parser-output'})

            # Ищем все теги h2
            h2_tags = mw_content_div.find_all('h2')

            # Итерируем по всем тегам h2
            for h2_tag in h2_tags:
                # Получаем название страны
                country_name_tag = h2_tag.find('span', {'class': 'mw-headline'})
                if country_name_tag:
                    country_name = country_name_tag.text.strip()
                    if country_name in ['See also', 'References']:
                        continue

                    print(f"\nНазвание страны: {country_name}")
                    data['Car'][country_name] = []

                    # Ищем следующий за h2 тег ul
                    next_ul = h2_tag.find_next('ul')

                    # Проверяем, есть ли информация о брендах
                    if next_ul:
                        # Итерируем по элементам списка
                        for li_tag in next_ul.find_all('li', recursive=False):
                            # Извлекаем название бренда из тега a
                            brand_name_tag = li_tag.find('a')

                            if brand_name_tag:
                                brand_name = brand_name_tag.text
                                data['Car'][country_name].append(brand_name)

                                # Выводим результат
                                print(f"Бренд: {brand_name}")
                    else:
                        print(f"Для страны {country_name} информация отсутствует.")
        else:
            print("Ошибка при запросе:", response.status_code)

        # Сохранение списка в JSON файл
        with open('data.json', 'w') as json_file:
            json.dump(data, json_file)

        return data


if __name__ == '__main__':
    db = FillDB()
    db.fill()
