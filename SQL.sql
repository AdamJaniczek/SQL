CREATE DATABASE demo_employees COLLATE utf8mb4_polish_ci;
USE demo_employees;

# 1. Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko). W tabeli mogą być dodatkowe kolumny, które uznasz za niezbędne.
USE demo_employees;

CREATE TABLE job_title (
    id int primary key not null auto_increment,
    name varchar(20) unique not null,
    description varchar(500) null
);
INSERT INTO job_title (name)
VALUES
    ('IT'),
    ('HR'),
    ('Logistics');

CREATE TABLE employees (
    id int primary key not null auto_increment,
    name varchar(30) not null,
    lastName varchar(50) not null,
    salary decimal(10,2) not null,
    birth_date date not null,
    job_title_id int not null,
    FOREIGN KEY (job_title_id) REFERENCES job_title(id)
);

#2. Wstawia do tabeli co najmniej 6 pracowników
INSERT INTO employees (name, lastName, salary, birth_date, job_title)
    VALUES
        ('Jan', 'Kowalski', 13000, '1987-04-17', 1),
        ('Beata', 'Czyk', 8500, '1967-10-04', 3),
        ('Tomasz', 'Abacki', 5500, '1993-07-29', 2),
        ('Donald', 'Nowak', 4500, '1999-12-23', 1),
        ('Piotr', 'Wiśnia', 5900, '2005-04-29', 2),
        ('Iza', 'Mazurek', 7500, '1987-04-17', 3);

#3. Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku
SELECT * FROM employees ORDER BY lastName ASC;

#4. Pobiera pracowników na wybranym stanowisku
SELECT * FROM employees where job_title_id = 1;

#5. Pobiera pracowników, którzy mają co najmniej 30 lat
SELECT * FROM employees
WHERE TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) >= 30;

#6. Zwiększa wypłatę pracowników na wybranym stanowisku o 10%
UPDATE employees SET salary = salary * 1.10
WHERE  job_title_id = 1;

#7. Pobiera najmłodszego pracowników (uwzględnij przypadek, że może być kilku urodzonych tego samego dnia)
SELECT * FROM employees
WHERE birth_date = (
    SELECT MAX(birth_date)
    FROM employees);

#8. Usuwa tabelę pracownik
DROP TABLE employees;
DROP TABLE job_title;

#9. Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)
CREATE TABLE job_title (
    id int primary key not null auto_increment,
    name varchar(20) unique not null,
    salary decimal(10,2) not null,
    description varchar(500) null
);

INSERT INTO job_title (name, salary)
VALUES
    ('IT', 10000.00),
    ('HR', 8500.00),
    ('Logistics', 9250.00);

#10. Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)
CREATE TABLE address (
    id int primary key not null auto_increment,
    street varchar(30) null,
    house_no varchar(5) null,
    apartment_no varchar(5) null,
    zip_code varchar(6) null,
    city varchar(20) not null
);

#11. Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres
CREATE TABLE employees (
    id int primary key not null auto_increment,
    name varchar(30) not null,
    last_name varchar(50) not null,
    job_title_id int not null,
    address_id int null,
    FOREIGN KEY (job_title_id) REFERENCES job_title(id),
    FOREIGN KEY (address_id) REFERENCES address(id)
);

#12. Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)
INSERT INTO address (id, street, house_no, apartment_no, zip_code, city)
VALUES
    (1, 'Wietrzna', '10B', '7', '53300', 'Wrocław'),
    (2, 'Paprotna', '2', null, '53300', 'Wrocław'),
    (3, 'Sejmowa', '19', '1C', '00980', 'Warszawa'),
    (4, 'Poznańska', '95', '12D', '23670', 'Poznań'),
    (5, 'Miodowa', '7', null, '39000', 'Inowrocław');

INSERT INTO employees (name, last_name, job_title_id, address_id)
VALUES
    ('Jan', 'Kowalski', 1, 1),
    ('Beata', 'Czyk', 3, 2),
    ('Tomasz', 'Abacki', 2, 3),
    ('Donald', 'Nowak', 1, 4),
    ('Piotr', 'Wiśnia', 2, 5);

#13. Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)
SELECT e.name, e.last_name, j.name, j.salary, a.street, a.house_no, a.apartment_no, a.zip_code, a.city FROM employees AS e
INNER JOIN job_title AS j on e.job_title_id = j.id
INNER JOIN address AS a on e.address_id = a.id
ORDER BY e.last_name ASC;

#14. Oblicza sumę wypłat dla wszystkich pracowników w firmie
SELECT SUM(j.salary) as 'total salary'  FROM employees AS e
INNER JOIN job_title AS j on e.job_title_id = j.id;

#15. Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym 90210 (albo innym, który będzie miał sens dla Twoich danych testowych)
SELECT e.name, e.last_name, a.street, a.house_no, a.apartment_no, a.zip_code, a.city FROM employees AS e
INNER JOIN address AS a on e.address_id = a.id
WHERE a.zip_code = '53300';