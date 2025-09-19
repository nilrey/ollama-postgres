from llama_index.core import SQLDatabase
from llama_index.core.query_engine import NLSQLTableQueryEngine
from llama_index.core.settings import Settings
from llama_index.llms.ollama import Ollama
from llama_index.embeddings.huggingface import HuggingFaceEmbedding
import sqlalchemy as sa

# Подключаемся к БД (ЗАМЕНИТЕ 'your_password' на реальный пароль!)
engine = sa.create_engine("postgresql://postgres:postgres@localhost:5432/eif_db")
sql_database = SQLDatabase(engine)

# Настраиваем LLM через Settings
Settings.llm = Ollama(model="llama3", base_url="http://localhost:11434", request_timeout=120.0)
Settings.embed_model = HuggingFaceEmbedding(model_name="BAAI/bge-small-en-v1.5")

# Создаем "движок" запросов к SQL
query_engine = NLSQLTableQueryEngine(
    sql_database=sql_database,
    tables=["test"], 
)

# Задаем вопрос на естественном языке
response = query_engine.query("the total amount of salary in the company")

# Печатаем результат
print(f"Ответ: {response}")
print(f"Сгенерированный SQL: {response.metadata['sql_query']}")