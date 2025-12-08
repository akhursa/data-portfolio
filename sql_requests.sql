ПРЕДМЕТНАЯ ОБЛАСТЬ 
В университете реализуется online тестирование по нескольким дисциплинам. Каждая дисциплина включает некоторое количество вопросов. 
Ответы на вопрос представлены в виде вариантов ответов, один из этих вариантов правильный. 
Студент регистрируется в системе, указав свое имя, фамилию и отчество. После этого он может проходить тестирование по одной или нескольким дисциплинам. 
Студент имеет несколько попыток для прохождения тестирования. 
Каждому студенту случайным образом выбирается набор вопросов по дисциплине и формируется индивидуальный тест. 
Студент отвечает на вопросы, выбирая один из предложенных вариантов ответа.

Структура и наполнение таблиц: https://stepik.org/lesson/310421/step/1?unit=292727

ЗАПРОС 1
Вывести, сколько попыток сделали студенты по каждой дисциплине, а также средний результат попыток, который округлить до 2 знаков после запятой.  
В результат включить название дисциплины, а также вычисляемые столбцы Количество и Среднее. Информацию вывести по убыванию средних результатов.

SELECT name_subject, COUNT(date_attempt) AS Количество, ROUND(AVG(result),2) AS Среднее
FROM attempt 
             right JOIN subject
             ON attempt.subject_id = subject.subject_id
GROUP BY name_subject
ORDER BY Среднее DESC;

ЗАПРОС 2
В таблицу attempt включить новую попытку для студента Баранова Павла по дисциплине «Основы баз данных». 
Установить текущую дату в качестве даты выполнения попытки.

INSERT INTO attempt (student_id, subject_id, date_attempt, result)
SELECT student_id, subject_id, NOW(), NULL
FROM 
student INNER JOIN attempt USING(student_id) 
INNER JOIN subject USING(subject_id)
WHERE name_student = "Баранов Павел" AND name_subject = "Основы баз данных";

SELECT * FROM attempt


ЗАПРОС 3 
Случайным образом выбрать три вопроса (запрос) по дисциплине, тестирование по которой собирается проходить студент, занесенный в таблицу attempt последним, 
и добавить их в таблицу testing. id последней попытки получить как максимальное значение id из таблицы attempt.

INSERT INTO testing (attempt_id, question_id, answer_id)
SELECT attempt_id, question_id, null

FROM
(
SELECT *
FROM attempt 
ORDER BY attempt_id DESC
LIMIT 1
)q_1
INNER JOIN
(
SELECT * FROM 
question
WHERE subject_id = 
(
SELECT subject_id
FROM attempt 
ORDER BY attempt_id DESC
LIMIT 1
)
ORDER BY RAND()
LIMIT 1
)q_2 
USING(subject_id);

INSERT INTO testing (attempt_id, question_id, answer_id)
SELECT attempt_id, question_id, null

FROM
(
SELECT *
FROM attempt 
ORDER BY attempt_id DESC
LIMIT 1
)q_1
INNER JOIN
(
SELECT * FROM 
question
WHERE subject_id = 
(
SELECT subject_id
FROM attempt 
ORDER BY attempt_id DESC
LIMIT 1
)
ORDER BY RAND()
LIMIT 1
)q_2 
USING(subject_id);

INSERT INTO testing (attempt_id, question_id, answer_id)
SELECT attempt_id, question_id, null

FROM
(
SELECT *
FROM attempt 
ORDER BY attempt_id DESC
LIMIT 1
)q_1
INNER JOIN
(
SELECT * FROM 
question
WHERE subject_id = 
(
SELECT subject_id
FROM attempt 
ORDER BY attempt_id DESC
LIMIT 1
)
ORDER BY RAND()
LIMIT 1
)q_2 
USING(subject_id);


SELECT * FROM testing
