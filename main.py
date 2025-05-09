import json
import argparse
import importlib
import pkgutil
from datetime import datetime
from pathlib import Path
from pymongo.command_cursor import CommandCursor
import pymongo
from pymongo import results
from bson import ObjectId, Decimal128
from pygments import highlight
from pygments.lexers import JsonLexer
from pygments.formatters.terminal256 import Terminal256Formatter
from pygments.style import Style
from pygments.token import Token

from db_connect import get_db


class CustomDarkStyle(Style):
    styles = {
        Token.Name.Tag: '#ff5f5f',
        Token.Literal.String: '#5ddf8f',
        Token.Literal.Number: '#00afff',
        Token.Punctuation: '#d0d0d0',
        Token.Text: '#ffffff',
    }


def load_queries():
    queries = {}
    base_dir = Path(__file__).parent

    # Загружаем задания из Homeworks
    hw_package = base_dir / "MongoDB" / "Homeworks"
    for _, module_name, _ in pkgutil.iter_modules([str(hw_package)]):
        module = importlib.import_module(f"MongoDB.Homeworks.{module_name}")
        if hasattr(module, 'queries'):
            queries.update(module.queries)

    # Загружаем задания из Practice
    practice_package = base_dir / "MongoDB" / "Practice"
    for _, module_name, _ in pkgutil.iter_modules([str(practice_package)]):
        module = importlib.import_module(f"MongoDB.Practice.{module_name}")
        if hasattr(module, 'queries'):
            queries.update(module.queries)

    return queries


queries = load_queries()

# Остальной код остается без изменений
parser = argparse.ArgumentParser(description="Выбор запроса к MongoDB")
parser.add_argument("query", choices=queries.keys(), help="Название запроса")
args = parser.parse_args()


class JSONEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, ObjectId):
            return str(obj)
        if isinstance(obj, datetime):
            return obj.isoformat()
        if isinstance(obj, Decimal128):
            return float(obj.to_decimal())
        return super().default(obj)

# Получение данных
query_config = queries[args.query]
# db = get_db(
#     connection_name=query_config["connection"],
#     db_name=query_config["db_name"]
# )
query_func = queries[args.query]
result = query_func()

# Обработка разных типов результатов
if isinstance(result, (pymongo.cursor.Cursor, CommandCursor)):
    documents = list(result)
elif isinstance(result, pymongo.results.InsertManyResult):
    # Для операций вставки возвращаем только IDs
    documents = {"inserted_ids": result.inserted_ids}
elif result is None:
    documents = []
else:
    documents = [result] if not isinstance(result, list) else result


# Форматирование и вывод
json_data = json.dumps(
    documents,
    cls=JSONEncoder,
    indent=4,
    ensure_ascii=False,
    separators=(',', ': '),  # Улучшает читаемость
    sort_keys=True           # Сортирует ключи
)

# 1. Вывод в терминал с подсветкой
print(highlight(json_data, JsonLexer(), Terminal256Formatter(style=CustomDarkStyle)))

# 2. Сохранение в файл (добавляем этот блок)
with open('result.json', 'w', encoding='utf-8') as f:
    f.write(json_data)
print("\n\033[32mРезультат сохранён в result.json\033[0m")  # Зелёное сообщение