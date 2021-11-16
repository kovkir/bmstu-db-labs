import psycopg2
from faker import *
import random 

iterations = 5000

class FootballDB:

    def __init__(self):
        try:
            self.__connection = psycopg2.connect(
                host     = 'localhost', 
                user     = 'postgres', 
                password = '1801', 
                database = 'football_db'
                )
            self.__connection.autocommit = True
            self.__cursor = self.__connection.cursor()
            print("PostgreSQL connection opened ✅\n")

        except Exception as err:
            print("Error while working with PostgreSQL ❌\n", err)
            return

    def __del__(self):
        if self.__connection:
            self.__cursor.close()
            self.__connection.close()
            print("PostgreSQL connection closed ✅\n")

    def create_tables(self):
        try:
            self.__cursor.execute(
                """
                --sql

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
                    club_id         serial  references club(id),
                    number_goals INTEGER NOT NULL,
                    check (number_goals >= 0)
                );
                """
            )
            print("Tables have been added ✅\n")

        except Exception as err:
            print("Error while working with PostgreSQL ❌\n", err)

    def delete_tables(self):
        try:
            self.__cursor.execute(
                """
                --sql
                
                DROP TABLE footballer, coach, club, footballer_coach_club
                """
            )
            print("Tables have been deleted ✅\n")

        except Exception as err:
            print("Error while working with PostgreSQL ❌\n", err)

    def copy_data(self):
        self.__cursor.execute(
                """
                --sql

                copy footballer(first_name, last_name, country, age, salary, phone_number, average_rating) from '/Users/Shared/footballer.csv' delimiter ',' csv;
                copy coach(first_name, last_name, country, age, salary, work_experience, phone_number, email) from '/Users/Shared/coach.csv' delimiter ',' csv;
                copy club(name, country, city, email, foundation_date) from '/Users/Shared/club.csv' delimiter ',' csv;
                copy footballer_coach_club(footballer_id, coach_id, club_id, number_goals) from '/Users/Shared/footballer_coach_club.csv' delimiter ',' csv;
                
                """
            )

def generate_footballer_table_data():
    faker = Faker()
    file = open('../docs/footballer.csv', 'w')

    for i in range (iterations):
        first_name     = faker.first_name()
        last_name      = faker.last_name()
        country        = faker.country()
        phone_number   = faker.phone_number()
        age            = random.randint(16, 45)
        salary         = random.randint(10, 1000) * 10000
        average_rating = random.randint(10, 100) / 10

        line = "{0},{1},{2},{3},{4},{5},{6}\n".format(
            first_name, last_name, country, age, salary, phone_number, average_rating)
    
        file.write(line)

    print("Footballer data was created ✅\n")

    file.close()

def generate_coach_table_data():
    faker = Faker()
    file = open('../docs/coach.csv', 'w')

    for _ in range (iterations):
        first_name      = faker.first_name()
        last_name       = faker.last_name()
        country         = faker.country()
        phone_number    = faker.phone_number()
        email           = faker.unique.email()
        age             = random.randint(30, 80)
        salary          = random.randint(50, 500) * 10000
        work_experience = random.randint(0, age - 30)

        line = "{0},{1},{2},{3},{4},{5},{6},{7}\n".format(
            first_name, last_name, country, age, salary, work_experience, phone_number, email)
    
        file.write(line)

    print("Coach data was created ✅\n")
    
    file.close()

def generate_club_table_data():
    faker = Faker()
    file = open('../docs/club.csv', 'w')

    prefixes = ['Real', 'Atletico', 'Spartak', 'Dynamo', 'Arsenal', 'Borussia', 'Torpedo']
    postfix  = ['United', 'City', 'Hotspur', 'Inter']
    name_list = ['_']

    for _ in range (iterations):
        country         = faker.country()
        city            = faker.city()
        email           = faker.unique.email()
        foundation_date = random.randint(1857, 2021)

        name = '_'
        while name in name_list:
            if random.randint(0, 1):
                name = random.choice(prefixes)  + ' ' + faker.last_name() 
            else:
                name = faker.last_name() + ' ' + random.choice(postfix)
        
        name_list.append(name)

        line = "{0},{1},{2},{3},{4}\n".format(
            name, country, city, email, foundation_date)
        
        file.write(line)

    print("Club data was created ✅\n")
    
    file.close()

def generate_footballer_coach_club_table_data():
    file = open('../docs/footballer_coach_club.csv', 'w')
    end = iterations + 1

    list_1 = [i for i in range(1, end)]
    list_2 = [i for i in range(1, end)]
    list_3 = [i for i in range(1, end)]

    for i in range(iterations):
        footballer_id = random.choice(list_1)
        coach_id      = random.choice(list_2)
        club_id       = random.choice(list_3)

        list_1.remove(footballer_id)
        list_2.remove(coach_id)
        list_3.remove(club_id)

        number_goals = random.randint(0, 10)

        line = "{0},{1},{2},{3}\n".format(
            footballer_id, coach_id, club_id, number_goals)

        file.write(line)

    print("Footballer_Coach_Club data was created ✅\n")

    file.close()

if __name__ == "__main__":

    db = FootballDB()
    db.delete_tables()
    db.create_tables()

    # generate_footballer_table_data()
    # generate_coach_table_data()
    # generate_club_table_data()
    # generate_footballer_coach_club_table_data()

    db.copy_data()
