from MongoDB.collection import collections

queries = {
    # 1. Найдите средний возраст из коллекции ich.US_Adult_Income
    "hw4_task1": lambda: collections.US_Adult_Income
    .aggregate([
        {"$group": {"_id": None, "avg_age": {"$avg": "$age"}}}
    ]),

    # Поменяв подключение к базе данных, создать коллекцию orders_NAME (для уникальности - добавим ваше имя в название) со свойствами id, customer, product, amount, city, используя следующие данные:
    "hw4_task2": lambda: collections.get_collection_via_connection(
        connection_name="ich_editor",
        db_name="ich_edit",
        collection_name="orders_091224_max"
    ).insert_many(orders_data),

    # Найти сколько всего было совершено покупок
    "hw4_task3": lambda: collections.orders_091224_max
    .count_documents({}),

    # Найти сколько всего раз были куплены яблоки
    "hw4_task4": lambda: collections.orders_091224_max
    .count_documents({"product": "Apple"}),

    # Вывести идентификаторы трех самые дорогих покупок
    "hw4_task5": lambda: collections.orders_091224_max
    .find({}, {"_id": 1})
    .sort("amount", -1)
    .limit(3),

    # Найти сколько всего покупок было совершено в Берлине
    "hw4_task6": lambda: collections.orders_091224_max
    .count_documents({"city": "Berlin"}),

    # Найти количество покупок яблок в городах Берлин и Мадрид
    "hw4_task7": lambda: collections.orders_091224_max
    .count_documents({"city": {"$in": ["Berlin", "Madrid"]}}),

    # Найти сколько было потрачено каждым покупателем
    "hw4_task8": lambda: collections.orders_091224_max
    .aggregate([
        {"$group": {"_id": "$customer", "total": {"$sum": "$amount"}}}
    ]),

    # Найти в каких городах совершала покупки Ольга
    "hw4_task9": lambda: collections.orders_091224_max
    .aggregate([
        {"$match": {"customer": "Olga"}},
        {"$group": {"_id": "$city",
                    "sum_amount": {"$sum": "$amount"},
                    "count": {"$sum": 1}}},
        {"$sort": {"count": -1}}
    ]),

}

orders_data = [
    {
        "id": 1,
        "customer": "Olga",
        "product": "Apple",
        "amount": 15.55,
        "city": "Berlin"
    },
    {
        "id": 2,
        "customer": "Anna",
        "product": "Apple",
        "amount": 10.05,
        "city": "Madrid"
    },
    {
        "id": 3,
        "customer": "Olga",
        "product": "Kiwi",
        "amount": 9.60,
        "city": "Berlin"
    },
    {
        "id": 4,
        "customer": "Anton",
        "product": "Apple",
        "amount": 20.00,
        "city": "Roma"
    },
    {
        "id": 5,
        "customer": "Olga",
        "product": "Banana",
        "amount": 8.00,
        "city": "Madrid"
    },
    {
        "id": 6,
        "customer": "Petr",
        "product": "Orange",
        "amount": 18.30,
        "city": "Paris"
    }
]
