from MongoDB.collection import collections

queries = {
    # Найти рестораны на 'Staten Island' в названии которых есть слово pizza (Pizza и PIZZA тоже считаются).
    "hw20_task1": lambda: collections.restaurants
    .aggregate([
        {"$match":
            {"$and": [
                {"name": {"$regex": "pizza", "$options": "i"}},
                {"borough": "Staten Island"},
            ]}
        },
    ]),

    # Выведите названия 5 лучших по среднему значению отзывов ($avg: "$grades.score")
    "hw20_task2": lambda: collections.restaurants
    .aggregate([
        {"$unwind": "$grades"},
        {"$group": {"_id": "$name", "avg_grade": {"$avg": "$grades.score"}}},
        {"$sort": {"avg_grade": -1}},
        {"$limit": 5}
    ])
}