import time
from llama_index.core import SQLDatabase
from llama_index.core.query_engine import NLSQLTableQueryEngine
from llama_index.core.settings import Settings
from llama_index.llms.ollama import Ollama
from llama_index.embeddings.huggingface import HuggingFaceEmbedding
import sqlalchemy as sa

def main():
    # Начало времени выполнения
    total_start_time = time.time()
    
    print("Запуск LLM SQL Query Engine...")
    print("=" * 50)
    
    # Подключаемся к postgres
    db_start_time = time.time()
    engine = sa.create_engine("postgresql://postgres:postgres@localhost:5432/eif_db")
    sql_database = SQLDatabase(engine)
    db_time = time.time() - db_start_time
    print(f"Подключение к БД: {db_time:.2f} сек")
    
    # Настраиваем LLM и Embedding модель
    setup_start_time = time.time()
    Settings.llm = Ollama(model="llama3", base_url="http://localhost:11434", request_timeout=300.0)
    Settings.embed_model = HuggingFaceEmbedding(model_name="BAAI/bge-small-en-v1.5")
    setup_time = time.time() - setup_start_time
    print(f"Настройка моделей: {setup_time:.2f} сек")
    
    # Создаем "движок" запросов к SQL
    engine_start_time = time.time()
    query_engine = NLSQLTableQueryEngine(
        sql_database=sql_database,
        tables=["test"], 
    )
    engine_time = time.time() - engine_start_time
    print(f"Создание движка: {engine_time:.2f} сек")
    
    # Формируем запрос на естественном языке
    print("=" * 50)
    question = "покажи всех сотрудников старше 60 лет. Show response as a list. Here is list format: <Order Number>. <Name> <age> <salary> <office>"
    question2 = "find offices whith most and least salary of employee"
    question3 = "summ salary of emplooyees of each office as total_salary. Show response as a list. Here is list format: <Order Number>. <Office Name> = <total_salary>"
    # question4 = "summ salary of emplooyees of each office as total_salary. Take 2 offices one with minimum and one with maximum total_salary. Show response as a list. Here is list format: <Order Number>. <Office Name> = <total_salary>"
    question5 = "summ salary of emplooyees of each office as total_salary. Do not use the `UNION` operator in sql query. Show response as a list. Here is list format: <Order Number>. <Office Name> = <total_salary>. Show only office with minimum and another office with maximum total_salary"
    question6 = """
Write a PostgreSQL query that finds:
1. The office with the highest total salary (sum of all salaries in that office)
2. The office with the lowest total salary (sum of all salaries in that office)

Return both results in a single query with two rows.
"""
    question7 = """
Write a PostgreSQL query that finds:
1. The office with the second highest total salary (sum of all salaries in that office)
2. The office with the second lowest total salary (sum of all salaries in that office)

Return both results in a single query with two rows.
"""

    question8 = """
Напиши PostgreSQL запрос, который найдет:
1. Офис со второй по величине общей суммой зарплат (сумма всех зарплат в этом офисе)
2. Офис со второй по наименьшей общей суммой зарплат (сумма всех зарплат в этом офисе)

Верни оба результата в одном запросе с двумя строками.
"""

    rules = """

Important rules:
- You MUST use subqueries for the ORDER BY and LIMIT/OFFSET operations
- You CANNOT use ORDER BY or LIMIT directly before UNION ALL
- Wrap each ordered limited query in parentheses as a subquery
- Use UNION ALL to combine the two results
- Use OFFSET 1 to get the second highest/lowest (skip the first result)

If you use UNION in your query, than structure should be:
SELECT * FROM (subquery for second highest salary) AS high_salary
UNION ALL 
SELECT * FROM (subquery for second lowest salary) AS low_salary;

The table is called "test" with columns: "office" and "salary"

Key points to emphasize:

    Use LIMIT 1 OFFSET 1 to get the second highest/lowest (skip first, take next)

    Each SELECT with ORDER BY/LIMIT/OFFSET must be wrapped in parentheses as a subquery

    Use SELECT * FROM (subquery) pattern

    UNION ALL connects the two subquery results

    No ORDER BY/LIMIT/OFFSET allowed immediately before UNION
"""
    
    print(f"Вопрос: {question}")
    
    query_start_time = time.time()
    # response = query_engine.query(question)
    response = query_engine.query(question + rules)
    query_time = time.time() - query_start_time
    print(f"Выполнение запроса: {query_time:.2f} сек")
    
    # ответ и сгенерированный запрос
    print("=" * 50)
    print(f"ОТВЕТ: {response}")
    print(f"СГЕНЕРИРОВАННЫЙ SQL: {response.metadata['sql_query']}")
    
    # Итоговое время
    total_time = time.time() - total_start_time
    print("=" * 50)
    print("ВРЕМЯ ВЫПОЛНЕНИЯ:")
    print(f"  - Подключение к БД:    {db_time:.2f} сек")
    print(f"  - Настройка моделей:   {setup_time:.2f} сек")
    print(f"  - Создание движка:     {engine_time:.2f} сек")
    print(f"  - Выполнение запроса:  {query_time:.2f} сек")
    print(f"  {'-'*30}")
    print(f"  ОБЩЕЕ ВРЕМЯ:          {total_time:.2f} сек")
    print("=" * 50)

if __name__ == "__main__":
    main()