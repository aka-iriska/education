import random

import sqlite3

from typing import NoReturn
from random_address import real_random_address
import pickle
import os
from datetime import datetime, timedelta


class Data:
    """
    Класс для генерации данных
    """

    _USER_TO_FIND = []
    """
    :attr:`USER_TO_FIND` is an :class:`Data`
    Люди, которых ищут
    """

    def __init__(self):
        # Запускаем заполнение при создании экземпляра класса `Data`
        self.__fill()

    @staticmethod
    def __gen_datetime(min_year: int = 2023, max_year: int = 2055) -> str:
        """
        :param min_year: стартовый год генерации
        :param max_year: конечный год генерации
        :return:
        Генератор данных в формате `Date`
        """

        # Генерируем datetime в формате yyyy-mm-dd hh:mm:ss.000000
        start = datetime(min_year, 1, 1, 00, 00, 00)
        years = max_year - min_year + 1
        end = start + timedelta(days=365 * years)

        date = (start + (end - start) * random.random()).strftime("%Y-%m-%d")
        return date

    def __fill(self) -> NoReturn:
        """
        :return:
        """

        if not os.path.exists('USER_TO_FIND'):
            for i in range(1, 1001):
                email = 'pupkin@gmail.com'
                name = 'Пупкин Дракула Петрович'

                address = real_random_address()['address1']
                gender = random.choice(['м', 'ж'])  # gender
                age = random.randint(1, 149)
                body_type = random.choice(['эктоморф', 'мезоморф', 'эндоморф'])
                height = random.randint(100, 250)
                race = random.choice(['европиоид', 'негроид', 'монголоид', 'другое'])
                facial_hair = random.choice(['есть', 'нет'])
                voice = random.choice(['сопрано', 'тенор', 'альт', 'баритон', 'контральто', 'бас'])
                r = lambda: random.randint(0, 255)
                hair_color = '#%02X%02X%02X' % (r(), r(), r())
                ears = random.choice(
                    ['круглые', 'угловатые', 'заостренные', 'торчащие', 'свободная мочка', 'прилегающая мочка',
                     'широкая мочка'])
                wrinkles = random.choice(['есть', 'нет'])
                forehead = random.choice(['прямой скошенный', 'покатый', 'прямой',
                                          'округлый', 'выпуклый', 'волнистый скошенный'])
                user_id = 1

                created_at = self.__gen_datetime()
                updated_at = self.__gen_datetime()

                # Порядок важен (также как и в БД)
                row = [i, address, gender, age, body_type, height, race, facial_hair, voice, hair_color, ears,
                       wrinkles, created_at, updated_at, forehead, email, name, user_id]
                self._USER_TO_FIND.append(row)
                print(f'Пользователь № {i} добавлен')

            with open("USER_TO_FIND", "wb") as fp:
                pickle.dump(self._USER_TO_FIND, fp)
        else:
            with open("USER_TO_FIND", "rb") as fp:
                self._USER_TO_FIND = pickle.load(fp)

            print(f'Данные восстановлены {self._USER_TO_FIND[1:3]}')

    def get_data(self) -> list:
        """
        :return: `list`
        """

        return self._USER_TO_FIND


class DB:
    """
    Класс для подключения к БД и ее заполнения
    """

    def __init__(self, db_name: str, autoconnect: bool = True):
        """
        :param db_name: Имя базы данных
        :param autoconnect: Авто-подключение
        """

        self._db_name = db_name

        self.connection = None
        self.cursor = None

        if autoconnect:
            self.connect()

    def connect(self):
        """
        :return:
        Подключение к существующей базе данных
        """

        try:
            self.connection = sqlite3.connect(self._db_name)
            self.cursor = self.connection.cursor()

            self.get_current_connection()
        except Exception as error:
            print('Ошибка при работе с SQLITE3', error)

    def get_current_connection(self) -> NoReturn:
        """
        :return:
        Проверяем подключение
        """

        # Выполнение SQL-запроса
        self.cursor.execute('SELECT SQLITE_VERSION();')

        # Получить результат
        record = self.cursor.fetchone()
        print('Вы подключены к - ', record, "\n")

    def fill(self) -> NoReturn:
        """
        :return:
        Функция автоматического заполняем БД (перед использованием рекомендуется проверить команды с помощью
        секции `test`)
        """

        # Получаем данные для вставки
        users = Data().get_data()

        values = ''

        for i in range(len(users[0])):
            values += '?'

            if i != len(users[0]) - 1:
                values += ', '

        print('Data len:', len(users[0]))
        insert_query = f"INSERT INTO people_finds VALUES ({values})"
        self.cursor.executemany(insert_query, users)
        self.connection.commit()


if __name__ == '__main__':
    db = DB('../storage/development.sqlite3')
    db.fill()
