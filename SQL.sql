CREATE DATABASE demo_employees COLLATE utf8mb4_polish_ci;

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
    salary int not null,
    birth_date date not null,
    job_title int not null,
    FOREIGN KEY (job_title) REFERENCES job_title(id)
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
SELECT * FROM employees where job_title = 1;

#5. Pobiera pracowników, którzy mają co najmniej 30 lat
SELECT * FROM employees
WHERE TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) >= 30

#6. Zwiększa wypłatę pracowników na wybranym stanowisku o 10%
UPDATE employees SET salary = salary * 1.10
WHERE  job_title = 1;

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
    salary int not null,
    description varchar(500) null
);

INSERT INTO job_title (name, salary)
VALUES
    ('IT', 10000),
    ('HR', 8500),
    ('Logistics', 9250);

#10. Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)
CREATE TABLE address (
    id int primary key not null auto_increment,
    street varchar(30) null,
    house_no varchar(5) null,
    apartment_no varchar(5) not null,
    zip_code varchar(6) null,
    city varchar(20)
);

#11. Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres
CREATE TABLE employees (
    id int primary key not null auto_increment,
    name varchar(30) not null,
    last_name varchar(50) not null,
    job_title int not null,
    address int not null,
    FOREIGN KEY (job_title) REFERENCES job_title(id),
    FOREIGN KEY (address) REFERENCES address(id)
);

#12. Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)

#13. Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)

#14. Oblicza sumę wypłat dla wszystkich pracowników w firmie

#15. Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym 90210 (albo innym, który będzie miał sens dla Twoich danych testowych)