
1)Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав 
в нем логин и пароль, который указывался при установке.


mysql> system dir C:\Windows
 Том в устройстве C имеет метку Windows
 Серийный номер тома: 7A49-F93C

 Содержимое папки C:\Windows

15.02.2022  16:51    <DIR>          .
15.02.2022  16:51    <DIR>          ..
/. 
Куча файлов и папок
./
07.12.2019  12:14    <DIR>          Migration
07.12.2019  12:14    <DIR>          ModemLogs
15.02.2022  16:50                38 my.cnf           #######################################################
13.11.2021  14:47           208 384 notepad.exe
07.12.2019  17:36    <DIR>          OCR
10.02.2022  18:43               469 ODBCINST.INI
07.12.2019  12:14    <DIR>          Offline Web Pages

              45 файлов     19 807 190 байт
              76 папок  66 243 407 872 байт свободно

mysql> system type C:\Windows\my.cnf
[client]
user=root
password=*******




2)
Создайте базу данных example, разместите в ней таблицу users, 
состоящую из двух столбцов, числового id и строкового name.


mysql> create database example;
Query OK, 1 row affected (0.02 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| example            |
| information_schema |
| mysql              |
| performance_schema |
| sakila             |
| sys                |
| world              |
+--------------------+
7 rows in set (0.01 sec)
mysql> show tables from example;
Empty set (0.00 sec)

mysql> use example
Database changed
mysql> create table users (id int, name text);
Query OK, 0 rows affected (0.06 sec)

mysql> show tables;
+-------------------+
| Tables_in_example |
+-------------------+
| users             |
+-------------------+
1 row in set (0.00 sec)

mysql> describe users;
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| id    | int  | YES  |     | NULL    |       |
| name  | text | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
2 rows in set (0.02 sec)




3)
Создайте дамп базы данных example из предыдущего задания, 
разверните содержимое дампа в новую базу данных sample.



mysql> exit
Bye

C:\Users\edive\OneDrive\Рабочий стол\Хута\БД>mysqldump example > sample.sql

C:\Users\edive\OneDrive\Рабочий стол\Хута\БД>dir
 Том в устройстве C имеет метку Windows
 Серийный номер тома: 7A49-F93C

 Содержимое папки C:\Users\edive\OneDrive\Рабочий стол\Хута\БД

16.02.2022  13:22    <DIR>          .
16.02.2022  13:22    <DIR>          ..
15.02.2022  16:18                22 hello.sql.txt
03.02.2022  02:10             1 319 Homework_1.sql.txt
16.02.2022  13:10             8 188 Homework_2.sql
16.02.2022  13:22             1 848 sample.sql
               4 файлов         11 377 байт
               2 папок  67 863 629 824 байт свободно


C:\Users\edive\OneDrive\Рабочий стол\Хута\БД>mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 24
Server version: 8.0.28 MySQL Community Server - GPL

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> create database sample;
Query OK, 1 row affected (0.01 sec)

mysql> \q
Bye

C:\Users\edive\OneDrive\Рабочий стол\Хута\БД>mysql sample < sample.sql

C:\Users\edive\OneDrive\Рабочий стол\Хута\БД>mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 26
Server version: 8.0.28 MySQL Community Server - GPL

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| example            |
| information_schema |
| mysql              |
| performance_schema |
| sakila             |
| sample             |
| sys                |
| world              |
+--------------------+
8 rows in set (0.00 sec)

mysql> show tables from sample;
+------------------+
| Tables_in_sample |
+------------------+
| users            |
+------------------+
1 row in set (0.00 sec)

mysql> describe users from sample;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'from sample' at line 1
mysql> use sample
Database changed
mysql> describe users;
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| id    | int  | YES  |     | NULL    |       |
| name  | text | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
2 rows in set (0.00 sec)



4)
(по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. 
Создайте дамп единственной таблицы help_keyword базы данных mysql. 
Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.

C:\Users\edive\OneDrive\Рабочий стол\Хута\БД>mysqldump mysql help_keyword --where="help_keyword_id < 100" > partdump.sql