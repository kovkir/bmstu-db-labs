from football_db import FootballDB
from color import base_color, red, yellow

MSG = "\n\t\t%sМеню\n\n"\
      "\t1. Выполнить скалярный запрос \n"\
      "\t2. Выполнить запрос с несколькими соединениями (JOIN) \n"\
      "\t3. Выполнить запрос с ОТВ(CTE) и оконными функциями \n"\
      "\t4. Выполнить запрос к метаданным \n"\
      "\t5. Вызвать скалярную функцию \n"\
      "\t6. Вызвать многооператорную табличную функцию \n"\
      "\t7. Вызвать хранимую процедуру \n"\
      "\t8. Вызвать системную функцию \n"\
      "\t9. Создать таблицу в базе данных, соответствующую тематике БД \n"\
      "\t10. Выполнить вставку данных в созданную таблицу с использованием инструкции INSERT \n"\
      "\t0. Выход \n\n"\
      "\tВыбор: %s"\
      %(yellow, base_color)


def input_command():
    try:
        command = int(input(MSG))
        print()
    except:
        command = -1
    
    if command < 0 or command > 10:
        print("%s\nОжидался ввод целого чилово числа от 0 до 10 %s"
            %(red, base_color))

    return command


def print_table(table):
    if table is not None:
        for row in table:
            print(row)


def main():
    football_db = FootballDB()
    command = -1

    while command != 0:
        command = input_command()

        if command == 1:
            table = football_db.scalar_query()

        elif command == 2:
            table = football_db.join_query()

        elif command == 3:
            table = football_db.cte_row_number_query()

        elif command == 4:
            table = football_db.metadata_query()

        elif command == 5:
            table = football_db.scalar_function_call()

        elif command == 6:
            table = football_db.tabular_function_call()

        elif command == 7:
            table = football_db.stored_procedure_call()

        elif command == 8:
            table = football_db.system_functionc_call()

        elif command == 9:
            table = football_db.create_new_table()

        elif command == 10:
            table = football_db.insert_into_new_table()
        else:
            continue
        
        print_table(table)


if __name__ == "__main__":
    main()
