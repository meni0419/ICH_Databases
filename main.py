import json
import argparse
from bson import ObjectId
from pygments import highlight
from pygments.lexers import JsonLexer
from pygments.formatters.terminal256 import Terminal256Formatter
from MongoDB.Practice.query_runner import queries
from MongoDB.Practice.db_connect import get_db
from pygments.style import Style
from pygments.token import Token

class CustomDarkStyle(Style):
    styles = {
        Token.Name.Tag:        '#ff5f5f',  # Ключи - мягкий красный
        Token.Literal.String:  '#5ddf8f',  # Строки - свежий зеленый
        Token.Literal.Number:  '#00afff',  # Числа - приятный синий
        Token.Punctuation:     '#d0d0d0',  # Скобки и разделители - серый
        Token.Text:            '#ffffff',  # Основной текст - белый
    }

parser = argparse.ArgumentParser(description="Выбор запроса к MongoDB")
parser.add_argument("query", choices=queries.keys(), help="Название запроса")
args = parser.parse_args()

class JSONEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, ObjectId):
            return str(obj)
        return super().default(obj)

# Получение данных
query_config = queries[args.query]
db = get_db(
    connection_name=query_config["connection"],
    db_name=query_config["db_name"]
)
result = query_config["query"](db)

# Форматирование и вывод
json_data = json.dumps(list(result), cls=JSONEncoder, indent=4, ensure_ascii=False)

# 1. Вывод в терминал с подсветкой
print(highlight(json_data, JsonLexer(), Terminal256Formatter(style=CustomDarkStyle)))

# 2. Сохранение в файл (добавляем этот блок)
with open('result.json', 'w', encoding='utf-8') as f:
    f.write(json_data)
print("\n\033[32mРезультат сохранён в result.json\033[0m")  # Зелёное сообщение