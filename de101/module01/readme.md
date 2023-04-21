# Module 01: Роль Аналитики в Организации
[вернуться к содержанию](https://github.com/VladimirAmninov/datalearn):leftwards_arrow_with_hook:
## I. Superstore dashboard
**Задание**
Сделать дэшборд в `Excel` на основе датасета [Superstore](https://github.com/VladimirAmninov/datalearn/blob/main/de101/module01/Sample%20-%20Superstore.xls).

**Решение**
В `Excel` показалось делать скучно, поэтому задание было выполнено на `Python`. Скрипт в файле [superstore_streamlit_dashboard.py](https://github.com/VladimirAmninov/datalearn/blob/main/de101/module01/superstore_streamlit_dashboard.py).
Список необходимых библиотек находится в файле [requirements.txt](https://github.com/VladimirAmninov/datalearn/blob/main/de101/module01/requirements.txt)
Ссылка на задеплоенный дэшборд: https://superstore-dashboard-97qq.onrender.com
Открывается долго (около 2 минут), так как сделано на бесплатном сервисе render.com
 Трудности, с которыми столкнулся:
 | Описание     | Как решил |
| ----------- | ----------- |
| Непонятно как строить интерактивные дэшборды      | Изучал статьи и видео по теме создания интерактивных дэшбордов. Составил список библиотек: `Panel`, `Streamlit`, `Dash`. Решил делать с помощью библиотеки `Panel`, т.к. есть поддержка `JuputerLab`. Попытки не увенчались успехом. Следующая библиотека `Streamlit` не поддерживает `JupyterLab`, поэтому код писал в `VScode`. Оказалась простой и удобной библиотекой.      |
| Очень неудобный слайдер даты для этой задачи. Аггрегация делается по месяцам. Хочется. чтобы можно было выбирать в формате 'mm-yyyy', а не 'dd-mm-yyyy'   | Перевел `datetime` в `period`, сделал список возможных значений и вставил этот список в стандартный `select_slider` |
| Хочется сделать тепловую карту США со штатами, градиент цвета в зависимости от объема продаж  | `Plotly-express` имеет в своем арсенале такую возможность, но для этого нужны стандартизированные коды штатов. Подгрузил отдельно csv-файл с кодами и смерджил с основным датасетом.  |

![dashboard](/de101/module01/screenshots/dashboard.jpeg)



## II. Схема архитектуры аналитического решения
**Задание**
Нарисовать схему архитектуры аналитического решения выдуманной компании.

**Решение**

![scheme](/de101/module01/screenshots/scheme.jpeg)
