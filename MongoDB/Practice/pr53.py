from MongoDB.collection import collections

queries = {
    # 1. Найдите средний возраст из коллекции ich.US_Adult_Income
    "pr53_task1": lambda: collections.US_Adult_Income
    .aggregate([
        {"$group": {"_id": None, "avg_age": {"$avg": "$age"}}}
    ]),

    # Поменяв подключение к базе данных, создать коллекцию orders_NAME (для уникальности - добавим ваше имя в название) со свойствами id, customer, product, amount, city, используя следующие данные:
    "pr53_task2": lambda: collections.get_collection_via_connection(
        connection_name="atlas",
        db_name="sample_mflix",
        collection_name="orders_091224_max"
    ).insert_many(orders_data),

    "pr53_task3": lambda: collections.movies
    .find_one({}),

    # Для каждого значения Income_Category рассчитать процент клиентов с Attrition_Flag = "Attrited Customer".
    "pr53_task4": lambda: collections.BankChurners
    .aggregate([
        {
            "$group": {
                "_id": "$Income_Category",
                "total_clients": {"$sum": 1},
                "attrited_clients": {
                    "$sum": {
                        "$cond": [
                            {"$eq": ["$Attrition_Flag", "Attrited Customer"]},
                            1,
                            0
                        ]
                    }
                }
            }
        },
        {
            "$project": {
                "income_category": "$_id",
                "attrition_percentage": {"$round": [{
                    "$multiply": [
                        {"$divide": ["$attrited_clients", "$total_clients"]},
                        100
                    ]
                }, 2]},
                "_id": 0
            }
        },
        {
            "$sort": {"attrition_percentage": -1}
        }
    ]),

    "pr53_task5": lambda: collections.credit_cards
    .aggregate([
        {
            '$group': {
                '_id': '$Education_Level',
                'avg_age': {
                    '$avg': '$Customer_Age'
                }
            }
        }, {
            '$project': {
                'r_avg_age': {
                    '$round': [
                        '$avg_age', 2
                    ]
                }
            }
        }
    ]),

    # Определить средний кредитный лимит по категориям дохода.
    "pr53_task6": lambda: collections.credit_cards
    .aggregate([
        {"$group": {"_id": "$Income_Category", "avg_credit_limit": {"$avg": "$Credit_Limit"}}}
    ]),

    # Найти средний возраст клиентов и их средний кредитный лимит для каждого семейного статуса.
    "pr53_task7": lambda: collections.credit_cards
    .aggregate([
        {
            "$group": {
                "_id": "$Marital_Status",
                "avg_age": {"$avg": "$Customer_Age"},
                "avg_credit_limit": {"$avg": "$Credit_Limit"}
            }
        },
        {
            "$project": {
                "_id": 1,
                "avg_age": {"$round": ["$avg_age", 2]},
                "avg_credit_limit": {"$round": ["$avg_credit_limit", 2]}
            }
        }
    ]),

    # Найти самый часто встречающийся уровень образования среди клиентов
    "pr53_task8": lambda: collections.credit_cards
    .aggregate([
        {"$group": {"_id": "$Education_Level", "count": {"$sum": 1}}},
        {"$sort": {"count": -1}},
        {"$limit": 1}
    ]),

    # Найти среднее количество топлива, использованного за поездку.
    "pr53_task9": lambda: collections.bookings
    .aggregate([
        {"$addFields": {"total_fuel": {"$subtract": ["$init_fuel", "$final_fuel"]}}},
        {"$group": {"_id": None, "avg_fuel": {"$avg": "$total_fuel"}}},
        {"$project": {"avg_fuel": {"$round": ["$avg_fuel", 3]}}},
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
