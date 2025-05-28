from MongoDB.collection import collections

queries = {
    # // 1. Базовое равенство
    # // Найти все авто с налогом, равным 145.
    "pr58_task1": lambda: collections.UK_used_cars
    .find({"tax": 145})
    .limit(10),

    # // 2. Диапазонные запросы
    # // Найти все документы с налогом в диапазоне от 100 до 200.
    "pr58_task2": lambda: collections.UK_used_cars
    .find({"tax": {"$gte": 100, "$lte": 200}})
    .limit(10),

    # // 3. Логические операторы
    # // Найти все документы с налогом 145 или 200.
    "pr58_task3": lambda: collections.UK_used_cars
    .find({"tax": {"$in": [145, 200]}})
    .limit(10),

    # // 4. Текстовый поиск
    # // Найти модели машин с словом "max" в названии. Во всех регистрах.
    "pr58_task4": lambda: collections.UK_used_cars
    .find({"model": {"$regex": "max", "$options": "i"}})
    .limit(10),

    # // 5. Агрегация, пайплайны
    # // a.) Группировка: Посчитать количество документов для каждого уникального значения налога. Выведем 10 самых частых.
    "pr58_task5": lambda: collections.UK_used_cars
    .aggregate([
        {"$group": {"_id": "$tax", "count": {"$sum": 1}}},
        {"$sort": {"count": -1}},
        {"$limit": 10}
    ]),
    # // b.) Создадим список производителей и моделей. Без повторов
    "pr58_task6": lambda: collections.UK_used_cars
    .aggregate([
        {"$project": {"model": 1, "manufacturer": 1}},
        {"$group": {"_id": {"model": "$model", "manufacturer": "$manufacturer"}}},
        {"$sort": {"_id.manufacturer": 1}}
    ]),
    # // c.) Найдем самые экономичные гибриды
    "pr58_task7": lambda: collections.UK_used_cars
    .find({"fuelType": "Hybrid"})
}
