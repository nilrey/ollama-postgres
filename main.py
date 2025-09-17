import time
from llama_index.core import SQLDatabase
from llama_index.core.query_engine import NLSQLTableQueryEngine
from llama_index.core.settings import Settings
from llama_index.llms.ollama import Ollama
from llama_index.embeddings.huggingface import HuggingFaceEmbedding
import sqlalchemy as sa

def main():
    # Засекаем общее время выполнения
    total_start_time = time.time()
    
    print("Запуск LLM SQL Query Engine...")
    print("=" * 50)
    
    # 1. Подключаемся к БД
    db_start_time = time.time()
    engine = sa.create_engine("postgresql://postgres:postgres@localhost:5432/eif_db")
    sql_database = SQLDatabase(engine)
    db_time = time.time() - db_start_time
    print(f"Подключение к БД: {db_time:.2f} сек")
    
    # 2. Настраиваем LLM и Embedding модель
    setup_start_time = time.time()
    Settings.llm = Ollama(model="llama3", base_url="http://localhost:11434", request_timeout=120.0)
    Settings.embed_model = HuggingFaceEmbedding(model_name="BAAI/bge-small-en-v1.5")
    setup_time = time.time() - setup_start_time
    print(f"Настройка моделей: {setup_time:.2f} сек")
    
    # 3. Создаем "движок" запросов к SQL
    engine_start_time = time.time()
    query_engine = NLSQLTableQueryEngine(
        sql_database=sql_database,
        tables=["test"], 
    )
    engine_time = time.time() - engine_start_time
    print(f"Создание движка: {engine_time:.2f} сек")
    
    # 4. Задаем вопрос на естественном языке
    print("=" * 50)
    question = "the total amount of salary in the company"
    print(f"Вопрос: {question}")
    
    query_start_time = time.time()
    response = query_engine.query(question)
    query_time = time.time() - query_start_time
    print(f"Выполнение запроса: {query_time:.2f} сек")
    
    # 5. Печатаем результат
    print("=" * 50)
    print(f"ОТВЕТ: {response}")
    print(f"СГЕНЕРИРОВАННЫЙ SQL: {response.metadata['sql_query']}")
    
    # 6. Выводим итоговое время выполнения
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