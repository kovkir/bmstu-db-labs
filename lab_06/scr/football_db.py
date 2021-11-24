import psycopg2
from color import green, blue, base_color

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

    def __sql_executer(self, sql_query):
        try:
            self.__cursor.execute(sql_query)
        except Exception as err:
            print("Error while working with PostgreSQL ❌\n", err)
            return
    
        return sql_query

    def scalar_query(self):

        print("%sПолучить среднюю зарплату футболистов из России.%s\n"
            %(green, base_color))

        sql_query = \
            """
            -- 1. Выполнить скалярный запрос.

            SELECT avg(salary)
            FROM footballer
            WHERE country = 'Russian Federation';
            """

        if self.__sql_executer(sql_query) is not None:
            row = self.__cursor.fetchone()

            return row

    def join_query(self):

        print("%sПулучть фамилии футбулистов, тренеров, названия клубов и кол-во голов,\n"
               "забитых данными футболистами под руководством данных тренеров"
               "за данные клубы (первые 10 записей).%s\n"
            %(green, base_color))

        sql_query = \
            """
            -- 2. Выполнить запрос с несколькими соединениями (JOIN).

            SELECT f.last_name  AS surname_footballer,
                co.last_name AS surname_coach,
                cl.name      AS name_club, 
                fcc.number_goals
            FROM footballer_coach_club AS fcc 
                JOIN footballer AS f  ON fcc.footballer_id = f.id
                JOIN coach      AS co ON fcc.id = co.id
                JOIN club       AS cl ON fcc.id = cl.id 
            WHERE f.id < 11;
            """
        
        if self.__sql_executer(sql_query) is not None:

            row = self.__cursor.fetchone()
            table = list()

            while row is not None:
                table.append(row)
                row = self.__cursor.fetchone()

            return table

    def cte_row_number_query(self):

        print("%sСоздать полные дубли в таблице club, после чего устранить их"
               " с использованием функции ROW_NUMBER().\nВывести первые 10 записей.%s\n"
            %(green, base_color))

        sql_query = \
            """
            -- 3. Выполнить запрос с ОТВ(CTE) и оконными функциями.

            WITH table_with_duplicates AS
            (
                SELECT *
                FROM club

                UNION ALL

                SELECT *
                FROM club
            ),
            tmp_table AS
            (   
                SELECT *, ROW_NUMBER() OVER (PARTITION BY id) AS number
                FROM table_with_duplicates
            )
            SELECT *
            FROM tmp_table
            WHERE number = 1 AND id < 11;
            """
        
        if self.__sql_executer(sql_query) is not None:

            row = self.__cursor.fetchone()
            table = list()

            while row is not None:
                table.append(row)
                row = self.__cursor.fetchone()

            return table
    
    def metadata_query(self):

        print("%sПолучить имя текущей базы данных и лимит подключений к ней.%s\n"
            %(green, base_color))

        sql_query = \
            """
            -- 4. Выполнить запрос к метаданным.

            SELECT pg.datname, pg.datconnlimit
            FROM pg_database AS pg
            WHERE pg.datname = 'football_db';
            """
        
        if self.__sql_executer(sql_query) is not None:
            row = self.__cursor.fetchone()

            return [row]

    def scalar_function_call(self):

        print("%sВывести для каждого тренра информацию о нём, а также сумму денег,\n"
                "которую он мог заработать, если бы на протяжении всей карьеры имел такую же зарплату,\n"
                "как и сейчас. Вывести первые 10 записей.%s\n"
            %(green, base_color))

        sql_query = \
            """
            -- 5. Вызвать скалярную функцию.

            CREATE OR REPLACE FUNCTION amount_money(salary INT, work_experience INT)
            RETURNS DECIMAL AS $$
            BEGIN
                RETURN salary * work_experience;
            END;
            $$ LANGUAGE PLPGSQL;

            SELECT last_name, age, salary, work_experience, amount_money(salary, work_experience)
            FROM coach
            WHERE id < 11;
            """
        
        if self.__sql_executer(sql_query) is not None:

            row = self.__cursor.fetchone()
            table = list()

            while row is not None:
                table.append(row)
                row = self.__cursor.fetchone()

            return table

    def tabular_function_call(self):

        print("%sВернуть информацию о футболистах, средний рейтинг за игру которых равен 10,\n"
                "а возраст меньше 18.%s\n"
            %(green, base_color))

        sql_query = \
            """
            -- 6. Вызвать многооператорную табличную функцию.

            CREATE OR REPLACE FUNCTION best_young_footballers(age_f INT)
            RETURNS TABLE
            (
                first_name VARCHAR, 
                last_name VARCHAR, 
                age INT, 
                salary INT, 
                average_rating REAL
            )
            AS $$
            BEGIN
                DROP TABLE IF EXISTS tmp_table;

                CREATE TEMP TABLE IF NOT EXISTS tmp_table
                (
                    first_name VARCHAR, 
                    last_name VARCHAR, 
                    age INT, 
                    salary INT, 
                    average_rating REAL
                );

                INSERT INTO tmp_table(first_name, last_name, age, salary, average_rating)
                SELECT f.first_name, f.last_name, f.age, f.salary, f.average_rating
                FROM footballer as f
                WHERE f.age < age_f AND f.average_rating = 10;

                RETURN QUERY
                SELECT *
                FROM tmp_table;
            END;
            $$ LANGUAGE PLPGSQL;

            SELECT *
            FROM best_young_footballers(18);
            """
        
        if self.__sql_executer(sql_query) is not None:

            row = self.__cursor.fetchone()
            table = list()

            while row is not None:
                table.append(row)
                row = self.__cursor.fetchone()

            return table
    
    def stored_procedure_call(self):

        print("%sУвеличить тренеру с заданным id зарплаты на заданную сумму.%s\n"
            %(green, base_color))

        sql_query = \
            """
            -- 7. Вызвать хранимую процедуру.

            CREATE OR REPLACE PROCEDURE change_salary(id_coach INT, salary_increase INT)
            AS $$
            BEGIN
                UPDATE coach
                SET salary = salary + salary_increase
                WHERE id = id_coach;
            END;
            $$ LANGUAGE PLPGSQL;

            CALL change_salary(1, 505);

            SELECT id, first_name, last_name, age, salary
            FROM coach
            WHERE id = 1
            ORDER BY id;
            """
        
        if self.__sql_executer(sql_query) is not None:

            row = self.__cursor.fetchone()
            table = list()

            while row is not None:
                table.append(row)
                row = self.__cursor.fetchone()

            return table

    def system_functionc_call(self):

        print("%sВызвать системную функцию для вывода имени текущей базы данных.%s\n"
            %(green, base_color))

        sql_query = \
            """
            -- 8. Вызвать системную функцию.

            SELECT *
            FROM current_database();
            """
        
        if self.__sql_executer(sql_query) is not None:
            row = self.__cursor.fetchone()

            return row

    def create_new_table(self):

        print("%sСоздаем таблицу друзей футболистов.%s\n"
            %(green, base_color))

        sql_query = \
            """
            -- 9. Создать таблицу в базе данных, соответствующую тематике БД.

            DROP TABLE IF EXISTS friends_table;

            CREATE TABLE IF NOT EXISTS friends_table
            (
                id   INT NOT NULL PRIMARY KEY,
                name VARCHAR(32),
                age  INT NOT NULL,
                friend_id INT,
                check (age >= 16 and age <= 45)
            );
            """
        
        if self.__sql_executer(sql_query) is not None:
            print("%sSuccess%s" %(blue, base_color))


    def insert_into_new_table(self):

        print("%sВыполнить вставку данных в созданную таблицу друзей футболистов.%s\n"
            %(green, base_color))

        sql_query = \
            """
            -- 10. Выполнить вставку данных в созданную таблицу с использованием инструкции INSERT.
            
            INSERT INTO friends_table(id, name, age, friend_id) VALUES
            (1, 'Messi', 34, 3),
            (2, 'Ronaldo', 36, Null),
            (3, 'Neymar', 29, 4),
            (4, 'Mbappe', 22, 2);

            SELECT *
            FROM friends_table;
            """
        
        if self.__sql_executer(sql_query) is not None:

            row = self.__cursor.fetchone()
            table = list()

            while row is not None:
                table.append(row)
                row = self.__cursor.fetchone()

            return table
