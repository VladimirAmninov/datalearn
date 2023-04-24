# Module 02: Базы данных и SQL
[вернуться к содержанию](https://github.com/VladimirAmninov/datalearn):leftwards_arrow_with_hook:
## I. Модель данных
**Задание**
Построить модель данных для хранилища в удобном для вас инструменте. 

**Решение**
Модель построил в [SQLdbm](https://sqldbm.com). Использовал Dimensional model. 
![Концептуальная модель](/de101/module02/pics/conceptual_scheme.jpeg)
![Физическая модель](/de101/module02/pics/physical_scheme.jpeg)

## II. Установка БД на локальном компьютере и в облаке, внесение данных в базу
**Задание**
Установить базу данных на выбор на локальном компьютере, в облаке и внести в них данные из Superstore dataset.

**Решение**
Выбрал базу данных `PostgreSQL` версии 15 (последняя на момент выполнения работы). 

*Установка на локальном компьютере `Ubuntu 22.04`*
* Обновляем пакеты командой (делаем все через терминал)
`$ sudo apt update`
* Затем устанавливаем командой 
`$ sudo apt install postgresql postgresql-contrib`
* Проверяем, что сервис запущен командой
`$ sudo systemctl status postgresql`
![Результат](/de101/module02/pics/psql_status.jpeg)
* Создаем базу и пользователя с паролем
`sudo -u postgres psql`
`CREATEDB mydb` - создал БД с именем mydb
`CREATE USER vladimir WITH PASSWORD '123'` - создал пользователя 'vladimir' с паролем '12345'


*Установка в облаке `AWS`*

* Создаем аккаунт на странице [AWS](https://aws.amazon.com)
* Переходим на страницу [Lightsail](https://lightsail.aws.amazon.com) в раздел 'Databases' и нажимаем кнопку 'Create database'
![](/de101/module02/pics/aws_dblist_screen.jpeg)
* Выбираем версию БД, вводим имя и выбираем характеристики сервера, где будет развернута БД. На момент выполнения данной работы доступны следующие версии PostgreSQL:
![](/de101/module02/pics/psql_versions.jpeg)
* Готово! Осталось подключиться к БД, используя данные со страницы сервера на сайте Lightsail AWS:
![](/de101/module02/pics/connect_details.jpeg) 

*Внесение данных через `DBeaver`*

Установил dbeaver-ce через магазин приложений Ubuntu.
Подключение к локальной БД и облачной идентичны - необходимо выбрать подключение PostgreSQL и указать хост (для локальной - localhost, для облачной - скопировать ссылку из сервиса), имя БД, юзера и пароль.
Внесение данных также идентично. Скрипты для наполнения базы:
Схема **stg**:
* [orders.sql](https://github.com/VladimirAmninov/datalearn/blob/main/de101/module02/scripts/orders.sql)
* [people.sql](https://github.com/VladimirAmninov/datalearn/blob/main/de101/module02/scripts/people.sql)
* [returns.sql](https://github.com/VladimirAmninov/datalearn/blob/main/de101/module02/scripts/returns.sql)

Схема **dw**
* [from_stg_to_dw.sql](https://github.com/VladimirAmninov/datalearn/blob/main/de101/module02/scripts/from_stg_to_dw.sql)


# III. Построение дэшборда в Google Looker Studio
**Задание**
Построить дэшборд в одном или нескольких из cервисов на выбор (Google Looker Studio, KlipFolio, Amazon QuichSight).

**Решение**
[Дэшборд](https://lookerstudio.google.com/s/rVe099hVxNw) строил в `Google Looker Studio`
![](/de101/module02/pics/looker_1.jpeg) 
![](/de101/module02/pics/looker_2.jpeg) 
![](/de101/module02/pics/looker_3.jpeg) 
