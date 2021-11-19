CREATE TABLE if not exists footballer
(
    id serial PRIMARY KEY,
    first_name     VARCHAR(100) NOT NULL,
    last_name      VARCHAR(100) NOT NULL,
    country        VARCHAR(100) NOT NULL,
    age            INTEGER NOT NULL,
    salary         INTEGER NOT NULL,
    phone_number   VARCHAR(30) UNIQUE NOT NULL,
    average_rating FLOAT(10),
 -- friend         serial references footballer(id), - это поле просили добавить на защите
    check (age >= 16 and age <= 45),
    check ((first_name != '') and (last_name != '')),
    check (country != ''),
    check ((salary >= 100000) and (salary <= 10000000)),
    check ((average_rating >= 1) and (average_rating <= 10))
);

CREATE TABLE if not exists coach
(
    id serial PRIMARY KEY,
    first_name      VARCHAR(100) NOT NULL,
    last_name       VARCHAR(100) NOT NULL,
    country         VARCHAR(100) NOT NULL,
    age             INTEGER NOT NULL,
    salary          INTEGER NOT NULL,
    work_experience INTEGER NOT NULL,
    phone_number    VARCHAR(30) UNIQUE NOT NULL,
    email           VARCHAR(100) UNIQUE,
    check (age >= 30 and age <= 80),
    check ((first_name != '') and (last_name != '')),
    check (country != ''),
    check ((salary >= 500000) and (salary <= 5000000)),
    check (email like '%_@_%._%'),
    check (work_experience >= 0)
);

CREATE TABLE if not exists club
(
    id serial PRIMARY KEY,
    name    VARCHAR(100) UNIQUE NOT NULL,
    country VARCHAR(100) NOT NULL,
    city    VARCHAR(100) NOT NULL,
    email   VARCHAR(100) UNIQUE,
    foundation_date INTEGER NOT NULL,
    check (country != ''),
    check (city != ''),
    check (email like '%_@_%._%'),
    check ((foundation_date >= 1857) and (foundation_date) <= 2021)
);

create table if not exists footballer_coach_club
(
    id serial PRIMARY KEY,
    footballer_id   serial references footballer(id),
    coach_id        serial references coach(id),
    club_id         serial references club(id),
    number_goals INTEGER NOT NULL,
    check (number_goals >= 0)
);