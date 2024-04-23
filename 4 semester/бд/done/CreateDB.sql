-- Создаем ДБ
CREATE DATABASE "Car rental"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Russian_Russia.1251'
    LC_CTYPE = 'Russian_Russia.1251'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- 1) Работник - 5_000
CREATE TABLE IF NOT EXISTS workers (
id integer NOT NULL GENERATED ALWAYS AS IDENTITY, -- id работника

name TEXT NOT NULL, -- Ф.И.О. работника
position TEXT NOT NULL, -- Должность
salary INTEGER NOT NULL, -- Зарплата
phone TEXT NOT NULL CHECK (phone ~ '^[0-9]{10}$'), -- Контактный телефон
PRIMARY KEY ( id )
);

-- 2) Филиал - 100
CREATE TABLE IF NOT EXISTS branches (
id integer NOT NULL GENERATED ALWAYS AS IDENTITY, -- id филиала
worker_id INTEGER NOT NULL, -- id работника

address TEXT NOT NULL, -- Адрес филиала
working_time TEXT NOT NULL, -- Рабочее время
phone TEXT NOT NULL CHECK (phone ~ '^[0-9]{10}$'), -- Контактный телефон

PRIMARY KEY ( id ),
FOREIGN KEY (worker_id) REFERENCES workers (id) -- Связь с клиентом
);

-- 3) Таблица Автомобиль - 20_000
CREATE TABLE IF NOT EXISTS cars (
id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY, -- id авто
branch_id INTEGER NOT NULL, -- id филиала

brand TEXT NOT NULL, -- Марка
release_year INTEGER NOT NULL, -- Год выпуска
price INTEGER NOT NULL, -- Цена
country_of_manufacture TEXT NOT NULL, -- Страна производства

PRIMARY KEY ( id ),
FOREIGN KEY (branch_id) REFERENCES branches (id) -- Связь с филиалом
);

-- 4) Тип проката - 100
CREATE TABLE IF NOT EXISTS type_of_rental (
id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY, -- id типа

type_name TEXT NOT NULL, -- Название типа
price_per_hour INTEGER NOT NULL, -- Цена в час
price_per_day INTEGER NOT NULL, -- Цена в сутки

PRIMARY KEY ( id )
);

-- 5) Клиенты - 80_000
CREATE TABLE IF NOT EXISTS customers (
id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY, -- id клиента

name TEXT NOT NULL, -- Ф.И.О. клиента
address TEXT NOT NULL, -- Адрес
birthday_date DATE NOT NULL CHECK (birthday_date + INTERVAL '18 years' < CURRENT_DATE AND birthday_date >= CURRENT_DATE - INTERVAL '150 years'), -- Дата рождения
phone TEXT NOT NULL CHECK (phone ~ '^[0-9]{10}$'), -- Телефон

PRIMARY KEY ( id )
);

-- 6) Платежи - 1_000
CREATE TABLE IF NOT EXISTS payments (
id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY, -- id платежа
customer_id INTEGER NOT NULL, -- id клиента, оплатившего заказ

price INTEGER NOT NULL, -- Сумма платежа
payment_date DATE NOT NULL CHECK (payment_date <= CURRENT_DATE), -- Дата платежа
payment_method TEXT NOT NULL, -- Способ оплаты

PRIMARY KEY ( id ),
FOREIGN KEY (customer_id) REFERENCES customers (id) -- Связь с клиентом
);

-- 7) Автопрокат - 1_000_000
CREATE TABLE IF NOT EXISTS car_rental (
id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY, -- id автопроката
car_id INTEGER NOT NULL, -- id автомобиля
customer_id INTEGER NOT NULL, -- id клиента
type_of_rental_id INTEGER NOT NULL, -- id типа проката
payment_id INTEGER NOT NULL, -- id платежа

date_of_receipt DATE NOT NULL CHECK (date_of_receipt <= CURRENT_DATE), -- Дата получения
return_date DATE NOT NULL, -- Дата возврата

PRIMARY KEY ( id ),
FOREIGN KEY (car_id) REFERENCES cars (id), -- Связь с автомобилем
FOREIGN KEY (customer_id) REFERENCES customers (id), -- Связь с клиентом
FOREIGN KEY (type_of_rental_id) REFERENCES type_of_rental (id), -- Связь с типом проката
FOREIGN KEY (payment_id) REFERENCES payments (id) -- Связь с платежом
);
